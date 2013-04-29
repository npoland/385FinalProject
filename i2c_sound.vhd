LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

library work;
use work.WM8731_Lib.all;

ENTITY i2c_sound IS
  PORT(
    clk         : IN    STD_LOGIC;             --system clk
    reset_n     : IN    STD_LOGIC;             --reset = 0
    INIT_I2C    : IN    STD_LOGIC;             --apply to lock in data

    I2C_IS_INIT : OUT   STD_LOGIC;
    error       : OUT   STD_LOGIC;             --error occured
    
    I2C_SDAT    : INOUT STD_LOGIC;             --I2C data bus
    I2C_SCLK    : INOUT STD_LOGIC);            --I2C clock bus
    
END i2c_sound;

ARCHITECTURE behavioral OF i2c_sound IS
  TYPE i2c_state IS(ready, start, write_addr, ack1, data_w_1, ack2, data_w_2, ack3, stop); --needed states
  SIGNAL  state     :  i2c_state;

  SIGNAL  data_clk  :  STD_LOGIC;
  SIGNAL  scl_clk   :  STD_LOGIC;
  SIGNAL  SDA_INT   :  STD_LOGIC;
  
  SIGNAL  i2c_data:  STD_LOGIC_VECTOR(15 DOWNTO 0);

  SIGNAL clk_count  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "0" & x"00";
  SIGNAL addr_count : INTEGER RANGE 0 to 7 := 7;
  SIGNAL data_count : INTEGER RANGE 0 to 15 := 15;
  SIGNAL write_count: INTEGER RANGE 0 to 9 := 9;
  SIGNAL err    : STD_LOGIC;
  SIGNAL ack_sample :STD_LOGIC;
  
  
BEGIN
    
    
--GENERATE BLCK, ADC CLK, AND START FUCKING SAMPLING==
    
--  BCLK_sample: PROCESS(clk, bclk, reset_n)
--  BEGIN
--    IF(reset_n = '0')THEN
--      b0 = '0';
--    ELSIF(clk'EVENT and clk = '1')THEN
--      b0 <= 
--      
--      
--  
--  
--  ADC_data: PROCESS(clk, reset_n)  --for DSP MODE
--  BEGIN
--    IF(

  sample_I2C_SDAT: PROCESS(state, data_clk, reset_n)
  BEGIN
    IF(reset_n = '0') THEN               
      ack_sample <= '0';
    ELSIF(data_clk'EVENT AND data_clk = '0') THEN  
      CASE state IS
        WHEN ack1|ack2|ack3 =>
          ack_sample <= '0';              --REMOVE AFTER TESTING!!!!!!--
          --ack_sample <= I2C_SDAT;
        WHEN OTHERS =>
          ack_sample <= '0';
      END CASE;
    END IF;
  END PROCESS;
  
  generate_clocks: PROCESS(clk, reset_n)
  BEGIN
    IF(reset_n = '0') THEN               
      clk_count <= "0" &x"00";
    ELSIF(clk'EVENT AND clk = '1') THEN
      clk_count <= clk_count + '1';
      CASE clk_count(8 downto 7) IS
        WHEN "00" =>
          scl_clk <= '0';
          data_clk <= '0';
        WHEN "01" =>   
          scl_clk <= '0';
          data_clk <= '1';
        WHEN "10" => 
          scl_clk <= '1';
          data_clk <= '1';
        WHEN "11" =>
          scl_clk <= '1';
          data_clk <= '0';
        END CASE;
    END IF;
  END PROCESS;
  
  i2c_initialize: PROCESS(data_clk, reset_n)
  BEGIN
    IF(reset_n = '0') THEN
      state <= ready;
      SDA_INT <= 'Z';
      err <= '0';

    ELSIF(data_clk'EVENT AND data_clk = '1')THEN --data clock just went high
      CASE state is
        WHEN ready =>
          data_count <= 15;
          addr_count <= 7;
          write_count <= 0;
        
          IF(INIT_I2C = '1')THEN
            err <= '0'; 
            state <= start;
          ELSE
            state <= ready;
          END IF;
          
        WHEN start =>
          state <= write_addr;
          SDA_INT <=  WM8731(addr_count);    --begin writing i2c addr
--          addr_count <= addr_count-1;       --decrement device addr index
        
        WHEN write_addr =>                  --addressing slave
          SDA_INT <= WM8731(addr_count-1);    --write data bit to I2C bus 
          addr_count <= addr_count-1;       --decrement device addr index
          IF(addr_count = 0)THEN             --addr write complete
            state <= ack1;                     --wait for slave acknowledge
          ELSE                                --addr write not complete
            state <= write_addr;            --continue writing to i2c_sdat
          END IF;
          
        WHEN ack1 =>                          --read acknowlege from slave
          IF(ack_sample = '0')THEN               --0 = No Ack Error
            SDA_INT <= i2c_data(data_count);  --Begin writing reg & control data
            state <= data_w_1;
          ELSE                                --1 = Ack Error
            err <= '1';
            state <= ready;                   --Restart i2c
            I2C_IS_INIT <= '0';
          END IF;

        WHEN data_w_1 =>
          SDA_INT <= i2c_data(data_count-1);    --write data bit to I2C bus 
          data_count <= data_count-1;         --decrement data index
          IF(data_count = 8)THEN              --data1 write complete
            state <= ack2;                     --wait for slave acknowledge
          ELSE                                --data write not complete
            state <= data_w_1;                --continue writing to i2c_sdat
          END IF;
          
        WHEN ack2 =>
          IF(ack_sample = '0')THEN               --0 = No Ack Error
            SDA_INT <= i2c_data(data_count);  --Begin writing reg & control data
            state <= data_w_2;
          ELSE                                --1 = Ack Error
            err <= '1';
            state <= ready;                   --Restart i2c
            I2C_IS_INIT <= '0';
          END IF;
          
        WHEN data_w_2 =>
          SDA_INT <= i2c_data(data_count-1);    --write data bit to I2C bus 
          data_count <= data_count-1;         --decrement data index
          IF(data_count = 0)THEN              --data1 write complete
            state <= ack3;                     --wait for slave acknowledge
          ELSE                                --data write not complete
            state <= data_w_2;                --continue writing to i2c_sdat
          END IF;
          
        WHEN ack3 =>
          IF(ack_sample = '0')THEN               --0 = No Ack Error
            write_count <= write_count+1;
            state <= stop;
          ELSE                                --1 = Ack Error
            err <= '1';
            state <= ready;                   --Restart i2c
            I2C_IS_INIT <= '0';
          END IF;
            
        WHEN stop =>
          IF(write_count = 3)THEN
            state <= ready;
            I2C_IS_INIT <= '1';
          ELSE
            state <= start;
          END IF;
          
      END CASE;
    END IF;
  END PROCESS;
  
  WITH write_count select
    i2c_data <= x"00FF" WHEN 0,
                x"0FF0" WHEN 1,
                x"FFFF" WHEN OTHERS;
  
  error <= err;
  
  --SDA is high impedance when not transmitting data: ack1,ack2,ack3,and ready 
  WITH state SELECT
    I2C_SDAT <= data_clk WHEN start,
                NOT(data_clk) WHEN stop,
                'Z' WHEN ready|ack1|ack2|ack3,
                SDA_INT WHEN others;
                
  --SCL is enabled 
  WITH state SELECT
    I2C_SCLK <= 'Z' WHEN ready, 
                (scl_clk OR data_clk) WHEN start,
                (scl_clk OR NOT(data_clk)) WHEN stop,
                scl_clk WHEN OTHERS;
    
END behavioral;