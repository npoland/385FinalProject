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
-- CREATED		"Mon Apr 29 21:37:20 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ps2keyboardblock IS 
	PORT
	(
		Clk :  IN  STD_LOGIC;
		reset_n :  IN  STD_LOGIC;
		PS2_CLK :  IN  STD_LOGIC;
		PS2_DAT :  IN  STD_LOGIC;
		KeyCode :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		keypress :  OUT  STD_LOGIC
	);
END ps2keyboardblock;

ARCHITECTURE bdf_type OF ps2keyboardblock IS 

COMPONENT sys_clock_divider
	PORT(Clk : IN STD_LOGIC;
		 DivClock : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ps2clockdivider
	PORT(ps2ClkIn : IN STD_LOGIC;
		 Clk : IN STD_LOGIC;
		 ps2ClkOut : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT controller
	PORT(ps2Clk : IN STD_LOGIC;
		 ps2Data : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 err : OUT STD_LOGIC;
		 paritybit : OUT STD_LOGIC;
		 keypress : OUT STD_LOGIC;
		 keyCode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;


BEGIN 



b2v_inst : sys_clock_divider
PORT MAP(Clk => Clk,
		 DivClock => SYNTHESIZED_WIRE_0);


b2v_inst1 : ps2clockdivider
PORT MAP(ps2ClkIn => PS2_CLK,
		 Clk => SYNTHESIZED_WIRE_0,
		 ps2ClkOut => SYNTHESIZED_WIRE_1);


b2v_inst2 : controller
PORT MAP(ps2Clk => SYNTHESIZED_WIRE_1,
		 ps2Data => PS2_DAT,
		 reset_n => reset_n,
		 keypress => keypress,
		 keyCode => KeyCode);


END bdf_type;