library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Dreg is
	port(	D, 
			Clk, 
			reset, 
			ld:  	in std_logic;
			Q,Qbar : 	out std_logic);
end Dreg;

architecture behavior of Dreg is 
begin
	operate : process(reset, clk)
	begin
		if (reset = '1') then
			Q <= '0';
		elsif (rising_edge(clk)) then	--
			if (ld = '1') then
               Q <= D;					--else Q is unchanged
               Qbar <= not D;
           end if;
	   end if;
	end process;
end behavior;