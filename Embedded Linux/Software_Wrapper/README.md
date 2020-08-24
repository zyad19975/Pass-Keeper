###Software

The software wrapper is used to store/retrieve users and process SSL requests.

###Dependencies

1. PHP
2. openssl

To install the dependencies, execute the following command as root (Debian-based systems):

```
apt-get install php php-cli openssl
```

###Commands

All outputs are in JSON format.
Each input is prompted for in a new line in the order specified.

|Command|Description|Input|Output|
|----------------|-------------------------------|-----|-----------------------------|
|heartbeat|Always returns true, used to check for availability.            |-|`true`|
|list_users|Returns the list of stored users.|-            |Array of users|
|get_current|Returns the current username|-| String|
|set_current|Sets the current username|username| true/false|
|add_account|Adds a new user and password combination to the list of stored users|username,password| true/false|
|encrypt_request|Sends an HTTP request after combining the currently selected username (same as `get_current`) and password combination into possible login parameters|hostname,port,request| HTTP response from target server|

**Note**: the `encrypt_request` depends on the `openssl` and `cat` executables (these usually come pre-installed with your Linux distribution).