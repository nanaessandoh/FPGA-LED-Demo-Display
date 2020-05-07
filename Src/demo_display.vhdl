-- Top Level Entity
library ieee;
use ieee.std_logic_1164.all;

entity demo_display is
  port (
        KEY0: in std_logic;  -- pushbuttons
        CLOCK_50: in std_logic; -- 50 MHz clock input
        LEDR: out std_logic_vector(9 downto 0) -- red LEDs
       );
end demo_display;

architecture behav of demo_display is

  -- Declare Components
  component cylon
    port( clk, rstb: in std_logic;
          lights: out std_logic_vector(9 downto 0));
  end component;

  -- Declare Signals
  signal lights_out: std_logic_vector(9 downto 0);

  begin

      -- Declare Port Map
  cy0: cylon port map(CLOCK_50, KEY0, lights_out);

  LEDR <= lights_out;


  
end behav;
