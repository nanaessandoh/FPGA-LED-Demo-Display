-- 5 Bit Counter that counts from 0 to 31
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter5bit is
  port( clk, rstb: in std_logic;
        q: out  std_logic_vector(4 downto 0);
end counter5bit;

architecture rtl of counter5bit is
  signal cnt: std_logic_vector(4 downto 0) := "00000";
begin

  -- Clock the counter
  process (clk, rstb)
  begin

    if (clk'event) and (clk = '1') then
	if (rstb = '1') then -- synchronous active high reset
   	   cnt <= "00000";
        else
          cnt <= cnt + '1';
        end if;
    end if;
  end process;
	q <=cnt;
  
end rtl;
