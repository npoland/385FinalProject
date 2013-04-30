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



entity CharMapper is
   port ( DrawX     : in  std_logic_vector(9 downto 0);
          DrawY     : in std_logic_vector(9 downto 0);
          RedIn     : in std_logic_vector(9 downto 0);
          BlueIn    : in std_logic_vector(9 downto 0);
          GreenIn   : in std_logic_vector(9 downto 0);
          RedOut    : out std_logic_vector(9 downto 0);
          BlueOut   : out std_logic_vector(9 downto 0);
          GreenOut  : out std_logic_vector(9 downto 0);
          addr      : out std_logic_vector(11 downto 0)
          );
end CharMapper;
architecture Behavioral of CharMapper is

signal current  : std_logic_vector(11 downto 0)  := "000000000000";
signal countx   : std_logic_vector(2 downto 0) := "000";
signal county   : std_logic_vector(15 downto 0) := "0000000000000000";
begin

--just put to screen whatever is in the CharGrid

--Some counting needs to be done because the characters are in an array thing

--when drawX changes so does the address of the character

--when drawY changes there needs to be some kind of offset
--ex drawY between zero and 15 is not offset so... we can divide
--drawY by 16 using some shifts

	xPosition : process(DrawX(0))
	begin

		if(countx = "111") then
      BlueOut <="0000000000";
    else
			BlueOut <="1111111111";
		end if;
		  countx  <= countx + 1;
	end process;

--Mask DrawY 

  RedOut   <="1111111111";
  GreenOut <="1111111111";

end Behavioral;