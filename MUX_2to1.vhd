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

library work;
use work.SLC3_2.all;

entity MUX_2to1 is
  port( sel : in std_logic_vector(1 downto 0);
        D0, D1, D2, D3 : in std_logic_vector(15 downto 0);
        Dout: in std_logic_vector(15 downto 0));
end entity;

architecture behavioral of MUX_2to1 is
begin
  with sel select  
    Dout <= D0 when "00",
            D1 when "00",
            D2 when "00",
            D3 when "00",
            x"0000" when others;
end behavioral;