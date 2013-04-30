library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_pixels is
	port(	
      clk     :  	in std_logic;
			reset_n :  	in std_logic;
      ld_adc  :   IN STD_LOGIC;
      
      SAMPLE_COUNT: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      ADC_DATA:   IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      
      DrawX   :  	IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
			DrawY   :  	IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
			
			
      RedIn   : in std_logic_vector(9 downto 0);
      GreenIn : in std_logic_vector(9 downto 0);
      BlueIn  : in std_logic_vector(9 downto 0);

      RedOut   : out std_logic_vector(9 downto 0);
      GreenOut : out std_logic_vector(9 downto 0);
      BlueOut  : out std_logic_vector(9 downto 0);
            
      SAMPLE_COUNT_INT: IN  INTEGER RANGE 0 to 511;
      pause_n : IN STD_LOGIC
			);
end data_pixels;

architecture behavior of data_pixels is 

	-- Build a 2-D array type for the RAM to store ADC data
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(511 downto 0) of word_t;
	
	-- Declare the RAM
	shared variable pixel_array : memory_t;

  SIGNAL samp_clk0, samp_clk1 : STD_LOGIC;
  SIGNAL adc_data_int         : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL pixel_on:  STD_LOGIC;
  SIGNAL VGA_X, VGA_Y : INTEGER;
  
begin
  adc_data_int <= "10000000" + NOT(ADC_DATA(15 DOWNTO 8)) + '1' WHEN ADC_DATA(15) = '1' ELSE
                  "10000000" - ADC_DATA(15 DOWNTO 8);
  
  VGA_X <= CONV_INTEGER(DrawX);
  VGA_Y <= CONV_INTEGER(DrawY);
  
  sample_ld_adc: PROCESS(clk)
  BEGIN
    IF(clk'EVENT AND clk = '1')THEN
      IF(reset_n = '0')THEN
        samp_clk0 <= '0';
        samp_clk1 <= '0';
      ELSIF(clk'EVENT AND clk = '1')THEN
        samp_clk0 <= samp_clk1;
        samp_clk1 <= ld_adc;
      END IF;
    END IF;
	END PROCESS;
	
	store_new : process(samp_clk0, samp_clk1, reset_n)
	BEGIN
    IF(reset_n = '0')THEN
      
    ELSIF(pause_n = '0')THEN
      --pause
    ELSIF(samp_clk0 = '0' AND samp_clk1 = '1')THEN	--rising edge of LD_ADC
      pixel_array(SAMPLE_COUNT_INT) := adc_data_int;
    END IF;
	end process;
	
	display_pixel : PROCESS(VGA_X, VGA_Y)
  BEGIN
    IF(CONV_INTEGER(pixel_array(VGA_X)) = (VGA_Y))THEN
      pixel_on <= '1';
    ELSE
      pixel_on <= '0';
    END IF;
  END PROCESS;

	
	RGB_Display : process (pixel_on, DrawX, DrawY)
  begin
    if (pixel_on = '1') then -- draw data
      RedOut   <= "1111111111";
      GreenOut <= "1111111111";
      BlueOut  <= "1111111111";
    else          -- black background
      RedOut   <= RedIn;
      GreenOut <= GreenIn;
      BlueOut  <= BlueIn;
    end if;
  end process RGB_Display;

end behavior;