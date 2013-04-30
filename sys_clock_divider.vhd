library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

------------------------------------------------
--This entity uses a 9 bit counter to divide the the system clock by 512
-- The output is the most significant bit, so the clock is high for a
-- Period of 2^8 system clock cycles
------------------------------------------------
entity sys_clock_divider is
  port(	Clk: in std_logic;
        DivClock: out std_logic);
end sys_clock_divider;

architecture behavior of sys_clock_divider is 
signal count: std_logic_vector (8 downto 0);

begin
  counting : process(clk)
  begin
    if (rising_edge(clk)) then
      count <= count + "000000001";
      DivClock <= count(8);
    end if;
  end process;	
end behavior;