-- Shift register that rotates pattern left (dir=1) or right
-- on clock if enabled.  Has parallel load that dominates,
-- async reset.

library ieee;
use ieee.std_logic_1164.all;

entity shiftreg10 is
  port( load_val: in std_logic_vector(9 downto 0);
        clk, rstb: in std_logic;
        mode: in std_logic_vector(1 downto 0); -- 00 hold, 01 right, 10 left, 11 load 
        val_out: out std_logic_vector(9 downto 0));
end shiftreg10;

architecture behav of shiftreg10 is
  signal pattern: std_logic_vector(9 downto 0) := "0000000001";
begin

  -- Clock the register
  process (clk, rstb)
  begin
    if (rstb = '0') then -- asynchronous active low reset
      pattern <= "0000000001";
    elsif (clk'event) and (clk = '1') then
      case mode is
        when "00" =>
          -- hold
          pattern <= "1000000000";
        when "10" =>
          -- left shift
          pattern <= pattern(8 downto 0) & pattern(9);
        when "01" =>
          -- right shift
          pattern <= pattern(0) & pattern(9 downto 1);
          when "11" =>
          -- parallel load
          pattern <= load_val;
        when others =>
          -- hold in error case
          pattern <= pattern;
      end case;      
    end if;
  end process;
  
  val_out <= pattern;
end behav;
