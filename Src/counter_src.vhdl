-- Counter based on 50 MHz clock that outputs a control signal representing 0.02 second 
-- at 1M, with asynchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_src is
  port( clk, rstb, clr, en: in std_logic;
        sig_01, sig_02, sig_04, sig_08, sig_16, sig_32: in std_logic; -- Variable Speed inputs for the counter
        cntM: out std_logic);
end counter_src;

architecture behav of counter_src is
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
      if (sig_01 = '1') then
          if (cnt = "000001111010000100100000") then -- 0.01 sec
          cntM <= '1';
         cnt <= "000000000000000000000000";
        else
          cntM <= '0';
          cnt <= cnt + '1';
        end if;
      elsif (sig_02 = '1') then
        if (cnt = "000011110100001001000000") then -- 0.02 sec
          cntM <= '1';
          cnt <= "000000000000000000000000";
        else
          cntM <= '0';
          cnt <= cnt + '1';
        end if;
      elsif (sig_04 = '1') then
          if (cnt = "000111101000010010000000") then -- 0.04 sec
            cntM <= '1';
            cnt <= "000000000000000000000000";
          else
            cntM <= '0';
            cnt <= cnt + '1';
          end if;
      elsif (sig_08 = '1') then
        if (cnt = "001111010000100100000000") then -- 0.08 sec
          cntM <= '1';
          cnt <= "000000000000000000000000";
        else
          cntM <= '0';
          cnt <= cnt + '1';
        end if;
      elsif (sig_16 = '1') then
          if (cnt = "011110100001001000000000") then -- 0.16 sec
            cntM <= '1';
            cnt <= "000000000000000000000000";
          else
            cntM <= '0';
            cnt <= cnt + '1';
          end if;
          elsif (sig_32 = '1') then
            if (cnt = "111101000010010000000000") then -- 0.32 sec
              cntM <= '1';
              cnt <= "000000000000000000000000";
            else
              cntM <= '0';
              cnt <= cnt + '1';
            end if;
      end if
      else
        cnt <= cnt;
        cntM <= '0';        
      end if;
    end if;
  end process;
  
end behav;
