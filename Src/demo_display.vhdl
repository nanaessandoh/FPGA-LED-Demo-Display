-- Top Level Entity
library ieee;
use ieee.std_logic_1164.all;

entity demo_display is
  port (
        KEY: in std_logic_vector(1 downto 0);  -- pushbuttons
        CLOCK_50: in std_logic; -- 50 MHz clock input
        LEDR: out std_logic_vector(9 downto 0); -- red LEDs
       );
end Top_Level;

architecture behav of demo_display is

  -- Declare Components
  component cylon is
    port( clk, rstb: in std_logic;
          lights: out std_logic_vector(9 downto 0));
  end component;

  -- Declare Signals
  signal lights_out: std_logic_vector(9 downto 0);

  begin

      -- Declare Port Map
  cy0: cylon port map(CLOCK_50, KEY(0), lights_out);

  LEDR <= lights_out;


  
end behav;
