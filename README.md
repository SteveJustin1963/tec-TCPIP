# tec-TCPIP
## ESP8266 
- TCP/IP stack module intergrated to tec1 with ASM and MINT

![image](https://user-images.githubusercontent.com/58069246/170593318-4a198b77-e727-49a6-97fe-220a10a38ed1.png)
![image](https://user-images.githubusercontent.com/58069246/170593374-e48582d4-5d61-4f62-bd24-7362dcd355b2.png)


the ESP8266 is a low-cost Wi-Fi microchip with full TCP/IP stack and microcontroller capability produced by Chinese manufacturer, Espressif Systems. It is widely used in Internet of Things (IoT) applications and has become very popular among makers and hobbyists due to its low cost and ease of use. The ESP8266 can be programmed using the Arduino Integrated Development Environment (IDE) and can be used to create a variety of IoT projects, such as home automation systems, sensor networks, and web-connected devices. The ESP8266 can connect to the Internet via Wi-Fi and can be controlled and programmed remotely over the Internet. It is also capable of running independently as a standalone device, making it a versatile and powerful platform for a wide range of IoT applications.

The ESP8266 can be programmed using a variety of software development tools and environments. One of the most popular options is the Arduino Integrated Development Environment (IDE), which is a cross-platform application that allows you to write, upload, and debug code for the ESP8266. The Arduino IDE uses a programming language based on C++, and it includes a library of pre-written code called "sketches" that can be used to easily interact with the ESP8266 and other hardware.

In addition to the Arduino IDE, the ESP8266 can also be programmed using other software tools, such as the Espressif IoT Development Framework (ESP-IDF), which is a set of development tools provided by Espressif Systems specifically for the ESP8266. The ESP-IDF allows you to develop applications for the ESP8266 using a range of programming languages, including C, C++, and Python.

Other software tools that can be used to program the ESP8266 include the Eclipse Integrated Development Environment (IDE) and the Visual Studio Code editor. These tools provide a more advanced development environment and can be used to create more complex applications for the ESP8266.



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


