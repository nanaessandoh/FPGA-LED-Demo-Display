library ieee;
use ieee.std_logic_1164.all;

entity test_demo)display is

end test_demo_display;

architecture behav of test_demo_display is
   
-- Component Declaration
    component demo_display
        port (
              KEY0: in std_logic;  -- pushbuttons
              CLOCK_50: in std_logic; -- 50 MHz clock input
              LEDR: out std_logic_vector(9 downto 0); -- red LEDs
             );
    end component;

signal CLK_i : std_logic := '0';
signal KEY0_i : std_logic := "1";
signal LEDR_i : std_logic_vector (9 downto 0) := "0000000000";

 begin

DD0: demo_display port map( CLOCK_50 => CLK_i, 
                            KEY0 => KEY0_i, 
                            LEDR => LEDR_i
                            );

-- Generate  Clock
CLK_i <= not CLK_i after 1 ns;

-- Do Test
KEY0_i <= '0' after 10 ns , '1' after 11 ns;

 end behav;
