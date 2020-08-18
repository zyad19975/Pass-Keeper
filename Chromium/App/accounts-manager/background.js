/**
 * Listens for the app launching then creates the window
 *
 * @see http://developer.chrome.com/apps/app.window.html
 */
var _socket_id = -1;
chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('index.html', {
    id: 'main',
    bounds: { width: 620, height: 500 }
  });
});
chrome.runtime.onMessage.addListener(function(request, sender, callback) {
    if (request.type == 'set_socket_id') {
        _socket_id = request.value;
    } else if (request.type == 'get_socket_id') {
        chrome.runtime.sendMessage({
            type: 'socket_id',
            name: "socket_id",
			value: _socket_id
        });
    }
});

