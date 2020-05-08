-- State machine to control shift register
-- for LED demo display.
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clock_control is
  port( key, clk, rstb: in std_logic;
        time_01, time_02, time_04, time_08, time_16, time_32: out std_logic;
end clock_control;

architecture behav of led_control is

  -- Declare state type
  type time_state is (Init, T01, T02, T04, T08, T16, T32);
  signal state: time_state;
begin

  -- Implement flip-flops for state machine
  process (clk, rstb)
  begin
    if (rstb = '0') then -- asynchronous active low reset
      state <= T01;
    elsif (clk'event) and (clk = '1') then
      case state is
    
        -- Rate 0.01s
        when T01 =>
          if key = '0' then
            state <= T02;
          else
            state <= T01;
          end if;

        -- Rate 0.02s
        when T02 =>
          if key = '0' then
            state <= T04;
          else
            state <= T02;
          end if;

        -- Rate 0.04s
        when T04 =>
          if key = '0' then
            state <= T08;
          else
            state <= T04;
          end if;

        -- Rate 0.08s
        when T08 =>
          if key = '0' then
            state <= T16;
          else
            state <= T08;
          end if;

        -- Rate 0.16s
        when T16 =>
          if key = '0' then
            state <= T32;
          else
            state <= T16;
          end if;

        -- Rate 0.32s
        when T32 =>
          if key = '0' then
            state <= T01;
          else
            state <= T32;
          end if;

        -- Error Case
        when others =>
          state <= T01;  
      end case;
    end if;
  end process;
  
  -- Generate outputs based on state
  process(state)
  begin
    case state is
      when T01 =>  time_01 <= '1'; time_02 <= '0'; time_04 <= '0'; time_08 <= '0'; time_16 <= '0'; time_32 <= '0'; -- T = 0.01
      when T02 =>  time_01 <= '0'; time_02 <= '1'; time_04 <= '0'; time_08 <= '0'; time_16 <= '0'; time_32 <= '0'; -- T = 0.02
      when T04 =>  time_01 <= '0'; time_02 <= '0'; time_04 <= '1'; time_08 <= '0'; time_16 <= '0'; time_32 <= '0'; -- T = 0.04
      when T08 =>  time_01 <= '0'; time_02 <= '0'; time_04 <= '0'; time_08 <= '1'; time_16 <= '0'; time_32 <= '0'; -- T = 0.08
      when T16 =>  time_01 <= '0'; time_02 <= '0'; time_04 <= '0'; time_08 <= '0'; time_16 <= '1'; time_32 <= '0'; -- T = 0.16
      when T32 =>  time_01 <= '0'; time_02 <= '0'; time_04 <= '0'; time_08 <= '0'; time_16 <= '0'; time_32 <= '1'; -- T = 0.32
      when others =>  time_01 <= '1'; time_02 <= '0'; time_04 <= '0'; time_08 <= '0'; time_16 <= '0'; time_32 <= '0'; -- T = 0.01
    end case;
  end process;

end behav;
