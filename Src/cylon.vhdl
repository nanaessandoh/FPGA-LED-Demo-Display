library ieee;
use ieee.std_logic_1164.all;

entity cylon is
  port( clk, rstb , key: in std_logic;
        lights: out std_logic_vector(9 downto 0));
end cylon;

architecture behav of cylon is

  -- Declare Components
component shift_reg
  port( clk,rstb, en: in std_logic;
        mode: in std_logic; -- 0 left, 1 right
        val_out: out std_logic_vector(9 downto 0));
end component;
  
  component counter_src
    port( clk, rstb, en: in std_logic;
          sig_01, sig_02, sig_04, sig_08, sig_16, sig_32: in std_logic; 
          cntM: out std_logic);
  end component;
  
  component clock_control 
    port( key, clk, rstb: in std_logic;
          time_01, time_02, time_04, time_08, time_16, time_32: out std_logic);
  end component;

  component led_control
    port( cnt10, clk, rstb: in std_logic;
        shift_reg_mode: out std_logic );
  end component;

  component counter10 is
    port( clk, rstb, en: in std_logic;
        cnt10: out std_logic);
  end component;


  
  -- Declare Signals
  signal cntM, cnt_10: std_logic;
  signal T_01, T_02, T_04, T_08, T_16, T_32: std_logic;
  signal shifter_out: std_logic_vector(9 downto 0);
  signal shifter_mode: std_logic;


begin  

  -- Tie lights to pattern
  lights <= shifter_out;


  -- instantiate counter source
  ctr0: counter_src port map(clk, rstb,'1', T_01, T_02, T_04, T_08, T_16, T_32, cntM);

  -- instantiate counter10
  ctr1: counter10 port map(clk, rstb, cntM, cnt_10);

  -- instantiate shifter
  shifter0: shift_reg port map(clk, rstb, cntM , shifter_mode, shifter_out);

  -- instantiate LED controller
  ledctrl0: led_control port map(cnt_10, clk, rstb, shifter_mode);

  -- instantiate Counter controller
  sm1: clock_control port map(key, clk, rstb, T_01, T_02, T_04, T_08, T_16, T_32);
  
  
end behav;
