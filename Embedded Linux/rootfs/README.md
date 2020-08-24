**Enabling autologin**

Depending on your distribution, you might need to modify your /etc/inittab or systemd files, the latter being more recent. In this project, we are running Ubuntu 18.04, which uses systemd. This file discusses how to apply the changes necessary in order to autologin and autostart the software wrapper.

**Modify serial-getty.service**

On Ubuntu 18.04, the getty service responsible for handling the login interface for serial connections is "serial-getty". To enable automatic login as the root user, we have to modify the service so that it automatically logs in as root instead of prompting for the username and password.

To do so, follow the steps below:

1. Open `/lib/systemd/system/serial-getty@.service`
2. Find `ExecStart=`
3. Replace the `ExecStart=...` line with `ExecStart=-/sbin/agetty --autologin root %I $TERM`
4. Save and exit the file.

Rebooting the system should automatically log you in as root when connected via the serial console at this point.

**Autostarting the software wrapper**

To autostart the software wrapper, we will need to automatically run a command on the "root" user login. To do so, we can modify the shell `.profile` file, which is processed once the user is logged in.

Execute the following command as root to add the necessary command to the root user `.profile` file:

```
echo "exec /etc/init.d/autorun.sh" >> ~/.profile
```

**Installing software wrapper dependencies**

The software wrapper requires PHP to be installed. Refer to the `Software_Wrapper/README.md` file for more information.