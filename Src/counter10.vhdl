-- Counter that outputs a control signal (cnt10) at count 10
-- with asynchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter10 is
  port( clk, rstb, clr, en: in std_logic;
        cnt10: out std_logic);
end counter10;

architecture behav of counter10 is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
begin

  -- Clock the counter
  process (clk, rstb)
  begin
    if (rstb = '0') then -- asynchronous active low reset
      cnt <= "0000";
    elsif (clk'event) and (clk = '1') then
      if (clr = '1') then
        cnt <= "0000";
      elsif (en = '1') then
        if (cnt = "1001") then
          cnt10 <= '1';
          cnt <= "0000";
        else
          cnt10 <= '0';
          cnt <= cnt + '1';
        end if;
      else
        -- Hold count, no outputs
        cnt <= cnt;
        cnt10 <= '0';
      end if;
      
    end if;
  end process;
  
end behav;
