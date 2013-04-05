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

component VideoController is
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
end component;

signal Reset_h : std_logic;

begin

Reset_h <= not Reset; -- The push buttons are active low

VideoController_instance : VideoController
   Port map(clk => clk,
            Reset => Reset_h,
            hs => hs,
            vs => vs,
            VGA_clk => VGA_clk,
            blank => blank,
            sync => sync,
            Red => Red,
            Green => Green,
            Blue => Blue);

end Behavioral;      
