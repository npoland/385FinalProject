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


entity HxDriver is
   port ( In0  : in  std_logic_vector(3 downto 0);
          Out0 : out std_logic_vector(6 downto 0));
end HxDriver;
architecture Behavioral of HxDriver is

begin
  with In0 select
    Out0 <= "1000000" when "0000" , -- '0'
            "1111001" when "0001" , -- '1'
            "0100100" when "0010" , -- '2'
            "0110000" when "0011" , -- '3'
            "0011001" when "0100" , -- '4'
            "0010010" when "0101" , -- '5'
            "0000010" when "0110" , -- '6'
            "1111000" when "0111" , -- '7'
            "0000000" when "1000" , -- '8'
            "0010000" when "1001" , -- '9'
            "0001000" when "1010" , -- 'A'
            "0000011" when "1011" , -- 'B'
            "1000110" when "1100" , -- 'C'
            "0100001" when "1101" , -- 'D'
            "0000110" when "1110" , -- 'E'
            "0001110" when "1111" , -- 'F'
            "XXXXXXX" when others;
end Behavioral;