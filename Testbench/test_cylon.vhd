library ieee;
use ieee.std_logic_1164.all;

entity test_cylon is

end test_cylon;

architecture behav of test_cylon is
  
component cylon 
  port( clk, rstb , key: in std_logic;
        lights: out std_logic_vector(9 downto 0));
end component;

-- Signal Declaration
signal clk, rstb, key : std_logic;
signal  lights: std_logic_vector(9 downto 0);
constant period : time := 2 ns; -- clock period

begin

-- Port Map Declaration
A1: cylon port map( 	clk => clk,
			rstb => rstb,
			key => key,
			lights => lights 
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
key <= '1';

end behav;

