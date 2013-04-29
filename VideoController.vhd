-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|         VideoController.vhd         |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|  This is the highest level entity   |--
--|   for the video output. It will be  |--
--| responsible for coordinate the      |--
--| mapping of various graphics to the  |--
--|               screen.               |--
-------------------------------------------
--|            Change Log               |--
--|   4/4/2013 - Created the file and   |--
--|   started filling in some general   |--
--|    items and comments to try and    |--
--|   describe what this unit will do   |--
--|-------------------------------------|--
-------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity VideoController is
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
end VideoController;

architecture Behavioral of VideoController is

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

component BackgroundColor is
    Port ( DrawX : in std_logic_vector(9 downto 0);
           DrawY : in std_logic_vector(9 downto 0);
           Red   : out std_logic_vector(9 downto 0);
           Green : out std_logic_vector(9 downto 0);
           Blue  : out std_logic_vector(9 downto 0));
end component;

component Grid is
   Port ( DrawX   : in std_logic_vector(9 downto 0);
          DrawY   : in std_logic_vector(9 downto 0);
          InRed   : in std_logic_vector(9 downto 0);
          InGreen : in std_logic_vector(9 downto 0);
          InBlue  : in std_logic_vector(9 downto 0);
          Red     : out std_logic_vector(9 downto 0);
          Green   : out std_logic_vector(9 downto 0);
          Blue    : out std_logic_vector(9 downto 0));
end component;

signal vsSig : std_logic;
signal DrawXSig, DrawYSig : std_logic_vector(9 downto 0);
signal BGred, BGgreen, BGblue : std_logic_vector(9 downto 0);

begin

vgaSync_instance : vga_controller
   Port map(clk => clk,
            Reset => not Reset,
            hs => hs,
            vs => vsSig,
            pixel_clk => VGA_clk,
            blank => blank,
            sync => sync,
            DrawX => DrawXSig,
            DrawY => DrawYSig);

Color_instance : BackgroundColor
   Port Map(DrawX => DrawXSig,
            DrawY => DrawYSig,
            Red => BGred,
            Green => BGgreen,
            Blue => Bgblue);

Grid_instance : Grid
   Port Map(DrawX => DrawXSig,
            DrawY => DrawYSig,
            InRed => BGred,
            InGreen => BGgreen,
            InBlue => BGblue,
            Red => Red,
            Green => Green,
            Blue => Blue);

vs <= vsSig;

end Behavioral;      
