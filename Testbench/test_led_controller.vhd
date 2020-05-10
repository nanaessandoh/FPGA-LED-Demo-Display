library ieee;
use ieee.std_logic_1164.all;

entity test_led_controller is

end test_led_controller;

architecture behav of test_led_controller is
  
component led_control
  port( cnt10, clk, rstb: in std_logic;
        shift_reg_mode: out std_logic );
end component;

-- Signal Declaration
signal clk, cnt10, rstb, shift_reg_mode : std_logic;
constant period : time := 2 ns; -- clock period

begin

-- Port Map Declaration
A1: led_control port map( clk => clk,  
			     cnt10 => cnt10,
			     rstb => rstb,
			     shift_reg_mode => shift_reg_mode 
			);
-- Generate Clock
--clk <= '1', not clk after 2 ns;

    Clock_Gen :process
        begin
        clk <= '0';
        wait for period / 2;
        clk <= '1';
        wait for period / 2;
       end process;


-- Perform Test
rstb <= '1' after 2 ns;
cnt10 <= '1' after 10 ns, '0' after 12 ns, '1' after 22 ns, '0' after 24 ns, '1' after 34 ns,'0' after 36 ns, '1' after 46 ns, '0' after 48 ns;

end behav;

