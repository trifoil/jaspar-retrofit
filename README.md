# jaspar-retrofit
Retrofit of Jaspar 1MVZ milling machine


## Components

| Quantity | Brand | Designation  |  Useful name  | Additional comments |
|:---|:---|:---|:-----|:-----|
|1| Schneider Electric | XB5AA25 |  Push button, Black |/|
|1| Schneider Electric | XB5AA15 |  Push button, White |/|
|1| Schneider Electric | XB5AA61 |  Push button, Blue |/|
|1| Schneider Electric | XB5AA55 |  Push button, Yellow |/|
|2| Schneider Electric | XB5AD33 | Selector switch | / |
|1| Schneider Electric | XB5PUSB3 |  Panel mounted USB 3.0 port | / |
|1| Schneider Electric | XB5AVB4 | Pilot light | / |



## Wiring 

### Operating principles


Once the main switch is turned on, the power is on for the computer, 24V alims and 

---

**Estop**

The E-stop has two contacts

* ZBE102 (red), Normally Closed, wired to a Mesa input     
* ZBE102 (red), Normally Closed, wired to the main safety relay     

When pressed, the circuit is open, as if there was no wire (that way if the estop wire is disconnected, the machine won't start):
* Software Estop is enabled
* The machine is on
* The relay is disabled, and the power contactors (X, Y, Z and Spindle) are open.
If the E-stop is disengaged, the circuit is closed and :
* Software Estop is disabled
* The machine is off
* The relay is enabled, and the power contactors (X, Y, Z and Spindle) are closed.

---

**Jog mode**

The MPG encoder is powered by 5V, linked to GND, and has 4 outputs but two are used : A+ and B+.

To override the normal operation of the machine one button is pressed, and enables the jog wheel while pressed.

The pin to enable jog is hm2_7i76e.0.7i76.0.0.input-20

Two selector buttons allow for selecting :

* The axis to move :
    * X
    * Y
    * Z
* The speed at which it is moving : 
    * X1
    * X10
    * X100

The card is in mode 2 to enable mpg inputs on these pins (sserial_port_0=20xxxxxx)

* The A+ signal is wired to hm2_7i76e.0.7i76.0.0.input-16
* The B+ signal is wired to hm2_7i76e.0.7i76.0.0.input-17

That way, the mpg input is readable on hm2_7i76e.0.7i76.0.0.enc0.count

For the axis selection : 

* hm2_7i76e.0.7i76.0.0.input-23
* hm2_7i76e.0.7i76.0.0.input-24
* if none is selected, Y is the axis to be selected

For the speed selection : 

* hm2_7i76e.0.7i76.0.0.input-21
* hm2_7i76e.0.7i76.0.0.input-22
* if none is selected, X10 is the axis to be selected

---



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

5) **Jog MPG** (hm2_7i76e.0.7i76.0.0.enc0.count)

    | TB3 pin  |  Name   | MPG contact |
    |:---|:-----| :--- |
    | 9 | GND | GND |
    | 12 | +5VP | VCC |

    | TB5 pin  |  Name   | MPG contact |
    |:---|:-----| :--- |
    | 1 | INPUT16 | A+ |
    | / | / | A- |
    | 2 | INPUT17 | B+ |
    | / | / | B- |

6) **Jog enabling button**

    | TB5 pin  |  Name   | HAL name |
    |:---|:-----|:---|
    | 5 | INPUT20 | hm2_7i76e.0.7i76.0.0.input-20 |

7) **Speed selector button**

    | TB5 pin  |  Name   |  Position  |
    |:---|:-----|:---|
    | 6 | INPUT21 | X1 |
    | 7 | INPUT22 | X100 |

    If none is selected, the speed is X10

8) **Axis selector button**

    | TB5 pin  |  Name   |  Position  |
    |:---|:-----|:---|
    | 8 | INPUT23 | X |
    | 9 | INPUT24 | Z |

    If none is selected, the axis is Y

9) **Program start**

    | TB5 pin  |  Name   |  
    |:---|:-----|
    | 10 | INPUT25 | 


10) **Program pause**

    | TB5 pin  |  Name   |
    |:---|:-----|
    | 11 | INPUT26 |

11) **Estop**

    | TB5 pin  |  Name   |
    |:---|:-----|
    | 12 | INPUT27 |

12) **Coolant**

    | TB5 pin  |  Name   |
    |:---|:-----|
    | 13 | INPUT28 |

13) **Limit switches**

    | TB6 pin  |  Name   | Axis |
    |:---|:-----|:---|
    | 1 | INPUT0 | X |
    | 2 | INPUT1 | Y |
    | 3 | INPUT2 | Z |

14) **Homing sensor**

    | TB6 pin  |  Name   | Axis |
    |:---|:-----|:---|
    | 4 | INPUT3 | X |
    | 5 | INPUT4 | Y |
    | 6 | INPUT5 | Z |

15) **Z axis brake**

    | TB5 pin  |  Name   |
    |:---|:-----|
    | 18 | OUTPUT9 |

## Important notes 

In order to select the mode 2 of the mesa 7i76e board, this line 

```hal
loadrt hm2_eth board_ip="192.168.1.121" config="num_encoders=1 num_pwmgens=0 num_stepgens=5 sserial_port_0=00xxxxxx" 
```

has to be changed to this

```hal
loadrt hm2_eth board_ip="192.168.1.121" config="num_encoders=1 num_pwmgens=0 num_stepgens=5 sserial_port_0=20xxxxxx" 
```

The pc is connected with : 
* ip:192.168.1.3 
* gateway:192.168.1.254 
* mask: 255.255.255.0

## QTPYVCP interface

```sh
sudo apt update -y
sudo apt upgrade -y

sudo apt install curl -y
echo 'deb [arch=amd64] https://repository.qtpyvcp.com/apt stable main' | sudo tee /etc/apt/sources.list.d/kcjengr.list
curl -sS https://repository.qtpyvcp.com/repo/kcjengr.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/kcjengr.gpg
gpg --keyserver keys.openpgp.org --recv-key 2DEC041F290DF85A
sudo apt update -y


sudo apt install python3-qtpyvcp -y
sudo apt install python3-probe-basic -y
sudo apt install python3-monokrom -y 
sudo apt install python3-turbonc -y

```