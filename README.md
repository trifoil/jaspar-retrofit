# jaspar-retrofit
Retrofit of Jaspar 1MVZ milling machine


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
    | 1 |  | A+ |
    | / |  | A- |
    | 2 |  | B+ |
    | / |  | B- |