-- TO USE: Include this file in your project, and paste the following 2 lines
--   (uncommented) into whatever file needs to reference the functions &
--   constants included in this file, just after the usual library references:

--library work;
--use work.WM8731_Lib.all;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

package WM8731_Lib is

-- Declare constants

-- I2C Register addresses
  constant WM8731         : std_logic_vector(7 downto 0) := "00110100"; --device addr
  
  constant L_in           : std_logic_vector(6 downto 0) := "0000000";
  constant L_in_D         : std_logic_vector(8 downto 0) := "000010111"; --0db Vol, mute off
    
  constant R_in           : std_logic_vector(6 downto 0) := "0000001";
  constant R_in_D         : std_logic_vector(8 downto 0) := "000010111"; --0db Vol, mute off
    
  constant L_out          : std_logic_vector(6 downto 0) := "0000010";
  constant L_out_D        : std_logic_vector(8 downto 0) := "001111001"; --default

  constant R_out          : std_logic_vector(6 downto 0) := "0000011";
  constant R_out_D        : std_logic_vector(8 downto 0) := "001111001"; --default

  constant Analog_Path    : std_logic_vector(6 downto 0) := "0000100";
  constant Analog_Path_D  : std_logic_vector(8 downto 0) := "000000010"; --default

  constant Digital_Path   : std_logic_vector(6 downto 0) := "0000101";
  constant Digital_Path_D : std_logic_vector(8 downto 0) := "000000001"; --diable highpass filter

  constant Power_Down     : std_logic_vector(6 downto 0) := "0000110"; 
  constant Power_Down_D   : std_logic_vector(8 downto 0) := "000000000"; --turn the Power on

  constant Dig_aud_int    : std_logic_vector(6 downto 0) := "0000111";
  constant Dig_aud_int_D  : std_logic_vector(8 downto 0) := "000000011"; --format, DSP, Slave mode, dont invert BCLK

  constant Samp_Cntrl     : std_logic_vector(6 downto 0) := "0001000";
  constant Samp_Cntrl_D   : std_logic_vector(8 downto 0) := "000011101"; --no clockdiv, 96kHz, USB mode

  constant Actv_Cntrl     : std_logic_vector(6 downto 0) := "0001001";
  constant DEActv_Cntrl_D : std_logic_vector(8 downto 0) := "000000000"; --deactivate
  constant Actv_Cntrl_D   : std_logic_vector(8 downto 0) := "000000001"; --reactivate

  constant Reset_WM       : std_logic_vector(6 downto 0) := "0001111";
  constant Reset_WM_D     : std_logic_vector(8 downto 0) := "000000000"; --reset

-- I2C Register Control Data



-- Declare functions and procedure
--  function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
--  procedure <procedure_name>	(<type_declaration> <constant_name>	: in <type_declaration>);  

  -- The instruction functions

    function i2c_word  ( control_reg, control_data:  std_logic_vector ) return std_logic_vector; -- Alias for ANDi(DR, DR, 0)

end WM8731_Lib;


package body WM8731_Lib is

function i2c_word( control_reg : std_logic_vector; control_data: std_logic_vector) return std_logic_vector is
  variable I2C_tx : std_logic_vector(15 downto 0);
  begin
     I2C_tx(15 downto 9)  := control_reg;
     I2C_tx(8 downto 0)   := control_Data;
     return I2C_tx;
  end i2c_word;

end WM8731_Lib;     
