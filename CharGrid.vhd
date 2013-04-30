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
entity CharGrid is
   port
   (
      initalize      : in   std_logic;
      clock          : in   std_logic;
      data           : in   std_logic_vector (7 downto 0);
      write_address  : in   integer range 0 to 2399;
      read_address   : in   integer range 0 to 2399;
      we             : in   std_logic;
      q              : out  std_logic_vector (7 downto 0)
   );
end CharGrid;
architecture rtl of CharGrid is
   type mem is array(0 to 2399) of std_logic_vector(7 downto 0);
   signal ram_block : mem;
   signal count : integer range 0 to 2400;
begin
   process (initalize)
   begin
     count <= 0;
     if (count /= 2400) then
      --do nothing
     elsif (count < 1000) then
      ram_block(count) <= "00000000";
      count <=count + 1;
     else
      ram_block(count) <= "11111111";
      count <= count + 1;
     end if;
   end process;
   process (clock)
   begin
      if (clock'event and clock = '1') then
         if(we = '1') then
            ram_block(write_address) <= data;
         end if;
         q <= ram_block(read_address);
      end if;
   end process;
end rtl;