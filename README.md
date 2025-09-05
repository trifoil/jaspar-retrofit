# jaspar-retrofit
Retrofit of Jaspar 1MVZ milling machine


## Components

| Designation  |  Useful name  |
|:---|:-----|
|  |  |

## Wiring 

### Operating principles

Once the main switch is turned on, the power is on for the computer, 24V alims and 



### Conventions

Convention for terminal blocks, where `X` is any number : 

| Designation  |  Useful name  |
|:---|:-----|
| 24v + | 24V+ |
| 24v gnd | 0V |
| 230v phase | P |
| 230v neutral | N |
| Coils | K`X` |
| Contact | K`X`.`X` |
| Switch | S |

### Mesa 7i76e jumpers

W2 and W3 are down, so the address of the card is 192.168.1.121 (default)

```sh
x@fedora:~$ ping 192.168.1.121
```

The answer should be : 
```txt
PING 192.168.1.121 (192.168.1.121) 56(84) bytes of data.
64 bytes from 192.168.1.121: icmp_seq=1 ttl=64 time=0.091 ms
64 bytes from 192.168.1.121: icmp_seq=2 ttl=64 time=0.109 ms
64 bytes from 192.168.1.121: icmp_seq=3 ttl=64 time=0.121 ms
```

### Mesa 7i76e wiring

![alt text](<7i76e/Screenshot From 2025-09-04 05-09-42.png>)

Pins are numbered from bottom up.

0) **Power**

    | TB1 pin  |  Name   | Terminal block |
    |:---|:-----|:---|
    | 5 | VIN |  24V+  |     
    | 8 | GROUND |  0V  |     

    | TB3 pin  |  Name   | Terminal block |
    |:---|:-----|:---|
    | 22 | UNREG LOGIC PWR+ IN |  24V+  |     
    | 23 | GND |  0V  |    

1) **x Axis** 

    | TB2 pin  |  Name   |  Interface card pin  |
    |:---|:-----|:---|
    | 1 | GND |  /  |     
    | 2 |  STEP0-   | 41  |     
    | 3 |   STEP0+  |  43 |     
    | 4 |   DIR0-  |  37 |     
    | 5 |   DIR0+   | 39  |     
    | 6 |  +5VP   |  /  |     

2) **y Axis**

    | TB2 pin  |  Name   |  Interface card pin  |
    |:---|:-----|:---|
    | 7 | GND |  /  |     
    | 8 |  STEP1-   | 41  |     
    | 9 |   STEP1+  |  43 |     
    | 10 |   DIR1-  |  37 |     
    | 11 |   DIR1+   | 39  |     
    | 12 |  +5VP   |  /  |     

3) **z Axis**

    | TB2 pin  |  Name   |  Interface card pin  |
    |:---|:-----|:---|
    | 13 | GND |  /  |     
    | 14 |  STEP2-   | 41  |     
    | 15 |   STEP2+  |  43 |     
    | 16 |   DIR2-  |  37 |     
    | 17 |   DIR2+   | 39  |     
    | 18 |  +5VP   |  /  |     

4) **Spindle**

    | TB5 pin  |  Name   |  Relay coil  |
    |:---|:-----|:---|
    | 17 | OUTPUT8 |  C1  |     

5) **MPG**

    | TB3 pin  |  Name   | MPG contact |
    |:---|:-----| :--- |
    | 9 | GND | VCC |
    | 12 | +5VP | GND |

    | TB5 pin  |  Name   | MPG contact |
    |:---|:-----| :--- |
    | 1 | INPUT16 | A+ |
    | / | / | A- |
    | 2 | INPUT17 | B+ |
    | / | / | B- |

6) **Estop**

    | TB5 pin  |  Name   |
    |:---|:-----|
    | 3 | INPUT18 |

7) **Speed selector button**

    | TB5 pin  |  Name   |  Position  |
    |:---|:-----|:---|
    | 4 | INPUT19 | X1 |
    | 5 | INPUT20 | X10 |
    | 6 | INPUT21 | X100 |

8) **Axis selector button**

    | TB5 pin  |  Name   |  Position  |
    |:---|:-----|:---|
    | 7 | INPUT22 | X |
    | 8 | INPUT23 | Y |
    | 9 | INPUT24 | Z |

9) **Program start**

    | TB5 pin  |  Name   |  
    |:---|:-----|
    | 10 | INPUT25 | 


10) **Program pause**

    | TB5 pin  |  Name   |
    |:---|:-----|
    | 11 | INPUT26 |

11) 
