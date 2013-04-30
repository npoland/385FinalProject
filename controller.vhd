library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controller is
  Port (	ps2Clk,
			ps2Data,
			reset_n :in std_logic; 
			
			err, paritybit, keypress :out std_logic;
			keyCode :out std_logic_vector(7 downto 0));
end controller;


architecture behavioral of controller is

signal tempreg, lastkey: std_logic_vector (7 downto 0);
signal count: std_logic_vector (2 downto 0);
signal break : std_logic;
type cntrl_state is(waiting, shifting, parity, stop, error);
signal state, next_state: cntrl_state;

begin
-- This proccess constantly updates the last scancode that was received and outputs
--  whether or not a key is currently being pressed. 
control: process(ps2clk, reset_n) is
  begin
    -- Asnychronous reset
    if(reset_n = '0') then
      state <= waiting;
      tempreg <= x"00";
      keyCode <= x"00";
    elsif (falling_edge(ps2clk)) then
      case state is
        			
        -- While in the waiting state, the circuit needs only to recieve a falling
        -- Edge of the clock, and the '0' start bit
        when waiting =>
          err <= '0';
          if(ps2Data = '0') then
            state <= shifting;
          end if;
        
        --In the shifting state, the circuit will right shift its contents 8 times
        -- and then move to the parity state
        when shifting =>
          count <= count + 1;
          tempreg <= ps2Data & tempreg (7 downto 1);
          if (count = "111") then
            state <= parity;
          end if;
        
        --In the parity state, the circuit can now update the keycode for the 
        -- last key that was pressed                             
        when parity =>
          if(tempreg = x"F0")then -- Check for break code
            break <= '1';
          elsif(break = '1') then  --If last code was F0, then key is being released
            keypress <= '0';      
            break <= '0';
          else                     -- Else, key is being pressed
            keypress <= '1';
          end if;
          keyCode <= tempreg;      --Upadte last key pressed
          paritybit <= ps2Data; 
          state <= stop;
          
--           ----------------------------------------------------------------------------------------------
--          |                                                                                              |
--          v                                                                                              |
--  [input => tempreg] -->  < "F0"? > ---- yes --> [break = 1]---------------------> [KeyCode <= tempreg] -^
--                              |                                               ^
--                              No                                              |
--                              |                                               |
--                       < break = 1? > -- yes --> [keypress = 0, break = 0] -->|
--                              |                                               |
--                              |                                               |
--                              |                                               |
--                               > -------- No --> [keypress = 1] ------------->|

        --In stop state, check that stop bit = '1' and then move to start,
        -- Otherwise, error
        when stop =>
          if(ps2Data = '1') then
            state <= waiting;
          end if;
        
        --Wait for reset
        when error =>
          err <= '1';
    end case;
  end if;
end process;


end behavioral;
