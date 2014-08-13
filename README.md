Goal
====

Having an easy way to monitor the network connections of one computer or a very small network.


Architecture
============

                          Soekris <---> Desktop
                            ^  ^
                            |  |
                           RX  TX
                            |  |
    Computer <---> Throwing Star LAN Tap <---> Internet


The Throwing Star is a "passive Ethernet tap, requiring no power for operation".
Soekris gather and save the traffic with tshark.
Desktop is the analysis machine where the processing of the packets is made (with suricata).




