Library ieee;
Use ieee.std_logic_1164.all;

Entity AluBlock is
	Port( Ctrl_signal:IN std_logic_vector(32 downto 0);
	Rs1_select,Rs2_select,Rd_select: IN std_logic_vector (2 downto 0);
	Read_data1, Read_data2, RD_3, Imm32,Input_port, EX_MEM_OutAlu0, MEM_WB_WrData0,EX_MEM_OutAlu1, MEM_WB_WrData1,EX_MEM_OutAlu2, MEM_WB_WrData2: IN std_logic_vector (31 downto 0);
	Out_Alu: Out std_logic_vector(31 downto 0);
	Alu_C,Alu_N,Alu_Z: Out std_logic;
	out_Read_data1,out_RD_3 :out std_logic_vector (31 downto 0)
);
end AluBlock;


Architecture myalu of AluBlock is

	Component my_nadder is
	Port (a,b: In std_logic_vector(31 downto 0);
		cin:In std_logic;
		F:out std_logic_vector(31 downto 0);
		cout: out std_logic);
	End component;	

	signal in0, in1, out_signal, Rs2_signal_1, Rs2_signal_2, RD3_signal, out_signal_temp1, out_signal_temp2, out_signal_temp3,out_signal_temp4,Not_in1,out_signal_temp5,out_signal_temp6  :std_logic_vector(31 downto 0);
	signal Alu_C_temp1,Alu_C_temp2,Alu_C_temp3,Alu_C_temp4,Alu_C_temp5,Alu_C_temp6: std_logic;
	
	Component ShiftLeftBlock is
	Port(Reg,Shift_Value:IN std_logic_vector (31 downto 0);
		Isleft: IN std_logic;
		output:Out std_logic_vector (31 downto 0);
		carryOut:OUT std_logic);
	end Component;

Begin
Not_in1<= not in1;
out_Read_data1<=in0;
out_RD_3 <=RD3_signal;
in0<=Read_data1 when Rs1_select ="001"
else EX_MEM_OutAlu0 when Rs1_select ="010" 
else MEM_WB_WrData0 when Rs1_select ="100" ;

Rs2_signal_1<=Read_data2 when Rs2_select ="001"
else EX_MEM_OutAlu1 when Rs2_select ="010" 
else MEM_WB_WrData1 when Rs2_select ="100" ;

--alusrc =ctrl_signal(13)
Rs2_signal_2<=Rs2_signal_1 when ctrl_signal(13)='0'
else Imm32 when ctrl_signal(13)='1';

RD3_signal<=RD_3 when Rd_select ="001"
else EX_MEM_OutAlu2 when Rd_select ="010" 
else MEM_WB_WrData2 when Rd_select ="100" ;

--alu_Rd_Control =ctrl_signal(13)
in1<=Rs2_signal_2 when ctrl_signal(14)='0'
else RD3_signal when ctrl_signal(14)='1';


--Rd+1
f1: my_nadder Port map(x"00000000",in1,'1',out_signal_temp1,alu_C_temp1);
--Rd-1
f2: my_nadder Port map(x"FFFFFFFF",in1,'0',out_signal_temp2,alu_C_temp2);  --check
--Rs1+Rs2 (or) Rs1+Imm		
f3: my_nadder Port map(in0,in1,'0',out_signal_temp3,alu_C_temp3);
--Rs1-Rs2		
f4: my_nadder Port map(in0,Not_in1,'1',out_signal_temp4,alu_C_temp4);

ShiftLeft: ShiftLeftBlock Port map(in0,in1,'1',out_signal_temp5,alu_C_temp5);
ShiftRight: ShiftLeftBlock Port map(in0,in1,'0',out_signal_temp6,alu_C_temp6);



--ALUOP=ctrl_signal(28 downto 25)
out_signal<=x"00000000" when ctrl_signal(28 downto 25)="0000"
else out_signal_temp1 when ctrl_signal(28 downto 25)="0001"
else not in1 when ctrl_signal(28 downto 25)="0010"
else out_signal_temp2 when ctrl_signal(28 downto 25)="0011"
else out_signal_temp3 when ctrl_signal(28 downto 25)="0100"
else out_signal_temp4 when ctrl_signal(28 downto 25)="0101"
else in0 and in1 when ctrl_signal(28 downto 25)="0110"
else in0 or in1 when ctrl_signal(28 downto 25)="0111"
else out_signal_temp5 when ctrl_signal(28 downto 25)="1000"
else out_signal_temp6 when ctrl_signal(28 downto 25)="1001";

alu_N<= '1' when out_signal(31)='1'
else '0';

alu_Z<= '1' when out_signal=x"00000000"
else '0';

alu_C<=alu_c_temp1 when ctrl_signal(28 downto 25)="0001"
else alu_C_temp2 when ctrl_signal(28 downto 25)="0011"
else alu_C_temp3 when ctrl_signal(28 downto 25)="0100"
else alu_C_temp4 when ctrl_signal(28 downto 25)="0101"
else alu_C_temp5 when ctrl_signal(28 downto 25)="1000"
else alu_C_temp6 when ctrl_signal(28 downto 25)="1001"
else '0';


--in_ctrl=ctrl_signal(0)
out_alu<=out_signal when ctrl_signal(0)='0'
else input_port when ctrl_signal(0)='1';



end myalu;




