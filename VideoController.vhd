-- Copyright (C) 1991-2010 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Web Edition"
-- CREATED		"Tue Apr 30 09:10:34 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY videocontroller IS 
	PORT
	(
		reset_n :  IN  STD_LOGIC;
		CLOCK_50 :  IN  STD_LOGIC;
		ld_adc :  IN  STD_LOGIC;
		pause_n :  IN  STD_LOGIC;
		adc_data :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		SAMPLE_COUNT :  IN  STD_LOGIC_VECTOR(8 DOWNTO 0);
		SAMPLE_COUNT_INT :  IN  STD_LOGIC_VECTOR(8 DOWNTO 0);
		VGA_HS :  OUT  STD_LOGIC;
		VGA_VS :  OUT  STD_LOGIC;
		VGA_BLANK :  OUT  STD_LOGIC;
		VGA_SYNC :  OUT  STD_LOGIC;
		VGA_CLK :  OUT  STD_LOGIC;
		VGA_B :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		VGA_G :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		VGA_R :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END videocontroller;

ARCHITECTURE bdf_type OF videocontroller IS 

COMPONENT vga_controller
	PORT(clk : IN STD_LOGIC;
		 resets : IN STD_LOGIC;
		 hs : OUT STD_LOGIC;
		 vs : OUT STD_LOGIC;
		 pixel_clk : OUT STD_LOGIC;
		 blank : OUT STD_LOGIC;
		 sync : OUT STD_LOGIC;
		 DrawX : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 DrawY : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT backgroundcolor
	PORT(DrawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 DrawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Blue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Green : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Red : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT font_rom
	PORT(clk : IN STD_LOGIC;
		 addr : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT charmapper
	PORT(BlueIn : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 DataIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 DrawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 DrawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 GreenIn : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 RedIn : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 addr : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 BlueOut : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 GreenOut : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 RedOut : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT data_pixels
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 ld_adc : IN STD_LOGIC;
		 pause_n : IN STD_LOGIC;
		 ADC_DATA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 BlueIn : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 DrawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 DrawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 GreenIn : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 RedIn : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 SAMPLE_COUNT : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 SAMPLE_COUNT_INT : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 BlueOut : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 GreenOut : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 RedOut : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	DrawX :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	DrawY :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(9 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (SAMPLE_COUNT(0) & SAMPLE_COUNT(1) & SAMPLE_COUNT(2) & SAMPLE_COUNT(3) & SAMPLE_COUNT(4) & SAMPLE_COUNT(5) & SAMPLE_COUNT(6) & SAMPLE_COUNT(7) & SAMPLE_COUNT(8));


b2v_inst : vga_controller
PORT MAP(clk => CLOCK_50,
		 resets => reset_n,
		 hs => VGA_HS,
		 vs => VGA_VS,
		 pixel_clk => VGA_CLK,
		 blank => VGA_BLANK,
		 sync => VGA_SYNC,
		 DrawX => DrawX,
		 DrawY => DrawY);


b2v_inst1 : backgroundcolor
PORT MAP(DrawX => DrawX,
		 DrawY => DrawY,
		 Blue => SYNTHESIZED_WIRE_5,
		 Green => SYNTHESIZED_WIRE_6,
		 Red => SYNTHESIZED_WIRE_7);


b2v_inst2 : font_rom
PORT MAP(clk => CLOCK_50,
		 addr => SYNTHESIZED_WIRE_0,
		 data => SYNTHESIZED_WIRE_2);


b2v_inst3 : charmapper
PORT MAP(BlueIn => SYNTHESIZED_WIRE_1,
		 DataIn => SYNTHESIZED_WIRE_2,
		 DrawX => DrawX,
		 DrawY => DrawY,
		 GreenIn => SYNTHESIZED_WIRE_3,
		 RedIn => SYNTHESIZED_WIRE_4,
		 addr => SYNTHESIZED_WIRE_0,
		 BlueOut => VGA_B,
		 GreenOut => VGA_G,
		 RedOut => VGA_R);


b2v_inst9 : data_pixels
PORT MAP(clk => CLOCK_50,
		 reset_n => reset_n,
		 ld_adc => ld_adc,
		 pause_n => pause_n,
		 ADC_DATA => adc_data,
		 BlueIn => SYNTHESIZED_WIRE_5,
		 DrawX => DrawX,
		 DrawY => DrawY,
		 GreenIn => SYNTHESIZED_WIRE_6,
		 RedIn => SYNTHESIZED_WIRE_7,
		 SAMPLE_COUNT => GDFX_TEMP_SIGNAL_0,
		 SAMPLE_COUNT_INT => SAMPLE_COUNT_INT,
		 BlueOut => SYNTHESIZED_WIRE_1,
		 GreenOut => SYNTHESIZED_WIRE_3,
		 RedOut => SYNTHESIZED_WIRE_4);


END bdf_type;