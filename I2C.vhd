-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|                I2C.vhd              |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--|      Handles I2C communications     |--
-------------------------------------------
--|            Change Log               |--
--|    4/5/2013 - Created the file      |--
--|-------------------------------------|--
-------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity I2C is
   Port ( Clk    : in std_logic;
          Enable : in std_logic;
          RW     : in std_logic;
          SDL    : out std_logic;
          SCL    : out std_logic;
end BackgroundColor;


entity I2C is
    Port( clk           : in std_logic;
          Reset         : in std_logic;
end I2C;

architecture Behavioral of I2C is

type ctrl_state is (Halted,
                    start1,
                    start2,
                    
                    
                    
                    
                    
                    );
signal State, Next_state : ctrl_state;

begin

-- State Machine Halted--
Assign_Next_State : process (clk, reset)
begin
  if (Reset = '1') then
    State <= Halted;
  elsif (rising_edge(clk)) then
    State <= Next_state;
  end if;
end process;

Get_Next_State : process (State, Enable)
begin
  case State is
    when Halted => 
      if (Enable = '0') then
        Next_state <= Halted;
      else
        Next_state <= S_18;
      end if;
    when S_18 =>
      Next_state <= S_33_1;     
    when others =>
      NULL;
  end case;
end process;

Assign_Control_Signals : process (state)
begin

end Behavioral;  