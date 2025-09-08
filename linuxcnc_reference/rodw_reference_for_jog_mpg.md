But back onto LinuxCNC, I promised I'd show document how I got an MPG running on the 7i76e. Lets start with the scale selector. I knew I need a 2 bit binary output but I've only ever made them in software before so I asked a friend what to get and he said to get one of these from Jaycar . That looked right to me so I grabbed one as I was close to one of their shops.

There were 3 outputs in the centre of the switch (A, B & C). We only need two of these so I picked A & B. But it really did my head in trying to work out how to use it in the absence of documentation. After a while with a multimeter I worked out which wire went where but I still could not work it out. Then I decided I needed to build a truth table showing the binary logic required:

 Pos   A B
  0:   0 0
  1:   0 1
  2:   1 0
  3:   1 1


And work out what wires were required to be live where ever there was a 1. My switch pinout said I needed to make pins 3, 4, 6 and 8 live so I tied them together with a yellow wire attached to +24v and an orange and green wire on the centre inputs going to the mux4 pins.

File Attachment:


File Attachment:


I made a bracket for the 100PPR encoder wheel from some scrap angle iron so it would not short out
File Attachment:


The wiring was pretty simple

I stole some 5 volt power from one of the stepper power pins.
Encode A connects to TB3.16
Encoder B connects to TB3.17

I did run into trouble until I found a post from PCW which said if you are using a separate 5V power supply like I am, you needed to tie the 24 volt and 5 volt pin Grounds together. Eg. Connect TB1.1 to TB2.23. But if you follow this wiring schematic , you won't need to do this

As the 7i76e has 2 encoder inputs, I figured I'd use separate encoders for the X & Y axis.

Some of the examples I had seen used the -not signal from an unused input for the encoder enable inut but this looked a bit dodgy to me. Why not simply OR the 2 encoder input pins together and use the output from that as the enable signal? By doing that , the encode will be disabled when the scale switch is at position 0 and enabled at any of the scale settings. Nice and clean!

Here is what the HAL file looks like:


```hal
# Metric units used
loadrt hm2_eth board_ip="10.10.10.10" config="firmware=hm2/7i76/7i76e.BIT num_encoders=1 num_pwmgens=0 num_stepgens=5  sserial_port_0=2xxxx" 

loadrt mux4 count=1
addf mux4.0 servo-thread
loadrt or2 count=4
addf or2.3  servo-thread

setp axis.x.jog-vel-mode 0
net x-jog-counter <=  hm2_7i76e.0.7i76.0.0.enc0.count
net x-jog-counter => axis.x.jog-counts
net mux-in1 or2.3.in0 <= hm2_7i76e.0.7i76.0.0.input-22 => mux4.0.sel0
net mux-in2 or2.3.in1 <= hm2_7i76e.0.7i76.0.0.input-21 => mux4.0.sel1
net x-jog-enable <= or2.3.out
net x-jog-enable => axis.x.jog-enable
setp mux4.0.in0 0.0
setp mux4.0.in1 1.0
setp mux4.0.in2 0.1
setp mux4.0.in3 0.01
net x-jog-scale mux4.0.out => axis.x.jog-scale
```

This is set up for a metric machine and the scale is 1mm, 0.1mm and 0.01mm. If you find the scale is reversed, it is becasue the pins are mapped in the reverse order. (eg low order pin connected to high order bit). If this happens to you, just edit the pins in this code.
```hal
net mux-in1 or2.3.in0 <= hm2_7i76e.0.7i76.0.0.input-22 => mux4.0.sel0
net mux-in2 or2.3.in1 <= hm2_7i76e.0.7i76.0.0.input-21 => mux4.0.sel1
```

Remember to change this line based on your config. I had already used a few or2's
```hal
loadrt or2 count=4
```
Well, thats about it for now. The shopping list is becoming very short.
1. 9 core shielded wire for the connection to the plasma power supply now the connector is to hand
2. A 3 stage air filter including a desiccant drier stage I've had my eye on.
3. About 10 metres of 100 x 100 x 5mm SHS for the frame and some other sundry steel.

The main things I have to do in HAL are:
1. All the THC stuff
2. Sort out my stepper drives so they are working on the correct axis
3. Implement Gantry Joint Axis .
4. Get my warning lights working the way I want them to and I'll need some help on that one. 