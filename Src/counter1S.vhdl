-- Counter based on 50 MHz clock that outputs a control signal representing 0.02 second 
-- at 1M, with asynchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter1m is
  port( clk, rstb, clr, en: in std_logic;
        cnt1M: out std_logic);
end counter1m;

architecture rtl of counter1m is
  signal cnt: std_logic_vector(19 downto 0) := "00000000000000000000";
begin

  -- Clock the counter
  process (clk, rstb)
  begin
    if (rstb = '0') then -- asynchronous active low reset
      cnt <= "00000000000000000000";
    elsif (clk'event) and (clk = '1') then
      if (clr = '1') then
        cnt <= "00000000000000000000";
      elsif (en = '1') then
        if (cnt = "11110100001001000000") then -- 0.02 sec
          cnt1M <= '1';
          cnt <= "00000000000000000000";
        else
          cnt1M <= '0';
          cnt <= cnt + '1';
        end if;
      else
        cnt <= cnt;
        cnt1M <= '0';        
      end if;
    end if;
  end process;
  
end rtl;
