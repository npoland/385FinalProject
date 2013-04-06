-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|                I2C.vhd              |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|      Handles I2C communications     |--
-------------------------------------------
--|            Change Log               |--
--|    4/5/2013 - Created the file      |--
--|-------------------------------------|--
-------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity I2C is
   Port ( Clk    : in std_logic;
          Enable : in std_logic;
          RW     : in std_logic;
          SDL    : out std_logic;
          SCL    : out std_logic;
end BackgroundColor;

architecture Behavioral of I2C is

begin

  I2C_Write : process (Enable)
  begin
    if (RW = '1') then
      
    else
      
    end if;
  end process I2C_Write;
  
  I2C_Read : process (Enable)
  begin
    if (RW = '0') then
      
    else
      
    end if;
  end process I2C_Read;

end Behavioral;