-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|         AudioChipInterface.vhd      |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--| This will be the lowest level that  |--
--|  interacts directly with the audio  |--
--|  chip on the DE2 board to get the   |--
--|  incoming signal to be processed.   |--
-------------------------------------------
--|            Change Log               |--
--|    4/5/2013 - Created the file      |--
--|-------------------------------------|--
-------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity AudioInterface is
   Port ( Clk        : in std_logic;
          Enable     : in std_logic;
          TakeSample : in std_logic);
end AudioInterface;

architecture Behavioral of AudioInterface is

begin

  AudioInterface : process (Enable)
  begin

  end process AudioInterface;


end Behavioral;