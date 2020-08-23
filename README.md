# GraduationProject_2019_2020
Pass keeper IC is used to securely save and mange all your passwords it connects to your computer using usb, it acts as your password manager. The user will use it as using the normal password manager that is built inside the web browser you login for the first time in a website the web browser asks if you want to save the new password, but instead of saving it locally it will send the account and password to our Pass keeper IC using usb, Pass keeper then will encrypt the password using 128-bit AES encryption and save it in it’s internal memory,  once you decided to login again to the same website, web browser will send only the account and pass keeper will search of the equivalent password in the internal CAM that will be encrypted using AES so it have to be decrypted before it encrypted again using session key generated for the site authentication.
## Structure 
**1.RTL**
**2.Linux**
**3.Chroumium**
**4.ASIC**

### RTL
The hardware used for this project mainly depends on the FPGA as a development board to implement the hardware core on it for testing and verification before ASIC implementation.
it is divided into two main part 
**1.CAM**
  CAM performs content matching rather than the address matching performed by standard memory cores. The content matching approach enables faster data searches than can be achieved by sequentially checking each address location in a standard memory for a particular value. The higher speed searches are achieved by using content values as an index into a database of address values. The additional ability to perform content compares in parallel enables even higher speed searches. A set of scripts is included with the CAM reference design that allow the customization of width, depth, memory type, and optional features.
**2.AES**
Advanced Encryption/Decryption Standard (AES)  is an approved cryptographic algorithm that can be used to protect electronic data. The AES can be programmed in software or built with pure hardware. However, Field Programmable Gate Arrays (FPGAs) offer a quicker and more customizable solution 

### Linux
we used linux as the base of most operations, as we need USB/IP protocol we used the internal drivers for this protocol to remove the headache of implementing it using ip core or rtl.
and it also used to interface with the custome hardware module to send input data and to retrive the outputs then use openssl to page encrypt the request and send it directly

### Chroumium
a custom web browser based on chroumium was created to remove the ssl page encryption from the web browser and insted send the data to the fpga and an web application was made to replace the old hardware manger implemented on the chroumium.

### ASIC
the design run and the netlist out put of the compiled design by ICC to generate the ASIC netlist

you can check full documentation [here](https://docs.google.com/document/d/1N3bH1BNMT8D9PLzdRzl_fX-cvAPWpY2PHtI4gaxJHfg/edit?usp=sharing)




