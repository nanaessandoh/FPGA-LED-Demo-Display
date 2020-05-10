-- Shift register that rotates pattern left or right
-- on clock if enabled.
-- async load(reset).

library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
  port( clk,rstb, en: in std_logic;
        mode: in std_logic; -- 0 left, 1 right
        val_out: out std_logic_vector(9 downto 0));
end shift_reg;

architecture behav of shift_reg is
  
signal pattern: std_logic_vector(9 downto 0):= "1000000000";

begin

  -- Clock the register
  process (clk,rstb)
  begin
     if (rstb = '0') then -- asyn reset
	pattern <= "1000000000";
      elsif (clk'event) and (clk = '1') then
     if ( en = '1') then

      case mode is
        when '0' => -- Shift Right
         for i in 0 to 8 loop 
          pattern(i) <= pattern(i+1); 
         end loop; 
         pattern(9) <= pattern(0); 

       when '1' =>  -- Shift Left
          for i in 0 to 8 loop 
          pattern(i+1) <= pattern(i); 
         end loop; 
         pattern(0) <= pattern(9); 
       
	when others => -- Error Case
          pattern <= pattern;
	
	end case;
     end if;
    end if;
  end process;
  
  val_out <= pattern;

end behav;
