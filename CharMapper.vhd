-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|             CharMapper.vhd          |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--| This takes the 640x480 pixel screen |--
--|  and turns it into a 80x30 grid of  |--
--|  8x16 pixels. These will be called  |--
--|     chunks. This makes it easier    |--
--|    to map characters, make menus,   |--
--|  and probably do some other stuff.  |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- I need to take inputs for each chunk in the screen
-- in as 8 bit hex values and "ff" denotes space allocated
-- to the scope. This will have to be 64 chunks by 16 to
-- make the 512x256 pixel grid for the scope.

-- The chunks will come from outside entities and will
-- be passed to the scope mapping entity. There will
-- need to be:
-- -menu mapper
-- -division maper(for time and volts and stuff)
-- -some stats?

