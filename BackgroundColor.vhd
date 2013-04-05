-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|           BackgroundColor.vhd       |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--| This maps colors to the screen. For |--
--|  now this is just to test the VGA.  |--
--|  This will be replaced eventually.  |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity BackgroundColor is
   Port ( DrawX : in std_logic_vector(9 downto 0);
          DrawY : in std_logic_vector(9 downto 0);
          Red   : out std_logic_vector(9 downto 0);
          Green : out std_logic_vector(9 downto 0);
          Blue  : out std_logic_vector(9 downto 0));
end BackgroundColor;

architecture Behavioral of BackgroundColor is

begin

  RGB_Display : process (DrawX, DrawY)
  begin
    Red   <= "0000000000";
    Green <= "0000000000";
    Blue  <= "0000000000";
  end process RGB_Display;

end Behavioral;