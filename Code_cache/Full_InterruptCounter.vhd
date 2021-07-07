Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.numeric_std_unsigned.all;

ENTITY full_InterruptCounter IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Stalling_Inputs: IN std_logic;
	Interrupt: IN std_logic;
	PC_FETCH_STOP1,PC_FETCH_STOP2,c1,c2,c3,dec: OUT std_logic
	
);
	
end full_InterruptCounter ;





ARCHITECTURE a_full_InterruptCounter of full_InterruptCounter IS

Component my_Counter is

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Stalling_Inputs: IN std_logic;
	Interrupt: IN std_logic;
	Interrupt_Out: OUT std_logic;
	PC_FETCH_STOP1: OUT std_logic
	
);
	
end component;

Component my_InterruptCounterB is

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Interrupt: IN std_logic;
	PC_FETCH_STOP2,c1,c2,c3,dec: OUT std_logic
	
);
	
end component;
signal Interrupt_Out_sig: std_logic;

BEGIN

counterA: my_Counter PORT MAP (Reset,Clk,Stalling_Inputs,Interrupt,Interrupt_Out_sig,PC_FETCH_STOP1);
counterB: my_InterruptCounterB PORT MAP (Reset,Clk,Interrupt_Out_sig,PC_FETCH_STOP2,c1,c2,c3,dec);
	



END a_full_InterruptCounter;