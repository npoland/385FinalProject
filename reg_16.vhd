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

entity reg_16 is
Port (  Load,Clk,Reset 			: in std_logic;
        DataIn 			: in std_logic_vector(15 downto 0);
        DataOut 		: out std_logic_vector(15 downto 0));
end reg_16;

architecture Behavioral of reg_16 is
signal reg_value: std_logic_vector(15 downto 0);

begin
  operate_reg : process (Clk, Reset, Load)
    begin
      if (Reset = '1') then 
        reg_value <= x"0000"; 
      elsif (rising_edge(Clk)) then
      if (Load = '1') then
        reg_value <= DataIn;
      else
        reg_value <= reg_value;
      end if;
    end if;
  end process;
  DataOut <= reg_value;
end Behavioral;


