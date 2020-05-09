-- State machine to control shift register
-- for LED demo display.
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_control is
  port( cnt1m, cnt10, clk, rstb: in std_logic;
        shift_reg_mode: out std_logic_vector(1 downto 0));
end led_control;

architecture behav of led_control is

  -- Declare state type
  type control_state is (Init, HoldLeft, ShiftLeft, HoldRight, ShiftRight);
  signal state: control_state;
begin

  -- Implement flip-flops for state machine
  process (clk, rstb)
  begin
    if (rstb = '0') then -- asynchronous active low reset
      state <= Init;
    elsif (clk'event) and (clk = '1') then
      case state is

        -- Initial State
        when Init =>
          state <= HoldLeft;

        -- HoldLeft
        when HoldLeft =>
          if cnt1m = '1' then
            state <= ShiftRight;
          else
            state <= HoldLeft;
          end if;

        -- ShiftRight
        when ShiftRight =>
          if cnt10 = '1' then
            state <= HoldRight;
          else
            state <= ShiftRight;
          end if;

        -- HoldRight
        when HoldRight =>
          if cnt1m = '1' then
            state <= ShiftLeft;
          else
            state <= HoldRight;
          end if;

         -- ShiftLeft 
        when ShiftLeft =>
          if cnt10 = '1' then
            state <= HoldLeft;
          else
            state <= ShiftLeft;
          end if;


        -- Error Case
        when others =>
          state <= Init;  
      end case;
    end if;
  end process;
  
  -- Generate outputs based on state
  process(state)
  begin
    case state is
      when Init => shift_reg_mode <= "00"; -- Load
      when HoldLeft => shift_reg_mode <= "00"; -- Load
      when ShiftLeft => shift_reg_mode <= "10"; -- left shift
      when ShiftRight => shift_reg_mode <= "01"; -- shift right
      when HoldRight => shift_reg_mode <= "11"; -- Load
      when others => shift_reg_mode <= "00"; -- hold in both hold states or on error
    end case;
  end process;

end behav;
