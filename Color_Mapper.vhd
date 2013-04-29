---------------------------------------------------------------------------
--    Color_Mapper.vhd                                                   --
--    Stephen Kempf                                                      --
--    3-1-06                                                             --
--												 --
--    Modified by David Kesler - 7-16-08						 --
--                                                                       --
--    Spring 2013 Distribution                                             --
--                                                                       --
--    For use with ECE 385 Lab 9                                         --
--    University of Illinois ECE Department                              --
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Color_Mapper is
   Port ( sampleX     : in std_logic_vector(9 downto 0);
          amplitudeY  : in std_logic_vector(9 downto 0);
          DrawX       : in std_logic_vector(9 downto 0);
          DrawY       : in std_logic_vector(9 downto 0);
          --Ball_size : in std_logic_vector(9 downto 0);
          Red         : out std_logic_vector(9 downto 0);
          Green       : out std_logic_vector(9 downto 0);
          Blue        : out std_logic_vector(9 downto 0));
end Color_Mapper;

architecture Behavioral of Color_Mapper is

signal sig_pixel : std_logic;

SIGNAL y : STD_LOGIC_VECTOR(9 DOWNTO 0);

SIGNAL x: STD_LOGIC_VECTOR(9 DOWNTO 0);
constant Ball_X_Center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);  --Center position on the Y axis


begin
  y <= amplitudeY;
  x <= sampleX;
  
  --Ball_Size <= CONV_STD_LOGIC_VECTOR(4, 10); -- assigns the value 4 as a 10-digit binary number, ie "0000000100"
  
--  sig_pixel_proc : process (BallX, BallY, DrawX, DrawY, Ball_size)
--  begin
--    if ((DrawX =  sample<= (Ball_Size*Ball_Size)) then
--      sig_pixel <= '1';
--    else
--      sig_pixel <= '0';
--    end if;
--  end process sig_pixel_proc;

  RGB_Display : process (sig_pixel, sampleX, amplitudeY)
  begin
    if (sig_pixel = '1') then -- green pixel
      Red <= "0000000000";
      Green <= "1010101010";
      Blue <= "0101010101";
    else          -- gradient background
      Red   <= "0000000000";
      Green <= "0000000000";
      Blue  <= "0000000000";
    end if;
  end process RGB_Display;
end Behavioral;
