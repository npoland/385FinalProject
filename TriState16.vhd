-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|          TriStateBuffer.vhd         |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|  This is a 16-bit tri-state buffer  |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TriState16 is
  port( Din: in std_logic_vector(15 downto 0);
        Ena : in std_logic;
        Dout: out std_logic_vector(15 downto 0));
end TriState16;

architecture behavioral of TriState16 is
begin
   Dout <= Din when (Ena = '1') else "ZZZZZZZZZZZZZZZZ";
end behavioral;