-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|               Scope.vhd             |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|  This is the highest level entity   |--
--|       for the entire project.       |--
-------------------------------------------
--|            Change Log               |--
--|    4/4/2013 - Created the file      |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Scope is
    Port ( Clk : in std_logic;
           Reset : in std_logic;
           Red   : out std_logic_vector(9 downto 0);
           Green : out std_logic_vector(9 downto 0);
           Blue  : out std_logic_vector(9 downto 0);
           VGA_clk : out std_logic; 
           sync : out std_logic;
           blank : out std_logic;
           vs : out std_logic;
           hs : out std_logic);
end Scope;

architecture Behavioral of Scope is

component vga_controller is
    Port ( clk : in std_logic;
           reset : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           pixel_clk : out std_logic;
           blank : out std_logic;
           sync : out std_logic;
           DrawX : out std_logic_vector(9 downto 0);
           DrawY : out std_logic_vector(9 downto 0));
end component;

component Color_Mapper is
    Port ( DrawX : in std_logic_vector(9 downto 0);
           DrawY : in std_logic_vector(9 downto 0);
           Red   : out std_logic_vector(9 downto 0);
           Green : out std_logic_vector(9 downto 0);
           Blue  : out std_logic_vector(9 downto 0));
end component;

signal Reset_h, vsSig : std_logic;
signal DrawXSig, DrawYSig : std_logic_vector(9 downto 0);

begin

Reset_h <= not Reset; -- The push buttons are active low

vgaSync_instance : vga_controller
   Port map(clk => clk,
            reset => Reset_h,
            hs => hs,
            vs => vsSig,
            pixel_clk => VGA_clk,
            blank => blank,
            sync => sync,
            DrawX => DrawXSig,
            DrawY => DrawYSig);

Color_instance : Color_Mapper
   Port Map(DrawX => DrawXSig,
            DrawY => DrawYSig,
            Red => Red,
            Green => Green,
            Blue => Blue);

vs <= vsSig;

end Behavioral;      
