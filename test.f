\ This sketch demonstrates how to scan WiFi networks in Forth 83

\ Set up the serial connection
115200 BAUD !

: setup \ Initialize the serial connection and set WiFi to station mode
begin
key ? dup 10 = while
key drop
repeat
115200 BAUD !
1 WIFI_STA !
0 DISCONNECT
100 MS
." Setup done" CR
;

: loop \ Scan for WiFi networks and display information about them
." scan start" CR
SCAN_NETWORKS dup 0 =
if
." no networks found" CR
else
." networks found" . CR
0 ?DO
I 1+ . ": " SSID . " (" RSSI . ")"
ENC_TYPE_NONE = IF SPACE ELSE "*" THEN
CR
10 MS
LOOP
then
." scan done" CR
5000 MS
;

\ Run the setup and loop functions
setup
begin
loop
again
