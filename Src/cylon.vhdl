library ieee;
use ieee.std_logic_1164.all;

entity cylon is
  port( clk, rstb , key: in std_logic;
        lights: out std_logic_vector(9 downto 0));
end cylon;

architecture behav of cylon is

  -- Declare Components
  component shiftreg10 
    port( load_val: in std_logic_vector(9 downto 0);
          clk, rstb: in std_logic;
          mode: in std_logic_vector(1 downto 0); -- 00 hold, 01 right, 10 left, 11 load 
          val_out: out std_logic_vector(9 downto 0));
  end component;
  
  component counter_src
    port( clk, rstb, clr, en: in std_logic;
          sig_01, sig_02, sig_04, sig_08, sig_16, sig_32: in std_logic; 
          cntM: out std_logic);
  end component;
  
  component counter10 
    port( clk, rstb, clr, en: in std_logic;
          cnt10: out std_logic);
  end component;
  
  component led_control 
    port( cnt1m, cnt10, clk, rstb: in std_logic;
        shift_reg_mode: out std_logic_vector(1 downto 0));
  end component;

  component clock_control 
    port( key, clk, rstb: in std_logic;
          time_01, time_02, time_04, time_08, time_16, time_32: out std_logic;
  end component;
  
  -- Declare Signals
  signal cnt_mode, cnt_10: std_logic;
  signal T01, T02, T04, T08, T16, T32: std_logic;
  signal start_pattern, shifter_out: std_logic_vector(9 downto 0);
  signal shifter_mode: std_logic_vector(1 downto 0);


begin  

  -- Tie lights to pattern
  lights <= shifter_out;

  start_pattern <= "0000000001";


  -- instantiate counter source
  ctr0: counter_src port map(clk, rstb, '0', '1', T01, T02, T04, T08, T16, T32, cnt_mode);
  -- instantiate counter10
  ctr1: counter10 port map(clk, rstb, '0', cnt_mode, cnt_10);
  -- instantiate shifter
  shifter0: shiftreg10 port map(start_pattern, clk, rstb, shifter_mode, shifter_out);
  -- instantiate LED controller
  sm0: led_control port map(cnt_1m, cnt_10, clk, rstb, shifter_mode);
  -- instantiate Counter controller
  sm1: led_control port map(key, clk, rstb, T01, T02, T04, T08, T16, T32);
  

  
end behav;
