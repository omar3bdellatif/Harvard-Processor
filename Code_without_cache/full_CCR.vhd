Library ieee;
Use ieee.std_logic_1164.all;

ENTITY full_CCR IS

PORT(
	Reset_enable,Clk: IN std_logic;
	Set_C,Clear_C,ALU_Op,C5,ALU_C,C_POP,ALU_N,N_POP,ALU_Z,Z_POP,Arith_OR_Shift: IN std_logic;
	Jump_types: IN std_logic_vector(1 DOWNTO 0);
	Reset_all: IN std_logic;
	C_Out,N_Out,Z_Out: OUT std_logic
);
	
end full_CCR;

ARCHITECTURE a_full_CCR OF full_CCR
IS 


Component my_CCR is

PORT(
	Reset_enable: IN std_logic;
	Enable: IN std_logic;
	Jump_types: IN std_logic_vector(1 DOWNTO 0);
	Reset_all: IN std_logic;
	C,N,Z: IN std_logic;
	C_Out,N_Out,Z_Out: OUT std_logic;
	Clk: IN std_logic
);
	
end component;
signal my_Enable,my_C,my_N,my_Z: std_logic;
signal Set_C_Or_C_Out: std_logic;
signal Set_C_ALU_C_mux1: std_logic;
signal C_And_Gate_Output: std_logic;
signal Almost_C:std_logic;
signal Almost_N:std_logic;
signal Almost_Z:std_logic;
signal my_C_Out,my_N_Out,my_Z_Out: std_logic;
signal ALU_C_Cout_MUX: std_logic;

BEGIN 


my_Enable <= (Set_C or Clear_C or C5 or ALU_Op);

--The following line might cause problems (Make sure that it is set_c or C_Out, not just set_c)
Set_C_Or_C_Out <= (Set_C or my_C_Out);

ALU_C_Cout_MUX <= ALU_C when Arith_Or_Shift = '1'
else my_C_Out;


Set_C_ALU_C_mux1<= Set_C_Or_C_Out when Set_C = '1'
else ALU_C_Cout_MUX when Set_C = '0';

--if (Set_C = '1') then 
--	Set_C_ALU_C_mux1<= Set_C_Or_C_Out;
--elsif (Set_C = '0') then Set_C_ALU_C_mux1<= ALU_C;
--end if;


C_And_Gate_Output<= (Set_C_ALU_C_mux1 and (not Clear_C));



Almost_C <= C_And_Gate_Output when (Set_C = '1' or Clear_C = '1')
else ALU_C_Cout_MUX when (Set_C = '0' and Clear_C = '0');

--if (Set_C = '1' or Clear_C = '1') then 
--	Almost_C <= C_And_Gate_Output;
--elsif (Set_C = '0' and Clear_C = '0') then
--	Almost_C <=ALU_C;
--
--end if;

my_C <= Almost_C when(C5 = '0')
else C_POP when (C5 ='1');

--if(C5 = '0') then 
--	my_C <= Almost_C;
--elsif (C5 = '1') then 
--	my_C <=C_POP;
--end if;


Almost_N <= my_N_Out when (Set_C = '1' or Clear_C = '1')
else ALU_N;

my_N <= Almost_N when (C5 = '0')
else N_POP when (C5 = '1');

--if (Set_C = '1' or Clear_C = '1') then 
--	Almost_N <= my_N_Out;
--else
--	Almost_N <=ALU_N;
--end if;
--
--if (C5 = '0') then 
--	my_N <= Almost_N;
--elsif (C5 = '1') then
--	my_N <= N_POP;
--end if;


Almost_Z <= my_Z_Out when (Set_C = '1' or Clear_C = '1')
else ALU_Z;

my_Z <= Almost_Z when (C5 = '0')
else Z_POP when (C5 = '1');

--if (Set_C = '1' or Clear_C = '1') then
--	Almost_Z <= my_Z_Out;
--else
--	Almost_Z <=ALU_Z;
--end if;
--
--if (C5 = '0') then
--	my_Z <= Almost_Z;
--elsif (C5 = '1') then
--	my_Z <= Z_POP;
--end if;


C_Out<=my_C_Out;
Z_Out<=my_Z_Out;
N_Out<=my_N_Out;



ccr: my_CCR PORT MAP (Reset_enable,my_Enable,Jump_Types,Reset_all,my_C,my_N,my_Z,my_C_Out,my_N_Out,my_Z_Out,Clk);

END a_full_CCR;