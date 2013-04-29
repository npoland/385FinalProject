-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|              CharGrid.vhd           |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|Makes the grid that will go on screen|--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Here is what I imagine implementing in code here
-- an 80x30 array of 8-bit hex values one of these
-- will be made and passed around until it gets put
-- on the screen.


entity CharGrid is
	port
	(
		dataIn	  : in std_logic_vector(7 downto 0);
		addr	    : in std_logic_vector(11 downto 0);
		we		    : in std_logic;
		clk		    : in std_logic;
		dataOut		: out std_logic_vector(7 downto 0)
	);
	
end entity;

architecture behavioral of CharGrid is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(2399 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : memory_t;
	
	-- Register to hold the address
	signal addr_reg : std_logic_vector(11 downto 0);

begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we = '1') then
				ram(conv_integer(addr)) <= dataIn;
			end if;
			
			-- Register the address for reading
			addr_reg <= addr;
		end if;
	
	end process;
	
	dataOut <= ram(conv_integer(addr_reg));
	
end behavioral;

