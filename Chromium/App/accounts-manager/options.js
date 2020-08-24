var _socket_id = -1;
var _current_username = "";
function ab2str(buf) {
  return String.fromCharCode.apply(null, new Uint8Array(buf));
}
function str2ab(str) {
  var buf = new ArrayBuffer(2048);
  var bufView = new Uint16Array(buf);
  for (var i=0, strLen=str.length; i < strLen; i++) {
    bufView[i] = str.charCodeAt(i);
  }
  return buf;
}
function sanitize_function(fn)
{
	return (typeof fn === "function")? fn : (function(){});
}
function create_sock(callback)
{
	callback = sanitize_function(callback);
	if (_socket_id != -1)
	{
		chrome.socket.disconnect(_socket_id);
		_socket_id = -1;
	}
	chrome.socket.create('tcp', null, function(createInfo){
		_socket_id = createInfo.socketId;
		chrome.runtime.sendMessage({
            type: 'set_socket_id',
			value: _socket_id
        });
		chrome.socket.connect(_socket_id, "localhost", 7775, callback);
	});
	
}
function write_data(data, callback)
{
	callback = sanitize_function(callback);
	if (_socket_id == -1)
	{
		create_sock(function(){write_data(data, callback);});
	}
	else
	{
		chrome.socket.write(_socket_id, str2ab(data), callback);
	}
}
function read_data(callback)
{
	callback = sanitize_function(callback);
	if (_socket_id == -1)
	{
		create_sock(function(){read_data(callback);});
	}
	else
	{
		var _read_data = "";
		chrome.socket.read(_socket_id, 2048, function(readInfo){
			callback(ab2str(readInfo.data));
		});
	}
}
function show_error(error, div = "#header_div", disableInput = true)
{
	
	$("table").addClass('hide');
	$(div).html('<div class="ui negative message"><div class="header">An error occurred</div><p>'+error+'</p></div>');
	$(div).removeClass("hide");
	if (disableInput)
		$(".add_btn").addClass("disabled");
	
}
function get_json(str, div = "#header_div") {
    try {
        var obj = JSON.parse(str);
		return obj;
    } catch (e) {
		show_error("Received an invalid response from server. Please restart this app to try again.", div);
        return false;
    }
    return false;
}
function unfilter_username(username, hard = false)
{
	username = _.unescape(username);
	if (hard) 
	{
		username = username.replace('_', ' ');
		username = username.replace(/\\(["'\/\\])/g, "$1");
	}
	return username;
}
var users = {};
function retrieve_username_byindex(index)
{
	return users[index];
}
function get_username_index(username)
{
	var keys = Object.keys(users);
	for (var i =0; i <keys.length; i++)
	{
		if (users[keys[i]] == username)
			return keys[i];
	}
}
function index_username(username)
{
	var _uniqid = uniqid();
	while (typeof users[_uniqid] !== "undefined") 
		_uniqid = uniqid();
	users[_uniqid] = username;
	return _uniqid;
}
function uniqid()
{
	var n = Math.floor(Math.random() * 11);
	var k = Math.floor(Math.random() * 1000000);
	return n + k;
}
function filter_username(username, hard = false)
{
	if (hard)
	{
		username = username.replace(/(["'\/\\])/g, "\\$1");
		username = username.replace(' ', '_');
	}
	username = _.escape(username);
	return username;
}
function rand_str(length = 16) {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}
function DisplayAccount(username)
{
	var orig_username = username;
	username = filter_username(username, true);
	var username_id = index_username(username);
	$("tbody").append('<tr id="tr_'+username_id+'"><td data-label="account">'+filter_username(orig_username, false)+'</td><td style="text-align:right;"><button class="ui primary button set-btn" data-username="'+username_id+'">Set</button></td></tr>');
}
function GetCurrentAccount(callback, new_sock = true)
{
	socket_fn(function(){write_data("get\n", read_data(callback));}, new_sock);
}
function socket_fn(_fn, new_sock)
{
	if (new_sock)
		create_sock(_fn);
	else 
		_fn();
}
function set(username, new_sock = true)
{
	preload();
	username = unfilter_username(username, true);
	socket_fn(function(){write_data("set\n", function(){ write_data(unfilter_username(username, true)+"\n", function(){RefreshAccounts();}); });}, true);
}
function DisplayAccounts(data)
{
	GetCurrentAccount(function(current_username){
		accounts = get_json(data, "#table_preloader");
		preload(false);
		if (accounts.length == 0)
		{
			show_error("No accounts available yet. Click on Add to add an account.", "#errors", false);
		}
		for (var i = 0; i < accounts.length; i++) {
			DisplayAccount(accounts[i]);
		}
		_current_username = get_json(current_username);
		var _current_username_id = get_username_index(_current_username);
		$(".set-btn").click(function(){
			set(retrieve_username_byindex($(this).data("username")));
		})
		if ($("#tr_"+_current_username_id).length > 0)
			$("#tr_"+_current_username_id).addClass("active");
	}, false);
	
}
function init()
{
	chrome.runtime.sendMessage({
    type: 'get_socket_id', name: "OK"});
	chrome.runtime.onMessage.addListener(function(request, sender, callback) {
		if (request.type == 'socket_id') {
			_socket_id = request.value;
			start();
		}
	});
}
function start()
{
	RefreshAccounts();
}
function AddAccount(username, password, new_sock = true)
{
	socket_fn(function(){ write_data("add\n", function(){ write_data(username+"\n", function(){ write_data(password+"\n", function(){ RefreshAccounts()} ); }); }); }, new_sock);
}
function preload(enable = true)
{
	users = {};
	if (enable)
	{
		$(".modal .close").click();
		$("#username").val("");
		$("#password").val("");
		$("#username").removeClass('disabled');
		$("#password").removeClass('disabled');
		$("#errors").addClass('hide');
		$("#table_preloader").removeClass("hide");
		$("tbody").html('');
		$("#save").removeClass("loading");
	}
	else
	{
		$("table").removeClass('hide');
		$("#table_preloader").addClass("hide");
	}
}
function RefreshAccounts(callback = DisplayAccounts, new_sock = true)
{
	preload();
	socket_fn(function(){write_data("list\n", read_data(callback))}, new_sock);
}
$(".add_btn").click(function(e)
{
	e.preventDefault();
	$('.account.modal').modal('setting', 'transition', 'scale').modal('show');
});
const togglePassword = document.querySelector('#togglePassword');
const password = document.querySelector('#password');
togglePassword.addEventListener('click', function (e) {
	const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
	password.setAttribute('type', type);
});
$("#save").click(function(){
	var username = $("#username").val();
	var password = $("#password").val();
	$("#username").addClass('disabled');
	$("#password").addClass('disabled');
	$("#save").addClass("loading");
	AddAccount(username, password);
});
init();