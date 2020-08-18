<?php
//$db_id = intval(readline());
//$file_path = "/home/gmounir/BOOTSTRAP/db/".$db_id;
$hostname = "giovannimounir.net";
$port = "443";
$port = intval($port);
function add_parameter($parameter, $value, $string)
{
	return preg_replace('/(^|&)'.$parameter.'=/', '$1'.$parameter.'='.$value, $string);
}
function aes_encrypt($input, $key) {
	$key = bin2hex($key);
	$input = bin2hex($input);
	while (strlen($input) < strlen($key))$input.="0";
    $ciphertext = openssl_encrypt(hex2bin($input),'aes-128-ecb',hex2bin($key),OPENSSL_RAW_DATA|OPENSSL_ZERO_PADDING);
    return bin2hex($ciphertext);
}
function aes_decrypt($ciphertext, $key) //ciphertext in hex
{
    return openssl_decrypt(hex2bin($ciphertext), 'aes-128-ecb', $key, OPENSSL_RAW_DATA|OPENSSL_ZERO_PADDING);
}
if ($port)
{
	//if (true || file_exists($file_path))
	while (true)
	{
		foreach (glob("Z:\\*.request") as $fname)
		{
			echo "Processing " . $fname . "\r\n";
			$input = array();
			$content_length = 0;
			$file = fopen($fname, "r");
			$i = 0;
			//while (($line = readline()) != "EOF")
			while(! feof($file))
			{
				$i++;
				//$line = rtrim(fgets($file),"\n\r"); 
				$line = fgets($file);
				if ($i == 1 && !preg_match("/^POST /", $line)) {unlink($fname); continue;}
				if ($line)
				{
					$input[] = str_replace("\r", "", str_replace("\n", "", $line));
					if (preg_match("/content-length: (\d+)/i", $line, $matches))
						$content_length = intval($matches[1]);
				}
					
			}
			if (!$input) {unlink($fname);continue;}
			while (strlen($input[count($input)-1]) < 5)
				unset($input[count($input)-1]);
			
		if ($content_length)
		{
			$input[count($input)-1] = substr($input[count($input)-1], 0, $content_length);
		}
			$input[count($input)-1] = add_parameter("username", trim(hex2bin(ltrim($argv[1], "0"))), $input[count($input)-1]);
			$input[count($input)-1] = add_parameter("password", trim(aes_decrypt($argv[2], $argv[3])), $input[count($input)-1]);
		$data_file = sys_get_temp_dir()."\\SC_".uniqid();
	//	$out_file = sys_get_temp_dir()."/SCO_".uniqid();
		$output = preg_replace("/\nContent-Length: \d+/i", "\nContent-Length: ". strlen($input[count($input)-1]), implode("\n", $input));
		preg_match('/\nHost: (.*)/', $output, $matches);
		if ($matches)
		{
			$hostname = $matches[1];
		}
		if (file_put_contents($data_file, $output))
		{
			exec("powershell cat " . escapeshellarg($data_file) . " | openssl s_client -ign_eof -connect ".escapeshellarg($hostname . ":".$port) ." 2>&1", $output);
			$output[count($output)-1] = "closed";
			$output = implode("\n", $output);
			preg_match('/---\n(HTTP.*?)(closed)/s', $output, $matches);
			echo " - Writing to " . substr($fname,0, -8).".output\r\n";
			print_r($matches[1]);
			file_put_contents(substr($fname,0, -8).".output", $matches[1]);
		}
		unlink($fname);
		unlink($data_file);
		sleep(2);
		}
	}
	//unlink($out_file);
}
?>