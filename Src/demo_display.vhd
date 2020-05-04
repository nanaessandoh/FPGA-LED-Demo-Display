library ieee;
use ieee.std_logic_1164.all;

entity Top_Level is
  port (
        KEY: in std_logic_vector(3 downto 0);  -- pushbuttons
        CLOCK_50: in std_logic; -- 50 MHz clock input
        LEDR: out std_logic_vector(9 downto 0); -- red LEDs
       );
end Top_Level;

architecture behav of Top_Level is
  component cylon is
    port( clk, rstb: in std_logic;
          lights: out std_logic_vector(9 downto 0));
  end component;
  
  signal lights_out: std_logic_vector(9 downto 0);
begin

  -- Here you can instantiate an instance of the component you
  -- designed and connect the inputs/outputs appropriately.
  cy0: cylon port map(CLOCK_50, KEY(0), lights_out);
  
end behav;
