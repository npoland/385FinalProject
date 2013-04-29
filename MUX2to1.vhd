-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|              MUX_2to1.vhd           |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|         This is a 2 to 1 mux        |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity MUX2to1 is
  port( sel : in std_logic;
        D0, D1 : in std_logic_vector(15 downto 0);
        Dout: out std_logic_vector(15 downto 0));
end entity;

architecture behavioral of MUX2to1 is
begin
  with sel select  
    Dout <= D0 when '0',
            D1 when '1';
end behavioral;