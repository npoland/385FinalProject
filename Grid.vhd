-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|                Grid.vhd             |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|  This maps the grid to the screen.  |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity Grid is
   Port ( DrawX   : in std_logic_vector(9 downto 0);
          DrawY   : in std_logic_vector(9 downto 0);
          InRed   : in std_logic_vector(9 downto 0);
          InGreen : in std_logic_vector(9 downto 0);
          InBlue  : in std_logic_vector(9 downto 0);
          Red     : out std_logic_vector(9 downto 0);
          Green   : out std_logic_vector(9 downto 0);
          Blue    : out std_logic_vector(9 downto 0));
end Grid;

architecture Behavioral of Grid is

signal Xdivision, Ydivision : std_logic_vector(9 downto 0);
begin

  Xdivision <= "1111101111";
  Ydivision <= "1111101111";
  
--  Xcounter : process (DrawX)
--  begin
--    if (Xcount < "0000000100") then
--      Xcount <= Xcount + "0000000001";
--      GridON <= '1';
--    else
--      GridON <= '0';
--      Xcount <= "0000000000";
--    end if;
--  end process Xcounter;
--  
--  Ycounter : process (DrawY)
--  begin
--  
--  end process Ycounter;

  DisplayGrid : process (DrawX, DrawY)
  
  begin
    if (((DrawX(4 downto 0) xor Xdivision(4 downto 0)) = "111") or ((Drawy(4 downto 0) xor Ydivision(4 downto 0)) = "111")) then
      Red   <= "1111111111";
      Green <= "1111111111";
      Blue  <= "1111111111";
    else
      Red   <= InRed;
      Green <= InGreen;
      Blue  <= InBlue;
    end if;
  end process DisplayGrid;

end Behavioral;