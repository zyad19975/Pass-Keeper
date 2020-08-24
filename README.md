# PassKeeper
Pass keeper IC is used to securely save and mange all your passwords. It connects to your computer using USB and acts as your password manager.

Our modified browser (which is based on Chromium) comes with a GUI for the PassKeeper system that allows users to save username and password combinations securely on the FPGA. Users are able to select the user they would like to login with afterwards, and by clicking on the `Login` button on any website without filling the username/password fields, users are able to login securely without communicating the stored username/password combinations outside of the FPGA.

## Structure

### 1. RTL
The hardware used for this project mainly depends on the FPGA as a development board to implement the hardware core on it for testing and verification before ASIC implementation. This is divided into two main parts explained below.

#### 1.1 CAM
CAM performs content matching rather than the address matching performed by standard memory cores. The content matching approach enables faster data searches than can be achieved by sequentially checking each address location in a standard memory for a particular value. The higher speed searches are achieved by using content values as an index into a database of address values. The additional ability to perform content compares in parallel enables even higher speed searches. A set of scripts is included with the CAM reference design that allow the customization of width, depth, memory type, and optional features.

#### 1.2 AES
Advanced Encryption/Decryption Standard (AES)  is an approved cryptographic algorithm that can be used to protect electronic data. The AES can be programmed in software or built with pure hardware. However, Field Programmable Gate Arrays (FPGAs) offer a quicker and more customizable solution 

### 2. Linux
The FPGA comes with a Linux operating system, which uses the software wrapper explained inside `Embedded Linux/Software_Wrapper/README.md` for its operations.

### 3. Custom Browser (based on Chroumium)
A custom web browser based on Chroumium is used to communicate with the FPGA and send passwordless HTTP requests. The FPGA later returns the HTTP response from the web server after providing the username/password, which the browser processes and displays to the user, therefore allowing users to login without having to type the username/password combinations and keeping such information stored on the FPGA.

Moreover, the custom browser comes with a custom GUI which is used to manage stored users (i.e use for logging in or change password) or add new users.

### 4. ASIC

The design run and the netlist output of the compiled design by ICC to generate the ASIC netlist.

You can check the full documentation [here](https://docs.google.com/document/d/1N3bH1BNMT8D9PLzdRzl_fX-cvAPWpY2PHtI4gaxJHfg/edit?usp=sharing)




