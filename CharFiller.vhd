-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|              CharGrid.vhd           |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|Makes the grid that will go on screen|--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Here is what I imagine implementing in code here
-- an 80x30 array of 8-bit hex values one of these
-- will be made and passed around until it gets put
-- on the screen.


entity CharFiller is
    Port ( Clk : in std_logic;
           reset : in std_logic);
end CharFiller;


architecture Behavioral of CharFiller is
  component CharGrid is
      Port ( dataIn	   : in std_logic_vector(7 downto 0);
             addr	     : in std_logic_vector(11 downto 0);
             we		     : in std_logic;
             clk		   : in std_logic;
             dataOut   : out std_logic_vector(7 downto 0));
  end component;


  constant count  : std_logic_vector(11 downto 0) := "100101011111";
  
  --horizontal pixel and vertical line counters
  signal current : std_logic_vector(11 downto 0) := "000000000000";
  signal we      : std_logic;
  signal dataIn  : std_logic_vector(7 downto 0) := "00001000";

begin

CharG : CharGrid
   Port map(clk => clk,
            we => we,
            addr => current,
            dataIn => dataIn);

  counter_proc : process(Clk)
    begin
    if (reset = '1') then
      current <= "000000000000";
    elsif (rising_edge(Clk)) then
      if (current = count) then    --Do nothing
        current <= current;
        we <= '0';
      else
        we <= '1';
        current <= current + 1; -- add to count
      end if;
    end if;
  end process;
end behavioral;

