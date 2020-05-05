library ieee;
use ieee.std_logic_1164.all;

entity cylon is
  port( clk, rstb: in std_logic;
        lights: out std_logic_vector(9 downto 0));
end cylon;

architecture behav of cylon is

  -- Declare Components
  component shiftreg10 is
    port( load_val: in std_logic_vector(9 downto 0);
          clk, rstb: in std_logic;
          mode: in std_logic_vector(1 downto 0); -- 00 hold, 01 right, 10 left, 11 load 
          val_out: out std_logic_vector(9 downto 0));
  end component;
  
  component counter1m is
    port( clk, rstb, clr, en: in std_logic;
          cnt1m: out std_logic);
  end component;
  
  component counter10 is
    port( clk, rstb, clr, en: in std_logic;
          cnt10: out std_logic);
  end component;
  
  component led_control is
    port( cnt1m, cnt10, clk, rstb: in std_logic;
        shift_reg_mode: out std_logic_vector(1 downto 0));
  end component;
  
  -- Declare Signals
  signal cnt_1m, cnt_10: std_logic;
  signal start_pattern, shifter_out: std_logic_vector(9 downto 0);
  signal shifter_mode: std_logic_vector(1 downto 0);


begin  

  -- Tie lights to pattern
  lights <= shifter_out;

  start_pattern <= "0000000001";


  -- instantiate counter1m
  ctr0: counter1m port map(clk, rstb, '0', '1', cnt_1m);
  -- instantiate counter17
  ctr1: counter10 port map(clk, rstb, '0', cnt_1m, cnt_10);
  -- instantiate shifter
  shifter0: shiftreg10 port map(start_pattern, clk, rstb, shifter_mode, shifter_out);
  -- instantiate controller
  sm0: led_control port map(cnt_1m, cnt_10, clk, rstb, shifter_mode);
  
  



  
end behav;
