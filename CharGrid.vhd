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
use ieee.numeric_std.all;

entity CharGrid is
   port
   (
      initalize      : in   std_logic;
      clock          : in   std_logic;
      data           : in   std_logic_vector (7 downto 0);
      addrIn         : in   std_logic_vector(11 downto 0);
      addrOut        : out  std_logic_vector(11 downto 0);
      q              : out  std_logic_vector (7 downto 0)
   );
end CharGrid;
architecture rtl of CharGrid is
   signal count : integer range 0 to 2400;
   signal char : integer range 0 to 100;
begin
--   process (initalize)
--   begin
--     count <= 0;
--     if (count /= 2400) then
--      --do nothing
--     elsif (count < 1000) then
--      ram_block(count) <= "00000000";
--      count <=count + 1;
--     else
--      ram_block(count) <= "11111111";
--      count <= count + 1;
--     end if;
--   end process;
   process (initalize, clock)
   begin
     count <= 0;
     if ((count = 2400) or (char = 99)) then
      char <= 0;
      addrOut <= addrIn;
     else
      q <= std_logic_vector(to_unsigned(char, 8));
      addrOut <= std_logic_vector(to_unsigned(count, 12));
      char <= char + 1;
      count <= count + 1;
     end if;
   end process;

end rtl;