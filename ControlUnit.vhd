-------------------------------------------
-------------------------------------------
--| ECE 385 Final Project: Oscilliscope |--
--|            Nathan Poland            |--
--|                  &                  |--
--|              Phil Lange             |--
-------------------------------------------
--|            ControlUnit.vhd          |--
--|               Version: 0            |--
--|            Created 4/4/2013         |--
-------------------------------------------
--|             Description:            |--
--| This unit will be in control of the |--
--|   operation of the entire circuit.  |--
-------------------------------------------
--|            Change Log               |--
--|    4/4/2013 - Created the file      |--
--|-------------------------------------|--
-------------------------------------------
--
--library work;
use work.WM8731_Lib.all;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ControlUnit IS
  PORT(
    clk         : IN    STD_LOGIC;                      --system clock
    reset_n     : IN    STD_LOGIC;                      --active low reset

		AUD_BCLK    : IN std_logic; -- Digital Audio bit clock
		AUD_ADCDAT  : IN std_logic;
    AUD_DACLRCK, AUD_ADCLRCK :IN std_logic; -- DAC data left/right select

    PS2_CLK     : IN std_logic;
    PS2_DAT     : IN std_logic;
    
    ADCDATA     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    AUD_MCLK    : OUT std_logic; -- Codec master clock OUTPUT
		AUD_DACDAT  : OUT std_logic; -- DAC data line
		LD_ADC      : OUT STD_LOGIC;
		I2C_SDAT    : OUT std_logic; -- serial interface data line
		I2C_SCLK    : OUT std_logic;  -- serial interface clock
		SAMPLE_COUNT: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		
		KEYCODE     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		keypress    : OUT STD_LOGIC;
		
		SAMPLE_COUNT_INT: OUT INTEGER RANGE 0 to 511
    );
END ControlUnit;

ARCHITECTURE mixed OF ControlUnit IS

COMPONENT ps2keyboardblock IS 
	PORT
	(
		Clk :  IN  STD_LOGIC;
		reset_n :  IN  STD_LOGIC;
		PS2_CLK :  IN  STD_LOGIC;
		PS2_DAT :  IN  STD_LOGIC;
		KeyCode :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		keypress :  OUT  STD_LOGIC
	);
END COMPONENT;

component audio_interface IS
	PORT
	(	
		LDATA, RDATA:       IN std_logic_vector(15 downto 0); -- parallel external data inputs
		clk, Reset, INIT :  IN std_logic; 
		INIT_FINISH :			  OUT std_logic;
		adc_full    :			  OUT std_logic;
		data_over   :       OUT std_logic; -- sample sync pulse
		AUD_MCLK    :       OUT std_logic; -- Codec master clock OUTPUT
		AUD_BCLK    :       IN std_logic; -- Digital Audio bit clock
		AUD_ADCDAT  :			  IN std_logic;
		AUD_DACDAT  :       OUT std_logic;               -- DAC data line
		AUD_DACLRCK, AUD_ADCLRCK :          IN std_logic;   -- DAC data left/right select
		I2C_SDAT    :       OUT std_logic;               -- serial interface data line
		I2C_SCLK    :       OUT std_logic;  -- serial interface clock
		ADCDATA     :       OUT std_logic_vector(31 downto 0)
	);
END component;

  TYPE machine IS(s_init, s_i2c_write, s_i2c_wait, s_run, s_error); --needed states
  SIGNAL state      :  machine;                                             --state machine 
  SIGNAL INIT, INIT_FINISH, adc_full_prev, adc_full, data_over : STD_LOGIC;            --i2c port mapping signals
  SIGNAL adc_int_data : STD_LOGIC_VECTOR(31 DOWNTO 0);

  SIGNAL SAMP_COUNTER  : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL ADC_COUNT: STD_LOGIC_VECTOR(7 DOWNTO 0);
  
BEGIN

  ADC : audio_interface port map(
		clk         => clk,
		Reset       => not(reset_n),
		INIT        => INIT,
		INIT_FINISH => INIT_FINISH,
		adc_full    => adc_full,
		data_over   => data_over,
		ADCDATA     => ADCDATA,
		
		AUD_MCLK    => AUD_MCLK, --:              OUT std_logic; -- Codec master clock OUTPUT
		AUD_BCLK    => AUD_BCLK, -- :             IN std_logic; -- Digital Audio bit clock
		AUD_ADCDAT  => AUD_ADCDAT, -- :			      IN std_logic;
		AUD_DACDAT  => AUD_DACDAT, -- :           OUT std_logic; -- DAC data line
		AUD_DACLRCK => AUD_DACLRCK, --
		AUD_ADCLRCK => AUD_ADCLRCK, -- :          IN std_logic; -- DAC data left/right select

    LDATA       => x"0000",
    RDATA       => x"0000",

		I2C_SDAT    => I2C_SDAT, -- :             OUT std_logic; -- serial interface data line
		I2C_SCLK    => I2C_SCLK -- :              OUT std_logic;  -- serial interface clock
	);

  PS2 : ps2keyboardblock port map(
    clk         => clk,
    reset_n     => reset_n,
    PS2_CLK     => PS2_CLK,
    PS2_DAT     => PS2_DAT,
    KeyCode     => KeyCode,
    keypress    => keypress
  );
 
  get_adc_data: PROCESS(clk, reset_n)
  BEGIN 
    IF(reset_n = '0') THEN
      SAMP_COUNTER <= "000000000";
    ELSIF(clk'EVENT AND clk = '1')THEN
      adc_full_prev <= adc_full;
      IF(adc_full_prev = '0' AND adc_full ='1')THEN
        SAMP_COUNTER <= SAMP_COUNTER + '1';
--        ld_adc <= '1';
      ELSE
--        ld_adc <= '0';
      END IF;
    END IF;
  END PROCESS;
  
  ld_adc <= adc_full;
  SAMPLE_COUNT <= SAMP_COUNTER;
  SAMPLE_COUNT_INT <= CONV_INTEGER(SAMP_COUNTER);
  
  next_state: process(clk, reset_n) 
  BEGIN
    IF(reset_n = '0')THEN
      state <= s_init;                      --begin in the reset state
      INIT <= '1';                       --disable i2c master controller

    ELSIF(clk'EVENT AND CLK = '1') THEN      
      CASE state IS  
        WHEN s_init =>
          INIT <= '1';
          state <= s_i2c_wait;
          
        WHEN s_i2c_wait =>
          IF(INIT_FINISH = '1')THEN
            INIT <= '0';
            state <= s_run;
          ELSE
            state <= s_i2c_wait;
          END IF;   
          
        WHEN s_run =>
            --DO scopey things
            
        WHEN OTHERS=> NULL;
        
      END CASE;
    END IF;
  END PROCESS;
END mixed;




