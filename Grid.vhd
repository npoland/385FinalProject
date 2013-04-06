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
signal DrawXOn, DrawYOn : std_logic;
begin

  DisplayGrid : process (DrawX, DrawY)
  
  begin
    if (DrawX(9 downto 0) = "0000001000") then
      DrawXOn <= '1';
    elsif (DrawX(9 downto 0) = "1001111001") then
      DrawXOn <= '0';
    end if;
    
    if (DrawY(9 downto 0) = "0000100000") then
      DrawYOn <= '1';
    elsif (DrawY(9 downto 0) = "0111000001") then
      DrawYOn <= '0';
    end if;
        
    if ((((DrawX(9 downto 0) = "0000001000") or
         (DrawX(9 downto 0) = "0000111100") or
         (DrawX(9 downto 0) = "0001110000") or
         (DrawX(9 downto 0) = "0010100100") or
         (DrawX(9 downto 0) = "0011011000") or
         (DrawX(9 downto 0) = "0100001100") or
--         (DrawX(9 downto 0) = "0101000000") or
         (DrawX(9 downto 0) = "0101110100") or
         (DrawX(9 downto 0) = "0110101000") or
         (DrawX(9 downto 0) = "0111011100") or
         (DrawX(9 downto 0) = "1000010000") or
         (DrawX(9 downto 0) = "1001000100") or
         (DrawX(9 downto 0) = "1001111000")) or
        ((DrawY(9 downto 0) = "0000100000") or
         (DrawY(9 downto 0) = "0001010100") or
         (DrawY(9 downto 0) = "0010001000") or
         (DrawY(9 downto 0) = "0010111100") or
--         (DrawY(9 downto 0) = "0011110000") or
         (DrawY(9 downto 0) = "0100100100") or
         (DrawY(9 downto 0) = "0101011000") or
         (DrawY(9 downto 0) = "0110001100") or
         (DrawY(9 downto 0) = "0111000000"))) and (DrawXOn = '1') and (DrawYOn = '1')) then
      Red   <= "1111111111";
      Green <= "1111111111";
      Blue  <= "1111111111";
    elsif (((DrawX(9 downto 0) = "0101000000") or (DrawY(9 downto 0) = "0011110000")) and (DrawXOn = '1') and (DrawYOn = '1')) then
      Red   <= "1000000000";
      Green <= "0000000000";
      Blue  <= "1000000000";
    else
      Red   <= InRed;
      Green <= InGreen;
      Blue  <= InBlue;
    end if;
  end process DisplayGrid;

end Behavioral;