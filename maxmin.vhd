LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY maxmin IS
  PORT(
    clk     : IN STD_LOGIC;
    reset_n : IN STD_LOGIC;
    adc_clk : IN STD_LOGIC;
    DIN     : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    MAX     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    MIN     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END maxmin;

ARCHITECTURE behavioral OF MAXMIN IS

SIGNAL max_int, min_int: STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL adc_clk_prev     : STD_LOGIC;

BEGIN
  get_max_min: PROCESS(clk, reset_n)
  BEGIN
    adc_clk_prev <= adc_clk;
    IF(reset_n = '0')THEN
      max_int <= x"0000";
      min_int <= x"1111";
    ELSIF(adc_clk_prev = '0' AND adc_clk = '1')THEN
      IF(DIN > max_int)THEN
        max_int <= DIN;
      ELSIF(DIN < min_int)THEN
        min_int <= DIN;
      END IF;
--      IF(count  = x")THEN
--        MAX <= max_int;
--        MIN <= min_int;
--        
--        max_int <= "0000";
--        min_int <= "1111";
--      END IF;
    END IF;
  END PROCESS;
  
END behavioral;