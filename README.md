# tec-TCPIP
## ESP8266 
- TCP/IP stack module intergrated to tec1 with ASM and MINT
 

![image](https://user-images.githubusercontent.com/58069246/170593318-4a198b77-e727-49a6-97fe-220a10a38ed1.png)
![image](https://user-images.githubusercontent.com/58069246/170593374-e48582d4-5d61-4f62-bd24-7362dcd355b2.png)


the ESP8266 is a low-cost Wi-Fi microchip with full TCP/IP stack and microcontroller capability produced by Chinese manufacturer, Espressif Systems. It is widely used in Internet of Things (IoT) applications and has become very popular among makers and hobbyists due to its low cost and ease of use. The ESP8266 can be programmed using the Arduino Integrated Development Environment (IDE) and can be used to create a variety of IoT projects, such as home automation systems, sensor networks, and web-connected devices. The ESP8266 can connect to the Internet via Wi-Fi and can be controlled and programmed remotely over the Internet. It is also capable of running independently as a standalone device, making it a versatile and powerful platform for a wide range of IoT applications.

The ESP8266 can be programmed using a variety of software development tools and environments. One of the most popular options is the Arduino Integrated Development Environment (IDE), which is a cross-platform application that allows you to write, upload, and debug code for the ESP8266. The Arduino IDE uses a programming language based on C++, and it includes a library of pre-written code called "sketches" that can be used to easily interact with the ESP8266 and other hardware.

In addition to the Arduino IDE, the ESP8266 can also be programmed using other software tools, such as the Espressif IoT Development Framework (ESP-IDF), which is a set of development tools provided by Espressif Systems specifically for the ESP8266. The ESP-IDF allows you to develop applications for the ESP8266 using a range of programming languages, including C, C++, and Python.

Other software tools that can be used to program the ESP8266 include the Eclipse Integrated Development Environment (IDE) and the Visual Studio Code editor. These tools provide a more advanced development environment and can be used to create more complex applications for the ESP8266.

## AT commands that can be used to control the ESP8266 over the serial connection:
- AT: This command is used to test the connection to the ESP8266. If the connection is working correctly, the ESP8266 should respond with an "OK" message.
- AT+RST: This command resets the ESP8266.
- AT+GMR: This command displays the version information for the ESP8266 firmware. 
- AT+CWMODE=<mode>: This command sets the WiFi mode of the ESP8266. The mode can be set to 1 (station mode), 2 (AP mode), or 3 (station+AP mode).
- AT+CWJAP=<ssid>,<pwd>: This command connects the ESP8266 to a WiFi network with the specified SSID (service set identifier) and password.
- AT+CWLAP: This command lists the available WiFi networks in the area.
- AT+CIPSTART=<type>,<addr>,<port>: This command starts a communication connection with a remote server. The type can be "TCP" or "UDP", the addr is the IP address or domain name of the server, and the port is the port number on the server.
- AT+CIPSEND=<len>: This command sends data to the server over the active connection. The len parameter is the length of the data to be sent.
- AT+CIPCLOSE: This command closes the active connection.

This is just a small sample of the AT commands that are available for the ESP8266. There are many more commands that can be used to configure and control the device. You can find more information about the available AT commands in the ESP8266 documentation.

## test
- use this web site https://www.exploreembedded.com/wiki/Arduino_Support_for_ESP8266_with_simple_test_code
- https://github.com/SteveJustin1963/tec-TCPIP/tree/master/docs/simple_test_code
- use the bitbangport of the tec-1 at 4800 and MINT


![image](https://user-images.githubusercontent.com/58069246/210539759-bd2e972f-a03a-46fb-92bb-c02f2fd0eb2c.png)


This code is written in the Arduino programming language and is designed to run on an ESP8266 microcontroller. The code uses the ESP8266WiFi library to scan for available Wi-Fi networks and display information about them.

The code begins by including the ESP8266WiFi library and defining a setup() function, which is called once when the program starts. In the setup() function, the code initializes the serial connection, sets the ESP8266 to "station" mode (which means it will connect to a Wi-Fi network as a client), and disconnects from any previously connected network.

The code then defines a loop() function, which is called repeatedly after the setup() function has finished. In the loop() function, the code starts a scan for available Wi-Fi networks by calling the scanNetworks() function. This function returns the number of networks found. If no networks are found, a message is printed to the serial port. If networks are found, the code prints the number of networks found and then iterates through the list of networks, printing the SSID (name) and RSSI (signal strength) of each network. The code also indicates if the network is encrypted or not by printing a "*" character. Finally, the code waits for 5 seconds before starting another scan.

The Arduino programming environment communicates with the ESP8266 microcontroller over a serial connection. In the code you provided, the line "Serial.begin(115200);" initializes the serial connection with a baud rate of 115200 bits per second. This baud rate is a measure of the speed at which data is transmitted over the serial connection, and it must match the baud rate of the device on the other end of the connection (in this case, the ESP8266).

Once the serial connection is established, the code can use the Serial object's functions (such as println(), print(), and so on) to send data back and forth between the Arduino and the ESP8266. For example, the line "Serial.println("Setup done");" sends a message over the serial connection to the ESP8266, which can be displayed on the serial monitor or used in some other way. Similarly, the ESP8266 can send data back to the Arduino over the serial connection by using the Serial object's functions. We can do the same with MINT.

## set the default to 4800 speed?
The baud rate of the serial connection can be set to any value that is supported by both the Arduino and the ESP8266. To set the baud rate to 4800 bits per second, you would simply need to change the argument of the Serial.begin() function to 4800. For example: ```Serial.begin(4800);```

This would set the baud rate of the serial connection to 4800 bits per second. Keep in mind that the baud rate must be the same on both the Arduino and the ESP8266, so you would need to make sure that the ESP8266 is also configured to use a baud rate of 4800 bits per second.

To tell the ESP8266 to use 4800; set the baud rate of the ESP8266 to 4800 bits per second, you can use the serial port configuration utility of your choice to connect to the ESP8266 and send it commands to change the baud rate. One way to do this is to use the Arduino IDE's serial monitor, which can be used to send and receive data over the serial connection. To use the serial monitor to set the baud rate of the ESP8266:

- Connect the ESP8266 to your computer using a USB-to-serial adapter.
- Open the Arduino IDE and select the correct serial port for the ESP8266.
- Click the "Serial Monitor" button in the Arduino IDE to open the serial monitor window.
- In the serial monitor window, select "4800" from the "Baud" drop-down menu.
- Type the command "AT+UART_DEF=4800,8,1,0,0" (without quotes) into the input field at the top of the serial monitor window and press "Send". This command will set the ESP8266's baud rate to 4800 bits per second.
- If the command was successful, the ESP8266 should respond with an "OK" message. If you don't receive an "OK" message, check to make sure that you have typed the command correctly and that the baud rate of the serial monitor is set to 4800.
- Keep in mind that you may need to reset the ESP8266 after changing the baud rate for the changes to take effect. You can do this by pressing the reset button on the ESP8266 or by disconnecting and reconnecting the power.

It's also worth noting that the baud rate of the serial connection can have an impact on the speed and reliability of the connection. Higher baud rates can allow for faster data transfer, but may also be more prone to errors due to noise or interference on the connection. Lower baud rates can be more reliable, but may be slower. It's generally a good idea to use the highest baud rate that is practical for your application, while also taking into account the limitations of the hardware and the specific requirements of your project.

## convert testcode.c to test.f

The code sets the baud rate of the serial connection to 115200 bits per second. The BAUD variable is predefined in Forth 83 and holds the current baud rate of the serial connection. The ! (store) operator is used to set the value of the BAUD variable to 115200. The code defines a Forth word (a unit of code that can be executed by name) called "setup". The word "setup" initializes the serial connection and sets the ESP8266 to "station" mode (which means it will connect to a Wi-Fi network as a client).

The begin...while...repeat loop at the beginning of the word is used to clear any characters that may be in the serial input buffer. The key? function reads a character from the serial input buffer and returns it, or 0 if the buffer is empty. The dup function duplicates the value that was read from the buffer. The 10 = function compares the value in the buffer to 10 (the ASCII code for the line feed character) and returns true if they are equal. The while loop continues to execute as long as the value in the buffer is equal to 10. The key drop function discards the value in the buffer.

The rest of the word sets the baud rate of the serial connection to 115200 bits per second, sets the WiFi mode to "station" mode, disconnects from any previously connected network, and waits for 100 milliseconds. Finally, the word prints the message "Setup done" followed by a newline to the serial port. the Forth word called "loop" that scans for WiFi networks and displays information about them. The word starts by printing the message "scan start" followed by a newline to the serial port. It then calls the SCAN_NETWORKS function, which scans for WiFi networks and returns the number of networks found. The dup function duplicates this value, and the 0 = function compares it to 0. If the value is equal to 0 (i.e. no networks were found), the if...then clause is executed, and the message "no networks found" is printed to the serial port. If the value is not equal to 0, the else clause is executed, and the message "networks found" followed by the number of networks found is printed to the serial port. The DO...LOOP loop iterates through the list of networks, starting with the first network (index 0). The loop variable I is initialized to 0 and on each iteration of the loop, the following actions are performed: code prints the value of I plus 1, followed by a colon and a space, followed by the value of SSID, followed by an open parenthesis, followed by the value of RSSI, and finally followed by a closing parenthesis. The . operator is used to print the values of I, SSID, and RSSI to the serial port. then checks the value of the ENC_TYPE_NONE variable and prints a space character if it is equal to 1 (indicating that the network is not encrypted), or a "*" character if it is equal to 0 (indicating that the network is encrypted). The IF...ELSE...THEN construct is used to select the appropriate action based on the value of ENC_TYPE_NONE. then prints a newline character to the serial port. then waits for 10 milliseconds before continuing with the next iteration of the loop. After the loop has finished processing all of the networks, the word prints the message "scan done" followed by a newline to the serial port, and then waits for 5000 milliseconds before starting another scan. the final section of code calls the "setup" and "loop" words to execute the main functions of the program. The "setup" word is called first to initialize the serial connection and set the ESP8266 to "station" mode. The "loop" word is then called repeatedly in a forever loop, which is implemented using the begin...again construct. This causes the "loop" word to be called repeatedly, resulting in the ESP8266 scanning for WiFi networks and displaying information about them at regular intervals.

In the line with variables I, SSID, and RSSI are being used to display information about each WiFi network that is found during the scan. The variable I is an index that is used to keep track of which network is being processed. It is initialized to 0 at the beginning of the loop and is incremented by 1 each time the loop iterates. The . (dot) operator is used to print the value of a variable to the serial port. For example, the line "I 1+ . ": " SSID . " (" RSSI . ")" " will print the value of I plus 1, followed by a colon and a space, followed by the value of SSID, followed by an open parenthesis, followed by the value of RSSI, and finally followed by a closing parenthesis. The SSID and RSSI variables are predefined variables that are part of the Forth 83 implementation for the ESP8266. The SSID variable holds the name (also known as the Service Set Identifier, or SSID) of the WiFi network, and the RSSI variable holds the signal strength (Received Signal Strength Indication, or RSSI) of the network. In this line of code, the values of these variables are being printed to the serial port as part of the output of the program.


## convert test.f to test..mint

## lets get on the internet with the tec1
 
To use the ESP8266 for TCP or UDP communication, you will need to use the AT commands provided by the ESP8266 firmware. These commands allow you to configure the ESP8266, send and receive data over the network, and perform other tasks. Here are some examples of how you can use the AT commands to establish a TCP or UDP connection with the ESP8266: 

To establish a TCP connection, you can use the AT+CIPSTART command. This command takes the following arguments:
- "TCP" or "UDP" to specify the protocol
- The remote IP address and port number to connect to
- The local IP address and port number to use
- "0" to close the connection after the data is sent, or "1" to keep the connection open

example, to establish a TCP connection to a remote server at IP address 192.168.1.100 on port 80, you could use the following command:
```AT+CIPSTART="TCP","192.168.1.100",80```

To send data over the TCP or UDP connection, you can use the AT+CIPSEND command. This command takes the following arguments:
- The number of bytes of data to send
- The data itself, in ASCII or hexadecimal format

 For example, to send a simple text message over the TCP connection, you could use the following command:
```
AT+CIPSEND=16
TEC1 says Hello!
```
 
To receive data over the TCP or UDP connection, you can use the AT+CIPRECV command. This command takes the following arguments:
- The maximum number of bytes to receive
- The timeout period in seconds

To receive up to 1024 bytes of data over the TCP connection with a timeout of 10 seconds, you could use the following command:
```AT+CIPRECV=1024,10```

To close the TCP or UDP connection, you can use the AT+CIPCLOSE command. This command takes no arguments and simply closes the current connection.
For example, to close the TCP connection, you can use the following command: ```AT+CIPCLOSE```

You can also use the AT+CIPMUX command to enable multiple connections on the ESP8266. With multiple connections enabled, you can use the AT+CIPSERVER command to start a TCP server on the ESP8266, which allows it to accept incoming connections from clients.
 
 
 

## ref 

- https://tldp.org/HOWTO/PPP-HOWTO/
- http://kc85.info/index.php/kcnet-75/z80-tcpip-159.html?showall=
- https://www.robotgear.com.au/Product.aspx/Details/1028-WiFi-Module-ESP8266-SOC-with-802-11-b-g-n-and-TCP-IP
- https://nurdspace.nl/ESP8266
- https://www.instructables.com/Using-the-ESP8266-module/
- http://www.esp8266.com/
- https://cdn.sparkfun.com/datasheets/Wireless/WiFi/Command%20Doc.pdf
- https://github.com/esp8266/esp8266-wiki/wiki
- https://github.com/jcmvbkbc/gcc-xtensa
- https://www.exploreembedded.com/wiki/Arduino_Support_for_ESP8266_with_simple_test_code


