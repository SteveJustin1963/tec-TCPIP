# tec-TCPIP

 # part 1
 # enc28j60
 
 https://core-electronics.com.au/enc28j60-ethernet-lan-network-module.html?gad_source=1&gad_campaignid=17417005429&gbraid=0AAAAADlEpP4lZgD6VQR9WW1M241iK5vSX&gclid=CjwKCAjw24vBBhABEiwANFG7y-MgFZBhww8qVogrerN-_fBCL2bJOUB28TFlYR4eJxCVbPM_B35SCRoCUDEQAvD_BwE


Building a simple **TCP/IP stack for an 8-bit computer** is a challenging but achievable task if you work within strict constraints and understand the networking layers deeply.

Here’s a clear breakdown of **what’s absolutely necessary**, **what can be simplified or skipped**, and **what you’ll need in terms of hardware/software**.

---

### ✅ 1. **Decide Your Protocol Scope**

You **do not need full TCP/IP**. For an 8-bit machine, it's very common to **skip TCP** entirely and use **UDP/IP or just ICMP/IP (like Ping)**.

**Common minimal stack layers:**

```
Application Layer → (UDP optional) → IP → ARP → Ethernet
```

If you can do **IP + UDP**, you can:

* Send/receive packets
* Build DNS, NTP, basic web clients (e.g., HTTP GET)
* Skip complex TCP state tracking (SYN, ACK, timeouts)

---

### ✅ 2. **Minimum Components to Implement**

Here’s a checklist of what you need to implement, assuming you're doing **UDP over IP**:

#### 🔹 A. **Ethernet Driver**

* Read/write raw frames to/from Ethernet controller (like ENC28J60 or WIZnet W5100)
* Handle MAC addresses
* Interface via SPI (common for 8-bit)

#### 🔹 B. **ARP (Address Resolution Protocol)**

* Respond to ARP requests
* Issue ARP requests to find MAC of router/gateway

#### 🔹 C. **IP Layer**

* Build/send IP headers (with checksum)
* Receive and validate IP packets (parse header, check length and checksum)
* Handle fragmentation (usually ignored for simplicity)

#### 🔹 D. **ICMP (Optional but useful)**

* Reply to ping (ICMP echo request)
* Helps test if your device is alive

#### 🔹 E. **UDP Layer**

* Build UDP headers (checksum optional)
* Handle ports
* Send/receive data to/from application

#### 🔹 F. **Application Layer (Your Code)**

* Example: Simple HTTP GET, NTP time query, or telemetry packet sender

---

### ✅ 3. **Memory Considerations**

You're on an 8-bit computer — likely with **a few KB of RAM**.

Tips:

* Use fixed-size packet buffers (e.g., 512 bytes)
* Avoid dynamic allocation
* Process data *in place* as much as possible

---

### ✅ 4. **Hardware You’ll Need**

* **Microcontroller or 8-bit CPU system** (e.g., AVR, Z80, 6502, 8051, or similar)
* **Ethernet controller**:

  * ✅ \[ENC28J60 (Ethernet over SPI)] — Cheap, but needs full stack on your side
  * ✅ \[WIZnet W5500/W5100] — Has built-in TCP/UDP stack (offloads your job)
  * ⛔ Don't use USB Ethernet — too complex for 8-bit unless you use a host shield

---

### ✅ 5. **Recommended Simplifications**

* Use **static IP** (no DHCP)
* Use **only UDP**
* Skip **DNS**, hardcode IPs (or add minimal DNS resolver later)
* Skip TCP — it's memory-heavy and needs timers, retransmission, sliding window, etc.

---

### ✅ 6. **Sample Projects to Learn From**

* **Adam Dunkels' uIP** (micro-IP): Very compact TCP/IP stack for 8/16-bit

  * [https://dunkels.com/adam/uip/](https://dunkels.com/adam/uip/)
* **RetroStack**: For Z80/6502-based homebrew computers
* **Mini-IP** or “IP stack in 512 bytes” style projects

---

### 🧰 Tools You Might Use

* **Wireshark** (to sniff and analyze your packets)
* **Tasm/CC65/SDCC/AVR-GCC** (to compile for your 8-bit platform)
* **Logic analyzer** (to debug SPI or Ethernet frames)

---

### 🧠 Summary: Absolute Minimum TCP/IP Stack for 8-bit

| Layer       | What You Need                                  |
| ----------- | ---------------------------------------------- |
| Ethernet    | Frame send/receive, MAC handling               |
| ARP         | Resolve gateway MAC                            |
| IP          | Build/send IP headers, checksum, route to port |
| UDP (opt.)  | Send/receive to fixed ports, lightweight       |
| Application | Custom logic (e.g. send log, ping, etc.)       |

---

 # part2

 # ESP8266 WiFi Module Integration with TEC-1 using MINT

![ESP8266 Module](https://user-images.githubusercontent.com/58069246/170593318-4a198b77-e727-49a6-97fe-220a10a38ed1.png)

## Introduction

The ESP8266 is a low-cost Wi-Fi microchip with full TCP/IP stack and microcontroller capability produced by Espressif Systems. This guide details how to integrate the ESP8266 with the TEC-1 computer using MINT (Minimalist INTerpreter), allowing your TEC-1 to connect to WiFi networks and access the internet.

## Table of Contents
- [Hardware Overview](#hardware-overview)
- [Connection to TEC-1](#connection-to-tec-1)
- [Understanding MINT Programming](#understanding-mint-programming)
- [Communication with ESP8266](#communication-with-esp8266)
- [AT Command Set for ESP8266](#at-command-set-for-esp8266)
- [Complete WiFi Scanner Implementation](#complete-wifi-scanner-implementation)
- [Internet Connectivity with ESP8266](#internet-connectivity-with-esp8266)
- [Troubleshooting](#troubleshooting)
- [References](#references)

## Hardware Overview

The ESP8266 provides the TEC-1 with:
- 802.11 b/g/n WiFi connectivity
- TCP/IP stack
- UART interface for communication with the TEC-1
- Up to 17 GPIO pins (depending on model)
- Operating voltage: 3.3V (important: level shifting may be required)

![ESP8266 Pinout](https://user-images.githubusercontent.com/58069246/170593374-e48582d4-5d61-4f62-bd24-7362dcd355b2.png)

## Connection to TEC-1

To connect the ESP8266 to the TEC-1:

1. Connect the ESP8266's RX to the TEC-1's TX (with appropriate level shifting if needed)
2. Connect the ESP8266's TX to the TEC-1's RX (with appropriate level shifting if needed)
3. Connect VCC to 3.3V
4. Connect GND to ground
5. Connect CH_PD (chip enable) to 3.3V

**Important**: The ESP8266 operates at 3.3V. The TEC-1 typically operates at 5V logic levels. Use appropriate level shifters to convert between these voltage levels to avoid damaging the ESP8266.

## Understanding MINT Programming

MINT (Minimalist INTerpreter) is a character-based interpreter designed for the TEC-1 computer. Here are some key concepts:

### Basic MINT Principles
- MINT is a minimalist byte-code interpreter with 1-byte instructions using printable ASCII
- Uses Reverse Polish Notation (RPN) for operations
- Variables are named with single lowercase letters (a to z)
- Functions are labeled with uppercase letters (A to Z)
- MINT operates with a stack for data manipulation
- 16-bit signed integers for decimal and unsigned for hexadecimal
- Functions are defined using `:` and end with `;` (e.g., `:F 1+ ;`)

### MINT Data Display
- `.` prints numbers in decimal format
- `,` prints numbers in hexadecimal format
- `` ` `` encloses literal text (e.g., `` `hello` ``)
- `/N` prints a newline

### MINT Control Flow
- `( )` defines a loop or conditional block
- `/U` starts an unlimited loop
- `/W` acts as a while condition
- `/E` provides an else condition
- `/T` represents boolean true (value -1)
- `/F` represents boolean false (value 0)

## Communication with ESP8266

The TEC-1 communicates with the ESP8266 via serial UART at 4800 baud. The ESP8266 default baud rate is typically 115200, so it needs to be changed to match the TEC-1's capabilities.

### Setting ESP8266 Baud Rate to 4800

Before using with the TEC-1, configure the ESP8266 to use 4800 baud:

1. Connect the ESP8266 to a computer using a USB-to-serial adapter
2. Using a terminal program, connect at the default baud rate (typically 115200)
3. Send the command: `AT+UART_DEF=4800,8,1,0,0`
4. The ESP8266 should respond with "OK"
5. Disconnect and reconnect at 4800 baud to verify the change

## AT Command Set for ESP8266

The ESP8266 is controlled using AT commands sent over the serial connection. Here are essential commands:

| Command | Description | Example |
|---------|-------------|---------|
| AT | Test the connection | AT |
| AT+RST | Reset the ESP8266 | AT+RST |
| AT+GMR | Show firmware version | AT+GMR |
| AT+CWMODE=\<mode> | Set WiFi mode (1=station, 2=AP, 3=both) | AT+CWMODE=1 |
| AT+CWJAP=\<ssid>,\<pwd> | Connect to WiFi network | AT+CWJAP="MyNetwork","password123" |
| AT+CWLAP | List available WiFi networks | AT+CWLAP |
| AT+CIPSTART=\<type>,\<addr>,\<port> | Start TCP/UDP connection | AT+CIPSTART="TCP","192.168.1.100",80 |
| AT+CIPSEND=\<len> | Send data (followed by the data) | AT+CIPSEND=16 |
| AT+CIPCLOSE | Close connection | AT+CIPCLOSE |

## Complete WiFi Scanner Implementation

Below is a complete MINT implementation of a WiFi scanner for the TEC-1 that communicates with the ESP8266 to scan and display available WiFi networks. This implementation includes all necessary helper functions.

```
// WiFi Network Scanner in MINT language
// Main program variables:
// a = baud rate
// n = number of networks found
// i, j, k = loop counters
// b = buffer for ESP8266 responses
// h = helper flag
// t, s = temporary storage

// UART Communication Functions
:O c! v! v c /O ;             // Output value v to port c
:I c! c /I ;                  // Input from port c

// Buffer Management
:B \[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] b! ;  // Create 20-byte buffer
:R 0 i! /U(i 20 < /W 0 b i \?! i 1+ i!) ;           // Reset buffer

// AT Command and String Processing Functions
:E s! t! t s 100() ;         // Send AT command prefix+s
:f s! 0 k! /U(k b /S < /W k b s m m /T = (k 0 h!) k 1+ k!) -1 ; // Find s in buffer
:m s! p! 0 j! /T j! 0 i! /U(i s /S < /W s i \? b p i + \? = /F = (/F j! i s /S) i 1+ i!) j ; // Match string
:p s! e! 0 n! 0 i! /U(i e < /W b s i + \? 48 - n 10 * + n! i 1+ i!) n ; // Parse number

// ESP8266 Network Information Functions
:s R `CWLAP` E 0 n! /U(`+CWLAP:` f f 0 > (n 1+ n!) f 0 <= /W) n ;  // Scan, count networks
:g i! R `CWLAP` E 0 j! /U(`+CWLAP:` f j i < (j 1+ j!) /E (f 1+ k! `,"` f f k! `"` f k f k - 1- /N 0 h!) j i <= /W) ; // Get SSID
:r i! R `CWLAP` E 0 j! /U(`+CWLAP:` f j i < (j 1+ j!) /E (f 1+ `,` f f 1+ k! `,` f k b k - p 0 h!) j i <= /W) ; // Get RSSI
:e i! R `CWLAP` E 0 j! /U(`+CWLAP:` f j i < (j 1+ j!) /E (f 1+ 1 f f b \? 48 - 0 1 = (/F) /E (/T) 0 h!) j i <= /W) ; // Get encryption

// Main WiFi Scanner Program
:A 4800 a! B `AT` E `AT+CWMODE=1` E `AT+CWQAP` E 500() ; // Setup: baud, buffer, test, mode, disconnect
:D `scan start`/N s() n! n 0 = (`no networks found`/N) /E (`networks found: ` n./N 0i! /U(i n < /W i . `: ` i g() ` (` i r() ` dBm)` i e() 0 = (32/C) /E (`*`) /N 50() i 1+i!)) `scan done`/N 2000() ; // Display networks
:C A /U(D) ; // Main function: setup and loop display

// Initialize and run
C
```

### Code Explanation

#### UART and Buffer Functions
- `O` and `I` - Output to and input from UART ports
- `B` - Creates a buffer for storing ESP8266 responses
- `R` - Resets the buffer by filling with zeros

#### String Processing Functions
- `E` - Sends AT commands with prefix and delay
- `f` - Finds a string pattern in the buffer
- `m` - Matches a string at a specific position
- `p` - Parses a number from text

#### ESP8266 Interface Functions
- `s` - Sends scan command and counts networks
- `g` - Gets SSID name for a specific network index
- `r` - Gets signal strength (RSSI) for a network
- `e` - Gets encryption status for a network

#### Main Program
- Function `A`: Setup - Configures baud rate, tests connection, sets WiFi mode
- Function `D`: Display - Scans and shows network information
- Function `C`: Main loop - Runs setup once, then repeats display

## Internet Connectivity with ESP8266

### Establishing a TCP Connection

To establish a TCP connection using MINT and the ESP8266, you can use this code pattern:

```
// TCP client implementation
// Variables:
// a,b,c,d = target IP octets
// p = port number
// t = temporary IP string
// s = status

:T a.`.`b.`.`c.`.`d t! p p! `AT+CIPSTART="TCP","`t`,`p /N 1000() s!; // Start TCP connection
:S n! `AT+CIPSEND=`n /N ; // Prepare to send n bytes
:C `AT+CIPCLOSE` /N ; // Close connection
```

### Example: Sending HTTP Request

This example sends a simple HTTP GET request to a web server:

```
// HTTP GET request example
// Set server IP and port
192 a! 168 b! 1 c! 100 d! 80 p!
// Start TCP connection
T
// Send HTTP request
47 S // Length of request
`GET / HTTP/1.1
Host: 192.168.1.100

` // Data to send
// Close connection after receiving response
C
```

## Troubleshooting

Common issues when working with the ESP8266:

1. **No response to AT commands**
   - Verify power connections (3.3V and GND)
   - Ensure CH_PD (chip enable) is connected to 3.3V
   - Check that TX/RX connections are correct and properly level-shifted
   - Verify baud rate settings match

2. **Cannot connect to WiFi network**
   - Verify network SSID and password
   - Ensure network is within range
   - Check if network supports the security type used by ESP8266

3. **Connection unstable or drops**
   - Check power supply (ESP8266 can require up to 300mA during transmission)
   - Improve antenna positioning or add an external antenna
   - Reduce distance to access point

4. **MINT code execution issues**
   - Ensure no spaces between function definition and function letter (e.g., `:F` not `: F`)
   - Check that all functions end with semicolons (`;`)
   - Verify buffer sizes are appropriate for the data you're receiving
   - Remember that MINT has no stack overflow protection, so handle large responses carefully

## References

1. [ESP8266 Datasheet and Documentation](https://www.espressif.com/en/products/socs/esp8266)
2. [TEC-1 Computer Documentation](https://github.com/SteveJustin1963/tec-MINT)
3. [ESP8266 AT Command Reference](https://cdn.sparkfun.com/datasheets/Wireless/WiFi/Command%20Doc.pdf)
4. [Arduino Support for ESP8266](https://www.exploreembedded.com/wiki/Arduino_Support_for_ESP8266_with_simple_test_code)
5. [TEC-1 TCP/IP Stack GitHub Repository](https://github.com/SteveJustin1963/tec-TCPIP)
 
