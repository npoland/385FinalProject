-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|            MenuControl.vhd          |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|   This is the menu state machine.   |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- The menu needs some decision on the structure,
-- but this will be a state machine for it.

