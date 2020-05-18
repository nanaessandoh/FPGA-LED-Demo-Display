-- State machine to control shift register
-- for LED demo display.
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_control is
  port( cnt10, clk, rstb: in std_logic;
        shift_reg_mode: out std_logic );
end led_control;

architecture behav of led_control is
  -- Declare state type
  type state_type is (Reset, ShiftLeft, ShiftRight);
  signal current_state, next_state: state_type;


begin


  Sequential:
  process (clk, rstb)
  begin
      case current_state is

        when Reset =>
          next_state <= ShiftRight;

        when ShiftRight =>
          if cnt10 = '1' then
            next_state <= ShiftLeft;
          else
            next_state <= ShiftRight;
          end if;

        when ShiftLeft =>
          if cnt10 = '1' then
            next_state <= ShiftRight;
          else
            next_state <= ShiftLeft;
          end if;

        when others =>
          -- Error case
          next_state <= Reset;  

      end case;
    end process;


    	clock_state_machine:
	process(clk,rstb)
	begin
	if (rstb = '0') then
	current_state <= Reset;
	elsif (clk'event and clk = '1') then
	current_state <= next_state;
	end if;
	end process clock_state_machine;
  

	combinational:
	process(clk, rstb)
	begin

	if ( clk'event and clk = '1') then


	if (current_state = ShiftRight) then
	shift_reg_mode <= '0';
	end if;

	if (current_state = ShiftLeft) then
	shift_reg_mode <= '1';
	end if;

	end if;

	end process combinational;


  
  end behav;
  