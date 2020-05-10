library ieee;
use ieee.std_logic_1164.all;

entity test_shift_reg is

end test_shift_reg;

architecture behav of test_shift_reg is
  
component shift_reg
  port(clk, rstb, en: in std_logic;
        mode: in std_logic; -- 0 left, 1 right
        val_out: out std_logic_vector(9 downto 0));
end component;

-- Signal Declaration
signal clk, rstb, en, mode : std_logic;
signal val_in: std_logic_vector(9 downto 0);
signal val_out : std_logic_vector(9 downto 0);
constant period : time := 2 ns; -- clock period

begin

-- Port Map Declaration
A1: shift_reg port map( clk => clk, 
			rstb => rstb, 
			en => en,
			mode => mode,
			val_out => val_out 
			);
-- Generate Clock

    Clock_Generator :process
        begin
        clk <= '0';
        wait for period / 2;
        clk <= '1';
        wait for period / 2;
       end process;


-- Perform Test
rstb <= '1'; 
en <= '1' after 4 ns;
mode <= '0' after 4 ns, '1' after 50 ns;

end behav;

