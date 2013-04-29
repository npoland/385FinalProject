-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|               reg_16.vhd            |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|       This is a 16-bit register     |--
--|-------------------------------------|--
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reg_8bit_temp is
Port (  ld,clk,reset_n 	: in std_logic;
        DIN 			      : in std_logic;
        DOUT 		        : out std_logic_vector(7 downto 0));
end reg_8bit_temp;

architecture Behavioral of reg_8bit_temp is

signal reg_val: std_logic_vector(7 downto 0);

begin
  update_register: process(clk)
  BEGIN
    IF(reset_n = '0')THEN
      reg_val <= x"00";
    ELSIF(clk'EVENT AND clk = '1')THEN
      IF(ld = '1')THEN
        reg_val <= reg_val(6 downto 0) & DIN;
      END IF;
    END IF;
  END PROCESS;
  DOUT <= reg_val;
end Behavioral;

