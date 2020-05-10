library ieee;
use ieee.std_logic_1164.all;

entity test_clock_control is

end test_clock_control;

architecture behav of test_clock_control is

component clock_control
  port( key, clk, rstb: in std_logic;
        time_01, time_02, time_04, time_08, time_16, time_32: out std_logic);
end component;  


-- Signal Declaration
signal clk, key, rstb, time_01, time_02, time_04, time_08, time_16, time_32 : std_logic;
constant period : time := 2 ns; -- clock period



begin

-- Port Map Declaration
A1: clock_control port map( clk => clk,
			  rstb => rstb, 
			  key => key, 
			  time_01 => time_01,
			  time_02 => time_02,
			  time_04 => time_04,
			  time_08 => time_08,
			  time_16 => time_16,
			  time_32 => time_32				 
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
key <= '0' after 4 ns;
end behav;

