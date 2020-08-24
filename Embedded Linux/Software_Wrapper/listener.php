<?php
error_reporting(0);
define("USER_FILE", "/root/user.txt");
define("USERS_FILE", "/root/users.db");
//INIT
if (!file_exists(USER_FILE)) touch(USER_FILE);
if (!file_exists(USERS_FILE)) touch(USER_FILE);
//
//HELPER FUNCTIONS
function response($output)
{
	echo json_encode($output)."\n";
}
function filter_whitespaces($input)
{
	return trim(preg_replace('/\s\s+/', ' ', $input));	
}
function read_line()
{
	return filter_whitespaces(readline());
}
function filter_newline($input)
{
	return str_replace("\r", "", str_replace("\n", "", $input));
}
function add_parameter($parameters, $value, $string)
{
	foreach ($parameters as $parameter)
	{
		if (preg_match("/(^|&)".$parameter."=/i", $string))
			return preg_replace('/(^|&)'.$parameter.'=(.*?)($|&)/i', '$1'.$parameter.'='.$value.'$3', $string);
	}
	return $string;
}
function retrieve_password($username)
{
	$fhandle = fopen(USERS_FILE,"r");
	$password = "";
	while(($line = fgets($fhandle)) !== false)
	{
		$line = filter_whitespaces($line);
		if ($line == $username)
		{
			$password = filter_whitespaces(fgets($fhandle));
			break;
		}
	}
	if ($fhandle)
		fclose($fhandle);
}
	return $password;
//
$allowed_functions = array("heartbeat", "list_users", "get_current", "set_current", "add_account", "encrypt_request");
//GLOBAL PARAMETERS
$username_parameters = array("username", "email", "account", "log");
$password_parameters = array("password", "pass", "passwd", "pwd");
//

//BEGIN ALLOWED FUNCTIONS
function encrypt_request()
{
	global $username_parameters, $password_parameters;
	$hostname = read_line();
	$port = read_line();
	$username = get_current();
	$password = retrieve_password($username);
	
	$input = array();
	$content_length = 0;
	$request_index = 0;
	$i = 0;
	$empty_new_lines = 0;
	while($empty_new_lines < 4)
	{
		$line = readline();
		if ($i == 0 && !preg_match("/^POST /", $line)) { return; }
		if ($line == "\r\n") continue;
		$line = filter_newline($line);
		if ($empty_new_lines > 2) $input[] = "\n";
		if ($line)
		{
			$empty_new_lines = 0;
			$input[] = $line;
			if (preg_match("/content-length: (\d+)/i", $line, $matches))
			$content_length = intval($matches[1]);
			$i++; 
		}
		else
		{
			if (!$empty_new_lines && $content_length)
				$request_index = $i;
			$empty_new_lines++;
		}
	}
	if (!$input) { return; }
	
	if ($content_length)
	{
		$request_line = "";
		for ($i = $request_index; $i < count($input); $i++)
		{
			$request_line .= $input[$i];
			unset($input[$i]);
		}
		
		$input = array_values($input);
		$i = count($input);
		while (!filter_newline($input[$i]))
		{
			unset($input[$i]);
			$i--;
		}
		$input[] = substr($request_line, 0, $content_length);
	}
	$input = array_values($input);
	$input_before = $input[count($input)-1];
	$input[count($input)-1] = add_parameter($username_parameters, $username, $input[count($input)-1]);
	$input[count($input)-1] = add_parameter($password_parameters, $password, $input[count($input)-1]);
	if ($input_before == $input[count($input)-1])
	{
		echo "\nBEGIN_RESPONSE\n";
		echo "\nEND_OF_RESPONSE\n";
	}
	else
	{
		$input[count($input)-1] = "\n".$input[count($input)-1]."&";
		
		$data_file = sys_get_temp_dir()."/SC_".uniqid();
		$output = trim(preg_replace("/\nContent-Length: \d+/i", "\nContent-Length: ". strlen($input[count($input)-1]), implode("\n", $input)), "\n\r ");
		$output .= "\n";
		preg_match('/\nHost: (.*)/', $output, $matches);
		if ($matches)
		{
			$hostname = $matches[1];
		}
		if (file_put_contents($data_file, $output))
		{
			echo "\nBEGIN_RESPONSE\n";
			exec("cat " . escapeshellarg($data_file) . " | timeout 50s openssl s_client -ign_eof -crlf -connect ".escapeshellarg($hostname . ":".$port) ." 2>&1", $output);
			$output[count($output)-1] = "closed";
			$output = implode("\n", $output);
			preg_match('/---\n(HTTP.*?)(closed)/s', $output, $matches);
			echo $matches[1];
			echo "\nEND_OF_RESPONSE\n";
		}
		unlink($data_file);
	}
}
function heartbeat()
{
	return true;
}
function list_users()
{
	$fhandle = fopen(USERS_FILE,"r");
	$i = 0;
	$accounts = [];
	while(($line = fgets($fhandle)) !== false)
	{
		$i++;
		if ($i%2 != 0)
		{
			$line = trim(preg_replace('/\s\s+/', ' ', $line));
			$accounts[] = $line;
		}
	}
	if ($fhandle)
		fclose($fhandle);
	return $accounts;
}
function get_current()
{
	$handle = fopen(USER_FILE, "r");
	$line = filter_whitespaces(fgets($handle));
	return $line;
}
function set_current()
{
	$username = read_line();
	return file_put_contents(USER_FILE, $username)? true : false;
}
function add_account()
{
	$username = read_line();
	$password = read_line();
	//if (in_array($username, list_users())) return "Username already exists.";
	if (strlen($username) <= 16 && strlen($password) <= 16) //max: 16 chars for each
	//comment above to allow more than 16 characters (not supported by hardware)
	{
		$fhandle = fopen(USERS_FILE,"r");
		$i = 0;
		$contents = ""; //bad practice for large files, will be replaced later by HW function anyway
		$found = false;
		while(($line = fgets($fhandle)) !== false)
		{
			$i++;
			$contents .= $line;
			if ($i%2 != 0)
			{
				if (filter_newline($line) == $username)
				{
					fgets($fhandle); //skip 1
					$contents .= $password."\n";
					$found = true;
				}
			}
		}
		if ($fhandle)
			fclose($fhandle);
		return $found? file_put_contents(USERS_FILE, $contents) : file_put_contents(USERS_FILE, $username."\n".$password."\n", FILE_APPEND)? true : false;
	}
	return false;
}
//END ALLOWED FUNCTIONS
while(true)
{
	$cmd = readline();
	if (in_array($cmd, $allowed_functions) && function_exists($cmd))
		response($cmd());
	else
		response(""); //Bad request.
}
?>