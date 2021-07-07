
Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.numeric_std_unsigned.all;

ENTITY full_RTICounter IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	RTI_Control_Signal_Decode,Call_Signal_EX,JMP_Signal_EX: IN std_logic;
	PC_FETCH_STOP3: OUT std_logic;
	PC_FETCH_STOP4,INC_1,c4,INC_2,c5: OUT std_logic
	
);
	
end full_RTICounter ;





ARCHITECTURE a_full_RTICounter of full_RTICounter IS

Component my_RTICounterA is

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	RTI_Control_Signal_Decode,Call_Signal_EX,JMP_Signal_EX: IN std_logic;
	PC_FETCH_STOP3,RTI_Out: OUT std_logic
	
);
	
end component;

Component my_RTICounterB is

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	RTI_Signal: IN std_logic;
	PC_FETCH_STOP4,INC_1,c4,INC_2,c5: OUT std_logic
	
);
	
end component;
signal RTI_Out_signal: std_logic;

BEGIN

counterA: my_RTICounterA PORT MAP (Reset,Clk,RTI_Control_Signal_Decode,Call_Signal_EX,JMP_Signal_EX,PC_FETCH_STOP3,RTI_Out_signal);
counterB: my_RTICounterB PORT MAP (Reset,Clk,RTI_Out_signal,PC_FETCH_STOP4,INC_1,c4,INC_2,c5);
	



END a_full_RTICounter;