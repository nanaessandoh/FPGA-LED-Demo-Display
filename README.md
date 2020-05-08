# FPGA LED Demo Display

This project involves implementing a LED light display that uses the red LEDs on the DE1-SoC board to generate a pattern that sweeps back and forth much like KITT from Knight Rider or the Robotic Cylons from Battle Galactica.

A sequential circuit running on the DE1-SoC's 50 MHz clock that oscillates a single illuminated red LED back and forth across all 10 red LEDs on the board at a rate determined by pressing KEY1. The available rates per second are 100, 50, 25, 12.5, 6.25 and 3.125 (i.e. 0.01, 0.02, 0.04, 0.08, 0.16 and 0.32 seconds). When the illuminated LED reaches the end of the row, it changes direction and starts shifting back the other way.

The specifications of the design are;
* An asynchronous active-low reset for the entire system, which resets the LEDs so that LEDR0 is the one that is lit.
* The reset button will be assigned to KEY0.
* The rate can be increased by pressing KEY1.
* The state machine used is a Mealy machine ( Depends on the current state and input).


A RTL Structure of the design is

    .
    ├── ...
    ├── demo_display.vhdl         # Top Level Entity
    │   └── cylon.vhdl              
    │       ├── counter1S.vhdl    # Counter running on the 50Mhz clock and output a control signal every 0.02 sec.
    │       ├── counter10.vhdl    # Counter (0-10).
    │       ├── led_control.vhdl  # Mealy State Machine for Demo Display.                          
    │       └── shiftreg.vhdl     # Shift register to shift the bit to be displayed on the LEDs.       
    └── ...