-- State machine to control shift register
-- for LED demo display.
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clock_control is
  port( key, clk, rstb: in std_logic;
        time_01, time_02, time_04, time_08, time_16, time_32: out std_logic);
end clock_control;

architecture behav of clock_control is

  -- Declare state type  
  type state_type is (T01, T02, T04, T08, T16, T32);
  signal current_state, next_state: state_type;

begin

  sequential:
  process (clk, rstb, key)
  begin

  case current_state is

  -- Rate 0.01s
        when T01 =>
          if key = '0' then
            next_state <= T02;
          else
            next_state <= T01;
          end if;

        -- Rate 0.02s
        when T02 =>
          if key = '0' then
            next_state <= T04;
          else
            next_state <= T02;
          end if;

        -- Rate 0.04s
        when T04 =>
          if key = '0' then
            next_state <= T08;
          else
            next_state <= T04;
          end if;

        -- Rate 0.08s
        when T08 =>
          if key = '0' then
            next_state <= T16;
          else
            next_state <= T08;
          end if;

        -- Rate 0.16s
        when T16 =>
          if key = '0' then
            next_state <= T32;
          else
            next_state <= T16;
          end if;

        -- Rate 0.32s
        when T32 =>
          if key = '0' then
            next_state <= T01;
          else
            next_state <= T32;
          end if;

        -- Error Case
        when others =>
          next_state <= T01;  
      end case;    

    end process sequential;




    	clock_state_machine:
	process(clk,rstb)
	begin
	if (rstb = '0') then
	current_state <= T01;
	elsif (clk'event and clk = '1') then
	current_state <= next_state;
	end if;
	end process clock_state_machine;


	combinational:
	process(clk, rstb)
	begin

	if ( clk'event and clk = '1') then

	if (current_state = T01) then
	time_01 <= '1'; time_02 <= '0'; time_04 <= '0'; time_08 <= '0'; time_16 <= '0'; time_32 <= '0'; -- T = 0.01
	end if;

	if (current_state = T02) then
	time_01 <= '0'; time_02 <= '1'; time_04 <= '0'; time_08 <= '0'; time_16 <= '0'; time_32 <= '0'; -- T = 0.02
	end if;

	if (current_state = T04) then
	time_01 <= '0'; time_02 <= '0'; time_04 <= '1'; time_08 <= '0'; time_16 <= '0'; time_32 <= '0'; -- T = 0.04
	end if;

	if (current_state = T08) then
	time_01 <= '0'; time_02 <= '0'; time_04 <= '0'; time_08 <= '1'; time_16 <= '0'; time_32 <= '0'; -- T = 0.08
	end if;

	if (current_state = T16) then
	time_01 <= '0'; time_02 <= '0'; time_04 <= '0'; time_08 <= '0'; time_16 <= '1'; time_32 <= '0'; -- T = 0.16
	end if;

	if (current_state = T32) then
	time_01 <= '0'; time_02 <= '0'; time_04 <= '0'; time_08 <= '0'; time_16 <= '0'; time_32 <= '1'; -- T = 0.32
	end if;


	end if;

	end process combinational;
 

end behav;
