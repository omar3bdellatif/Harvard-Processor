LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity all_microprocessor is 
port(
Clk,Rst,interupt: IN std_logic;
inport :in std_logic_vector (32-1 downto 0);
output_bus: out std_logic_vector (31 downto 0)--l howa l output port
);
end entity all_microprocessor;
architecture processor of all_microprocessor is
---counters and any component is outside pipeline
------
------
component full_InterruptCounter IS --Interupt Counter
PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Stalling_Inputs: IN std_logic;
	Interrupt: IN std_logic;
	PC_FETCH_STOP1,PC_FETCH_STOP2,c1,c2,c3,dec: OUT std_logic);	
end component full_InterruptCounter ;
--------------------------------///---------------------------------////----------
component full_RTICounter IS --Full_RTI_counter
PORT(   Reset: IN std_logic;
	Clk: IN std_logic;
	RTI_Control_Signal_Decode,Call_Signal_EX,JMP_Signal_EX: IN std_logic;
	PC_FETCH_STOP3: OUT std_logic;
	PC_FETCH_STOP4,INC_1,c4,INC_2,c5: OUT std_logic	);	
end component full_RTICounter ;
---------------//////////////////////////----------
------------
-----------
component add_Buffer is port 
( pc:in std_logic_vector (32-1 downto 0);
opcode:in std_logic_vector (4 downto 0);
pc_plus_one:out std_logic_vector (32-1 downto 0));
end component add_Buffer;
----------------------////-/---
-------------------///---///----
--------------------------------
component ram IS
Generic(n: integer :=32 ; m: integer:=16);
 PORT (
	rst,Clk,c2:in std_logic;	 
	address : IN std_logic_vector(n-1 DOWNTO 0);
	 dataout : OUT std_logic_vector(n-1 DOWNTO 0) );
END component ram;
-------------//////////////---------------
-----------------
----------------
component program_counter IS
PORT( Clk,Rst,disable,priority,delay : IN std_logic;
		   d : IN std_logic_vector(32-1 DOWNTO 0);
		   q : OUT std_logic_vector(32-1 DOWNTO 0));
		
END component program_counter;
----------------/////////////////////---------------
----------------------------
--------------------------
---------------------------
---------------------------
component sub_stack_pointer is port 
( sel :in std_logic ;
input : IN std_logic_vector(32-1 DOWNTO 0);
 output : OUT std_logic_vector(32-1 DOWNTO 0)
);
end component sub_stack_pointer;
-----------------------------------------------///////////////////-
------------------------
-----------------------
component add_stack_pointer is port 
( sel :in std_logic ;
input : IN std_logic_vector(32-1 DOWNTO 0);
 output : OUT std_logic_vector(32-1 DOWNTO 0)
);
end component add_stack_pointer;
----------------------//////////////////////---------------
-----------------------------------------------///////////////////-
------------------------------------------------------------------
component stack_pointer_register is port 
( Clk,Rst : IN std_logic;
		   d : IN std_logic_vector(32-1 DOWNTO 0);
		   q : OUT std_logic_vector(32-1 DOWNTO 0));
END component stack_pointer_register;
----------------------------------------------------------------------------------
component full_CCR IS
PORT(
	Reset_enable,Clk: IN std_logic;
	Set_C,Clear_C,ALU_Op,C5,ALU_C,C_POP,ALU_N,N_POP,ALU_Z,Z_POP,Arith_OR_Shift: IN std_logic;
	Jump_types: IN std_logic_vector(1 DOWNTO 0);
	Reset_all: IN std_logic;
	C_Out,N_Out,Z_Out: OUT std_logic
);
end component full_CCR;
---------------------
---------------------
---------------------
---------------------
---------////////Start of Pipeline (Fetch and decode)-------------------///////////////------------------------------------
----------------------------------------------------------------------------//////////////////----------------///////////
component register_file IS --Register File
port(Write_data1,Write_data2:in std_logic_vector (32-1 downto 0);
Rsource_1,Rsource_2,Rd_address:in std_logic_vector(2 downto 0);
Write_address1,Write_address2:in std_logic_vector(2 downto 0);
REG_Write1,Reg_write2:in std_logic ;
Clk,Rst : IN std_logic;
Read_data1,Read_data2,Rd3: out std_logic_vector(32-1 downto 0));
end component register_file;
------------///////////-------------/////////////////
component sign_extent is --Sign EXTENT
GENERIC (n : integer := 16);
PORT   (a:in std_logic_vector (n-1 DOWNTO 0); 
             s : OUT std_logic_vector(32-1 DOWNTO 0));
END component sign_extent;
-------------------///////////////////////////-----------
component  Fecth_buffer  IS
PORT( Clk,Rst,disable,zeros : IN std_logic;
		   d : IN std_logic_vector(96-1 DOWNTO 0);
		   q : OUT std_logic_vector(96-1 DOWNTO 0));
END component Fecth_buffer ;
----------------////////////////////--------------
component control_unit is
port (
opcode: in std_logic_vector (5-1 downto 0);
control_signals :out std_logic_vector ( 33-1 downto 0)
);
end component control_unit;
----------------/////////////////////////////////////////--------------/////////////
component mux32_decode is 
GENERIC (m : integer := 32);
port
(
input0,input1: IN STD_LOGIC_VECTOR(m-1 downto 0);
SEL:IN std_logic;
output:out std_logic_vector (m-1 downto 0));
End component mux32_decode;
-----------------------------------------------///////////////////-
component Decode_Excute_Buffer is port
( Clk,RST : IN std_logic;
		   d : IN std_logic_vector(263-1 DOWNTO 0);
		   q : OUT std_logic_vector(263-1 DOWNTO 0);
		RS2_address:in std_logic_vector(2 downto 0);
		out_RS2_address:out std_logic_vector(2 downto 0)
);
end component Decode_Excute_Buffer;
-----------------------------------------------///////////////////-
------------------------
------------------------
-------------------------
-------------------------------///////////Fetch and decode Stage -----------///////////Hussein Hussein---------------------
-----------------------------------------------------------------//////////Excute_HOOSAM _OMAR--------------////////////
component AluBlock is
	Port( Ctrl_signal:IN std_logic_vector(32 downto 0);
	Rs1_select,Rs2_select,Rd_select: IN std_logic_vector (2 downto 0);
	Read_data1, Read_data2, RD_3, Imm32,Input_port, EX_MEM_OutAlu0, MEM_WB_WrData0,EX_MEM_OutAlu1, MEM_WB_WrData1,EX_MEM_OutAlu2, MEM_WB_WrData2: IN std_logic_vector (31 downto 0);
	Out_Alu: Out std_logic_vector(31 downto 0);
	Alu_C,Alu_N,Alu_Z: Out std_logic;
	out_Read_data1,out_RD_3 :out std_logic_vector (31 downto 0)
);
end component AluBlock;
----------------------///////////////////////////////////----------------//////////
component  jump_mux is port
(jump_signal,Z_Flag,N_Flag,C_Flag: in std_logic;
Jump_type:in std_logic_vector (2-1 downto 0);
jump_Destination:out std_logic
);
end component jump_mux;
----------------/////////////////-----------------------------------////////////
component jump_register IS
PORT( Clk,Rst : IN std_logic;
		   d : IN std_logic;
		   q : OUT std_logic);		
END component jump_register;
----------------/////////////////-----------------------------------////////////
-----------------//End Excute 
--------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-------------------Memory_Stage------------------------------///////////////
COMPONENT Excute_MEMORY_Buffer is port
( Clk,RST,Zeros,disable  : IN std_logic;
		   d : IN std_logic_vector (199-1  downto 0);
		   q : OUT std_logic_vector (199-1  downto 0));
end COMPONENT Excute_MEMORY_Buffer;
--------------------------------------------------------//---------
---
component and2 IS
PORT( a,b : IN std_logic;
 z : OUT std_logic);
END component and2;
------------------------
-----------------------
----------------------
component general_maux IS 
Generic ( n : Integer:=32);
PORT ( in0,in1 : IN std_logic_vector (n-1 DOWNTO 0);
sel : IN  std_logic;
output : OUT std_logic_vector (n-1 DOWNTO 0));
END component;
-----------------------------------
-----------------------------------
-----------------------------------
component n_tri_state IS 
Generic(n: integer :=32);
port (Input :IN std_logic_vector (n-1 downto 0);
Output :Out std_logic_vector (n-1 downto 0);
En :IN std_Logic);  --hyb2a l out_ctrl
End component n_tri_state;
------------------------------
------------------------------
------------------------------

component gate is --fe 7alet ana msh m7tag 4 input h7ot input menhom b zero mslan 
port(
a : in std_logic;
b : in std_logic;
c : in std_logic;
d : in std_logic;
output: out std_logic);
end component gate;
--------------------------------------------------------------------------------------
component storage IS
PORT 
(
	clk : IN std_logic;
        rst: IN std_logic;  --lsa hnshof n3mlha wla eh
	write_en : IN std_logic;
        read_en : IN std_logic;
	Stackop:in std_logic;
	address : IN std_logic_vector(31 DOWNTO 0);
	datain : IN std_logic_vector(31 DOWNTO 0);
	LDM:in std_logic;
	dataout : OUT std_logic_vector(31 DOWNTO 0)
          
);
END  component storage;
------------------------------------
------------------------------------
------------------------------------
component writeback_flip IS
PORT(Clk,Rst,zero: IN std_logic;
		   ctrl_sig_1,ctrl_sig_2,ctrl_sig_3,ctrl_sig_4,ctrl_sig_5,ctrl_sig_6 : IN std_logic;
                   read_data1,read_data3,output_alu,data_mem_out: IN std_logic_vector(31 downto 0); -- 32 bit
                   Rs_address,Rd_address: IN std_logic_vector(2 downto 0); -- 3bit address
		   ctrl_sig_1_out,ctrl_sig_2_out,ctrl_sig_3_out,ctrl_sig_4_out,ctrl_sig_5_out,ctrl_sig_6_out : out std_logic;
                --   lowerdataout_out,upperdataout_out: Out std_logic_vector(15 downto 0);
                   read_data1_out,read_data3_out,output_alu_out,data_mem_out_output: out std_logic_vector(31 downto 0); -- 32 bit
                   Rs_address_out,Rd_address_out: out std_logic_vector(2 downto 0);-- 3bit address);
		DST_control_in:in std_logic_vector( 1 downto 0);DST_control_out:out std_logic_vector( 1 downto 0);
		ALU_OP_IN:IN std_logic_vector (3 DOWNTO 0); ALU_OP_out:out std_logic_vector (3 DOWNTO 0);
		IN_CTRL_in:IN std_logic;IN_CTRL_out:out std_logic;
		Mem_read_in:IN std_logic;Mem_read_out:out std_logic

); 
END component   writeback_flip;
----------------------End components of pipeline-----------Starting of Forwading UNit-------------------------------
component  ForwardingUnit IS
PORT(
	Reset: IN std_logic;
	ID_EX_RS1,ID_EX_RS2,ID_EX_RD: IN std_logic_vector (2 DOWNTO 0);
	ID_EX_SOURCECONTROL: IN std_logic_vector(2 DOWNTO 0);
	EX_MEM_RS1,EX_MEM_RD: IN std_logic_vector (2 DOWNTO 0);
	EX_MEM_DSTCONTROL: IN std_logic_vector (1 DOWNTO 0);
	MEM_WB_RS1,MEM_WB_RD: IN std_logic_vector (2 DOWNTO 0);
	MEM_WB_DSTCONTROL: IN std_logic_vector (1 DOWNTO 0);
	REG_WRITE_EX_MEM: IN std_logic;
	REG_WRITE_MEM_WB: IN std_logic;
	RS1_SELECT: OUT std_logic_vector (2 downto 0);
	RS2_SELECT: OUT std_logic_vector (2 downto 0);
	RD_SELECT: OUT std_logic_vector (2 downto 0)	
);
end component ForwardingUnit;
------------------------------------------------/////////////////////
component EX_MEM_FORWARDDATA IS

--every input is taken from the ex/mem buffer,except for mem_data which is from mem/wb buffer
PORT(
	Reset: IN std_logic;
	Out_ALU,IN_Port,Read_data1,Read_data3: IN std_logic_vector (31 DOWNTO 0);
	Forwarded_Output: OUT std_logic_vector (31 DOWNTO 0);
	ALU_OP:IN std_logic_vector (3 DOWNTO 0);
	In_ctrl,Swap_ctrl: IN std_logic;
	RS_ADDRESS_DEC_EX,RS1_ADDRESS_EX_MEM,RD_ADDRESS_EX_MEM: IN std_logic_vector (2 DOWNTO 0)
);
	
end component EX_MEM_FORWARDDATA;

component  MEM_WB_FORWARDDATA IS

--every input is taken from the mem/wb buffer
PORT(
	Reset: IN std_logic;
	Write_data1,Write_data2: IN std_logic_vector (31 DOWNTO 0);
	Forwarded_Output: OUT std_logic_vector (31 DOWNTO 0);
	ALU_OP: IN std_logic_vector (3 DOWNTO 0);
	In_ctrl,Swap_ctrl,Mem_read: IN std_logic;
	RS_ADDRESS_DEC_EX,RS1_ADDRESS_MEM_WB,RD_ADDRESS_MEM_WB: IN std_logic_vector (2 DOWNTO 0)
);
	
end component MEM_WB_FORWARDDATA;
--------------------//////////--------------////////////-------------/////////////
component HDU is
	Port( ID_EX_MemRead,ID_EX_RegWrite:IN std_logic;
	Source_ctrl:IN std_logic_vector (2 downto 0);
	IF_ID_Rs1, IF_ID_Rs2, IF_ID_RD_Addr, ID_EX_RD_Addr :IN std_logic_vector (2 downto 0);
	hdu_out:OUT std_logic);
--hdu_out is one bit that takes place of any 3 bit output
end component HDU;
--------------------------------------------/////////////---------------////////////---------------/Cache_memory
component Cache_control is port
(   
    clk,rst:in std_logic;
    Request_Read_instruction,Request_Read_data,Reqest_Write_data:in std_logic;
    jumptype_decode,jumptype_excute:in std_logic_vector (1 downto 0);
    call_Decode,call_excute,RET_decode,Ret_Excute,Ret_memory,jump_decode,jump_excute:in std_logic;
    index_instruction,index_data:in std_logic_vector(5-1 downto 0);
    TAG_instruction,Tag_data,offset_instruction:in std_logic_vector(3-1 downto 0);
    indata_Data:in std_logic_vector(128-1 downto 0);
    C1_inst,C2_inst,C3_inst,C4_inst:out std_logic;
    C1_mem,C2_mem,C3_mem,C4_mem:out std_logic;
    hit :out std_logic;
    dataout:out std_logic_vector(128-1 downto 0)
);
end component Cache_control ;
--------------------------------------------------------------------------
component cache_mem is port 
(
clk,rst,c3,hit,c4:std_logic;
write_en : IN std_logic;
read_en : IN std_logic;
Stackop:in std_logic;
data_in : IN std_logic_vector(128-1 DOWNTO 0);
data_processor:in std_logic_vector(32-1 downto 0);
LDM:in std_logic;
Offset: in std_logic_vector (3-1 downto 0);
Index: in std_logic_vector(5-1 downto 0);
data_out:out std_logic_vector (32-1 downto 0)
);
end component cache_mem;
-----------------------------------------------
component inst_mem is port 
(
clk,rst,C2,C4:std_logic;
two_bits:in std_logic_vector(2-1 downto 0);
data_in : IN std_logic_vector(128-1 DOWNTO 0);
Offset: in std_logic_vector (3-1 downto 0);
Index: in std_logic_vector(5-1 downto 0);
data_out:out std_logic_vector (32-1 downto 0)
);
end component;
----------------------Start of signals---------------------------------------------------
------cashe signals
signal  C1_inst,C2_inst,C3_inst,C4_inst: std_logic;
signal C1_mem,C2_mem,C3_mem,C4_mem, hit: std_logic;
SIGNAL two_bits: std_logic_vector(2-1 downto 0);





-------- All Signals ---------------------------------------///////////////////-
signal PC_FETCH_STOP1,PC_FETCH_STOP2,PC_FETCH_STOP_OUT,c1,c2,c3,dec,c3_out,c4_out,c5_out,BO2,delay_pc :std_logic;
signal PC_FETCH_STOP3,PC_FETCH_STOP4,INC_1,c4,INC_2,c5:  std_logic;
signal out_zeros_fecth,out_zeros_decode,out_zeros_decode0:std_logic;
------------------------------------///////////////////-////--//
signal IN_Fetch_signal:std_logic_vector (96-1 downto 0);
signal pc_signal:std_logic_vector (32-1 downto 0);
signal pc_plusONE:std_logic_vector (32-1 downto 0);
signal pc_change,priority,pc_change2:std_logic;
signal pc_out1,pc_out2,pc_in_delay2,pc_in_delay:std_logic_vector (32-1 downto 0);
----------------------------///////////////////////////////////////////--////
signal out_fecth_signal:std_logic_vector (96-1 downto 0);
signal control_signals:std_logic_vector (33-1 downto 0);
signal EA20: STD_logic_vector (20-1 downto 0);
signal IMM16: std_logic_vector (16-1 downto 0);
signal Read_data1,Read_data2,Rd3: std_logic_vector(32-1 downto 0);
signal EA20_out: STD_logic_vector (32-1 downto 0);
signal IMM32_out: std_logic_vector (32-1 downto 0);
-----Stack 
signal sp_add_out,sp_sub_out,sp_reg_out: std_logic_vector (32-1 downto 0);
signal add_EN,sub_EN :std_logic;
--------------------------------------//////////////////////////-mohma gedn
signal Read_data1_out,Rd3_out,IMM_EA_32: std_logic_vector(32-1 downto 0);
--------------------------------------//////////////////////////-
signal control_signals_out :std_logic_vector(33-1 downto 0);
signal control_NOP :std_logic_vector (33-1 DOWNTO 0);
signal excute_stage: std_logic_vector(263-1 downto 0); 
-------------------------------///////////Fetch and decode Stage -----------///////////Hussein Hussein
---------------------------------------//////////Excute_HOOSAM _OMAR--------------////////////
signal out_Ex_Buffer: std_logic_vector(263-1 downto 0); 
signal Out_Alu:  std_logic_vector(31 downto 0);
signal Alu_C,Alu_N,Alu_Z: std_logic;
signal address_select_out :std_logic_vector (2 downto 0);
signal Z_Flag,N_Flag,C_Flag:  std_logic;
signal jump_Destination,jump_Destination_out :std_logic;
signal Alu_operation,or_and_op:std_logic;
signal out_RS2_address ,RS2_address: STD_LOGIC_VECTOR(2 downto 0);
-----------------------------////////////////////////////////////-///
signal Memory_stage,out_EM_Buffer:std_logic_vector (199-1  downto 0);
signal not_call,and_output:std_logic;
signal mux1_output,mux2_output,mux3_output,mux4_output,mux5_output,mux6_output,mux7_output,mux8_output: std_logic_vector(31 downto 0); --output of muxes
signal data_mem_out:std_logic_vector(32-1 downto 0);
signal or_output1,or_output2,or_output3,or_output4:std_logic;
signal Address2_and_3:std_logic_vector(31 downto 0); ----//hardcoded for interupt and return interupt
signal CCR_out_signal:Std_logic_vector(31 downto 0); 
signal LDM_OP:std_logic;
signal not_push:std_logic;
signal and_output2:std_logic;
-------------------////////////////////////--WB
signal Mem_to_reg_last,out_ctrl_last,Swap_Wb_last,Reg_write1_last,reg_write2_last,push_last:std_logic;
signal read_data1_out_last,read_data3_out_last,output_alu_out_last,data_mem_out_frombuffer:std_logic_vector (32-1 downto 0);
signal Rs_address_last,Rd_address_last:std_logic_vector (3-1 downto 0);
signal RD_CONTROL_LAST:STD_LOGIC_VECTOR (1 DOWNTO 0);
signal ALU_OP_last:  std_logic_vector (3 DOWNTO 0);
signal Mem_read_last,IN_CTRL_out: std_logic;
------
-------
------------------
signal RS1_SELECT:  std_logic_vector (2 downto 0);
signal RS2_SELECT:  std_logic_vector (2 downto 0);
signal RD_SELECT:  std_logic_vector (2 downto 0);
signal Forwarded_Output_MEMORY_RS1,Forwarded_Output_MEMORY_RS2,Forwarded_Output_MEMORY_RD:std_logic_vector(32-1 downto 0);
signal Forwarded_Output_WB_RS1,Forwarded_Output_WB_RS2,Forwarded_Output_WB_RD:std_logic_vector(32-1 downto 0);
-------------------------------------------------------////---///////////////
signal Enable_stall,HDU_stall_out,HDU_stall,PC_disable,hus: std_logic;



-------
begin
PC_FETCH_STOP_OUT<=PC_FETCH_STOP1 OR PC_FETCH_STOP2 OR PC_FETCH_STOP3 OR PC_FETCH_STOP4;
not_call<= not out_EM_Buffer(19);
Address2_and_3<=x"00000002"; ---to be varfied
CCR_out_signal(0)<=C_Flag;
CCR_out_signal(1)<=N_Flag;
CCR_out_signal(2)<=Z_Flag;
CCR_out_signal(3)<='0';
CCR_out_signal(32-1 downto 4)<=x"0000000";
add_EN<= out_Ex_Buffer(2) or INC_1 or INC_2 ;
sub_EN<=c3 or out_EM_Buffer(3) or dec;
out_zeros_fecth<=pc_change or  out_EM_Buffer(17) or PC_FETCH_STOP_OUT;
out_zeros_decode<= pc_change or out_EM_Buffer(17) or c3_out or BO2;------To be edited later
-------------------------------------------------------------
Enable_stall<='1';---///For stalling Enable
BO2<= HDU_stall and Enable_stall;
PC_disable <= pc_fetch_stop_out or BO2;
---------------/////////////////////Decode Stage
IN_Fetch_signal(64-1 downto 32)<=pc_plusONE;
IN_Fetch_signal(96-1 downto 64)<= inport;
------//////---
EA20 <=  out_fecth_signal(20-1 DOWNTO 0);
IMM16<= out_fecth_signal(16-1 DOWNTO 0);
control_NOP(32-1 downto 0)<=x"00000800";
control_NOP (32)<='0';
pc_change<=jump_Destination_out or out_Ex_Buffer(19) ;
priority<=pc_change or c4_out or c3_out;
pc_change2<= c3_out or c4_out or out_EM_Buffer(17); --c3_out and c4_out to be verify that the regsiter if fine  
mux_fecth1:  general_maux  generic map (32) port map(pc_plusONE,Memory_stage(161-1 DOWNTO 129),pc_change,pc_out1);
mux_fecth2:  general_maux  generic map (32) port map(pc_out1,pc_in_delay,pc_change2,pc_out2);------------//////////////////////////////////////////---// Maping for the next stage Excute Stage
mux_fecth3:  general_maux  generic map (32) port map (data_mem_out,IN_Fetch_signal(32-1 downto 0),c3_out,pc_in_delay);
mux_fecth4:general_maux  generic map (32) port map (pc_out2,IN_Fetch_signal(32-1 downto 0),rst,pc_in_delay2);
excute_stage(33-1 DOWNTO 0)<= control_signals_out; ---- control_signals_out (33-1 DOWNTO 0); 
excute_stage(65-1 downto 33)<=out_fecth_signal(64-1 downto 32);  ---PC+1 (65-1 downto 33)
excute_stage(97-1 DOWNTO 65)<= Read_data1; ---Read_data1 (97-1 DOWNTO 65)
excute_stage ( 129-1 DOWNTO 97) <=Read_data2;---- read_data2( 129-1 DOWNTO 97)
excute_stage(161-1 DOWNTO 129)  <=Rd3; ---- RD_3 (161-1 DOWNTO 129) 
excute_stage  (193-1 DOWNTO 161) <=IMM_EA_32; --- IMM_EA_32 (193-1 DOWNTO 161)
excute_stage  (225-1 downto 193)<= IMM32_out;---IMM(225-1 downto 193)
excute_stage (228-1 DOWNTO 225) <=out_fecth_signal(23 downto 21);---/////Rs1_address
excute_stage (231-1 DOWNTO 228)<=out_fecth_signal(26 downto 24); ---///Rd_address
excute_stage ( 263-1  downto 231)<= out_fecth_signal(96-1 downto 64);----- IN ( 263-1  downto 231)
RS2_address<=out_fecth_signal(20 downto 18); ----////RS2_ADDRESSS
Alu_operation <= (out_Ex_Buffer(28) or out_Ex_Buffer(27) or out_Ex_Buffer(26) or out_Ex_Buffer(25) )and (not out_EM_Buffer(17)) ; 
or_and_op<='0' when (out_Ex_Buffer(28)='0' and out_Ex_Buffer(27)='1' and out_Ex_Buffer(26)='1' and out_Ex_Buffer(25)='0' and out_EM_Buffer(17)='0' )
else  '0' when (out_Ex_Buffer(28)='0' and out_Ex_Buffer(27)='1' and out_Ex_Buffer(26)='1' and out_Ex_Buffer(25)='1' and  out_EM_Buffer(17)='0'  )
else '0' when (out_Ex_Buffer(28)='0' and out_Ex_Buffer(27)='0' and out_Ex_Buffer(26)='1' and out_Ex_Buffer(25)='0' and  out_EM_Buffer(17)='0' )
else '1';
---------------------------////////////////////////////MEMORY_STAGE//////////////////////////////////////////-////
Memory_stage(33-1 downto 0)<=out_Ex_Buffer(33-1 downto 0);---- control_signals_out (33-1 DOWNTO 0); 
Memory_stage(65-1 downto 33)<=out_Ex_Buffer(65-1 downto 33);---PC+1 (65-1 downto 33)
Memory_stage(97-1 DOWNTO 65)<=Out_Alu;------Out_Alu
Memory_stage(193-1 DOWNTO 161)<=out_Ex_Buffer (193-1 DOWNTO 161) ; --- IMM_EA_32 (193-1 DOWNTO 161)
Memory_stage(196-1 downto 193)<=out_Ex_Buffer  (228-1 DOWNTO 225); ---/////Rs1_address
Memory_stage(199-1  downto 196)<=address_select_out ;---/////address_select
LDM_op<='1' when out_EM_Buffer(32-1 downto 0)=X"20008C10"
else '0'; 
-----------------------------Memory stage Zeyad Implemnted Buffer that take evey input alone so no one signal :(--------///
not_push<=not (out_EM_Buffer(3));

---Stack_pointer,Counters,Fowrading unit,HDU,EveryThing before processor itself--------------------------------------///////////////////////////--------------------///////////
SP_component:  stack_pointer_register port map (clk,Rst,sp_sub_out,sp_reg_out);
sp_add: add_stack_pointer port map (add_EN,sp_reg_out,sp_add_out);
sp_sub: sub_stack_pointer port map (sub_EN,sp_add_out,sp_sub_out);
interupt_counter: full_InterruptCounter port map (rst,clk,BO2,interupt,PC_FETCH_STOP1,PC_FETCH_STOP2,c1,c2,c3,dec);--to be edited later (stalling input)//Done;
delay0:jump_register port map(clk,Rst,c3,c3_out);	
delay1:jump_register port map(clk,Rst,c4,c4_out);	
delay2:jump_register port map(clk,Rst,c5,c5_out);
delay: jump_register port map(clk,'0',rst,delay_pc);
RTI_counter:full_RTICounter port map (rst,clk,control_signals_out(18),out_Ex_Buffer(17),jump_Destination, PC_FETCH_STOP3,PC_FETCH_STOP4,INC_1,c4,INC_2,c5);
----------//////////////----------------------------------------------///////////////institaion
registerFile:register_file port map(mux8_output,read_data1_out_last,out_fecth_signal(23 downto 21),out_fecth_signal(20 downto 18),out_fecth_signal(26 downto 24),Rd_address_last,Rs_address_last,Reg_write1_last,reg_write2_last,Clk,Rst,Read_data1,Read_data2,Rd3);
adder_pc: add_Buffer PORT MAP(pc_signal,IN_Fetch_signal(31 downto 27),pc_plusONE);
pc: program_counter port map(clk,rst,PC_disable ,priority,delay_pc,pc_in_delay2,pc_signal);
inst_memory:ram  Generic map  (32,16)  port map(rst,clk,c3_out,pc_signal,IN_Fetch_signal(32-1 downto 0));
------------------------------------///////////////----------------
Fecth_Register:Fecth_buffer port map (clk,rst,BO2,out_zeros_fecth,IN_Fetch_signal,out_fecth_signal);
controlUnit: control_unit port map (out_fecth_signal(31 downto 27),control_signals);
Sign_extent1:  sign_extent  generic map (20) port map (EA20,EA20_out);
-----------------------------------//////////////////////------------
sign_extent2: sign_extent   generic map(16) port map (IMM16,IMM32_out);
mux2: mux32_Decode generic map (32) port map (EA20_out,IMM32_OUT,control_signals(15),IMM_EA_32);
------------------------------------------///////////////////-//////later---//////--////---//
mux3: mux32_decode generic map (33) port map (control_signals,control_NOP,out_zeros_decode,control_signals_out);
-----------------------------//////////////////////////////////////////////////----later--...
D_E_buffer: Decode_Excute_Buffer port map(clk,rst, excute_stage ,out_Ex_Buffer, RS2_address , out_RS2_address );
-------------------------------///////////Fetch and decode Stage -----------///////////Hussein Hussein
---------------------------------------//////////Excute_HOOSAM _OMAR--------------////////////
-----------------------------//////////////////////////////////////////////////----later--...
alu: AluBlock port map(out_Ex_Buffer(33-1 Downto 0),RS1_SELECT,RS2_SELECT,RD_SELECT,out_Ex_Buffer(97-1 DOWNTO 65),out_Ex_Buffer( 129-1 DOWNTO 97),out_Ex_Buffer(161-1 DOWNTO 129),out_Ex_Buffer(225-1 downto 193),out_Ex_Buffer( 263-1  downto 231),Forwarded_Output_MEMORY_RS1,Forwarded_Output_WB_RS1,Forwarded_Output_MEMORY_RS2,Forwarded_Output_WB_RS2,Forwarded_Output_MEMORY_RD,Forwarded_Output_WB_RD,Out_Alu, Alu_C,Alu_N,Alu_Z,Memory_stage( 129-1 DOWNTO 97),Memory_stage(161-1 DOWNTO 129) );
--RS1_SELECT,RS2_SELECT,RD_SELECT,
--"001","001","001",
mux4: mux32_Decode generic map (3) port map (out_Ex_Buffer(228-1 DOWNTO 225), out_Ex_Buffer(231-1 DOWNTO 228),out_Ex_Buffer(11),address_select_out );
mux_jump:jump_mux port map(out_Ex_Buffer(22),Z_Flag,N_Flag,C_Flag,out_Ex_Buffer(21 Downto 20), jump_Destination);
CCR_Reg: full_CCR port map ( jump_Destination,clk,out_Ex_Buffer(24),out_Ex_Buffer(23),Alu_operation,c5_out,Alu_C,data_mem_out(0),Alu_N,data_mem_out(1),Alu_Z,data_mem_out(2),or_and_op,out_Ex_Buffer(21 Downto 20),rst,C_Flag,N_Flag,Z_Flag);
jump_Dest_register:jump_register port map(clk,Rst,jump_Destination,jump_Destination_out);	
------------------//////////////////////////////////////////////////////////-//////////////////////////Memory_stage_Stage
EM_BUFFER1: Excute_MEMORY_Buffer port map (clk,rst,out_EM_Buffer(17),'0',Memory_stage,out_EM_Buffer);
or1: gate port map(c3,c4,c5,out_EM_Buffer(29),or_output1);
or2: gate port map(c1,c2,out_EM_Buffer(30),'0',or_output2);
or3: gate port map(c1,c2,c4,out_EM_Buffer(12),or_output3);
or_output4 <= or_output3 or c5;
------
and1: and2 port map(not_call,out_EM_Buffer(30),and_output);
and_output2<=(not_push and and_output);
storage1: storage  port map(clk,rst,or_output2,or_output1,or_output4,mux2_output,mux6_output,LDM_op,data_mem_out);
----muxes down
mux1_memory: general_maux generic map (32) port map(out_EM_Buffer(193-1 DOWNTO 161),sp_Reg_out,or_output4,mux1_output);
mux2_memory: general_maux  generic map (32) port map(mux1_output,Address2_and_3,c3,mux2_output);
--------muxes up
mux3_memory: general_maux  generic map (32) port map(out_EM_Buffer(161-1 DOWNTO 129),out_EM_Buffer(65-1 downto 33) ,out_EM_Buffer(19),mux3_output);
mux4_memory: general_maux  generic map (32) port map(mux3_output,out_EM_Buffer( 129-1 DOWNTO 97),and_output2,mux4_output);
mux5_memory: general_maux  generic map (32) port map(mux4_output,CCR_out_signal,c1,mux5_output);
mux6_memory: general_maux  generic map (32) port map(mux5_output,PC_signal,C2,mux6_output);
-----write back
wb_buffer:writeback_flip port map(clk,rst,'0',out_EM_Buffer(10),out_EM_Buffer(1),out_EM_Buffer(9),out_EM_Buffer(32),out_EM_Buffer(31),out_EM_Buffer(3),out_EM_Buffer( 129-1 DOWNTO 97),out_EM_Buffer(161-1 DOWNTO 129),out_EM_Buffer(97-1 DOWNTO 65),data_mem_out,out_EM_Buffer (196-1 downto 193),out_EM_Buffer(199-1 downto 196),Mem_to_reg_last,out_ctrl_last,Swap_Wb_last,Reg_write1_last,reg_write2_last,push_last, Read_data1_out,Rd3_out,output_alu_out_last,data_mem_out_frombuffer, Rs_address_last,Rd_address_last,out_EM_Buffer(5 DOWNTO 4),RD_CONTROL_LAST,out_EM_Buffer(28 downto 25), ALU_OP_last,out_EM_Buffer(0),IN_CTRL_out,out_EM_Buffer(29),Mem_read_last);
mux7_wB: general_maux generic map (32) port map(output_alu_out_last,data_mem_out_frombuffer,Mem_to_reg_last,mux7_output);
mux8_WB:general_maux generic map (32) port map(mux7_output,read_data3_out_last,Swap_Wb_last,mux8_output);
tri_state: n_tri_state  generic map (32) port map(read_data3_out_last,output_bus,out_ctrl_last);
mux0: mux32_Decode generic map (32) PORT MAP ( Read_data1_out,Rd3_out,Swap_Wb_last,read_data1_out_last);
mux1: mux32_Decode generic map (32) port map (Rd3_out, Read_data1_out,Swap_Wb_last,read_data3_out_last);

----------------------------------------------------////////////FD
FW:ForwardingUnit port map(RST,out_Ex_Buffer(228-1 DOWNTO 225), out_RS2_address ,out_Ex_Buffer(231-1 DOWNTO 228),out_Ex_Buffer(8 DOWNTO 6),out_EM_Buffer(196-1 downto 193),out_EM_Buffer(199-1  downto 196),out_EM_Buffer(5 downto 4), Rs_address_last,Rd_address_last, RD_CONTROL_LAST,out_Ex_Buffer(33-1),Reg_write1_last,RS1_SELECT,RS2_SELECT,RD_SELECT);


-------------------
F1_MEM: EX_MEM_FORWARDDATA port map(Rst,out_EM_Buffer(97-1 DOWNTO 65),out_EM_Buffer(97-1 DOWNTO 65),out_EM_Buffer( 129-1 DOWNTO 97),out_EM_Buffer(161-1 DOWNTO 129), Forwarded_Output_MEMORY_RS1,out_EM_Buffer(28 DOWNTO 25),out_EM_Buffer(0),out_EM_Buffer(9),out_Ex_Buffer(228-1 DOWNTO 225),out_EM_Buffer(196-1 downto 193),out_EM_Buffer(199-1  downto 196));
F2_MEM: EX_MEM_FORWARDDATA port map(Rst,out_EM_Buffer(97-1 DOWNTO 65),out_EM_Buffer(97-1 DOWNTO 65),out_EM_Buffer( 129-1 DOWNTO 97),out_EM_Buffer(161-1 DOWNTO 129), Forwarded_Output_MEMORY_RS2,out_EM_Buffer(28 DOWNTO 25),out_EM_Buffer(0),out_EM_Buffer(9),out_RS2_address ,out_EM_Buffer(196-1 downto 193),out_EM_Buffer(199-1  downto 196));
F3_MEM: EX_MEM_FORWARDDATA port map(Rst,out_EM_Buffer(97-1 DOWNTO 65),out_EM_Buffer(97-1 DOWNTO 65),out_EM_Buffer( 129-1 DOWNTO 97),out_EM_Buffer(161-1 DOWNTO 129), Forwarded_Output_MEMORY_RD,out_EM_Buffer(28 DOWNTO 25),out_EM_Buffer(0),out_EM_Buffer(9), out_Ex_Buffer(231-1 DOWNTO 228),out_EM_Buffer(196-1 downto 193),out_EM_Buffer(199-1  downto 196));
----------------
F1_WB: MEM_WB_FORWARDDATA port map(Rst,mux8_output,read_data1_out_last,Forwarded_Output_WB_RS1, ALU_OP_last,IN_CTRL_out,Swap_Wb_last,Mem_read_last,out_Ex_Buffer(228-1 DOWNTO 225),Rs_address_last,Rd_address_last);
F2_WB:  MEM_WB_FORWARDDATA port map(Rst,mux8_output,read_data1_out_last,Forwarded_Output_WB_RS2, ALU_OP_last,IN_CTRL_out,Swap_Wb_last,Mem_read_last,out_RS2_address,Rs_address_last,Rd_address_last);
F3_WB:  MEM_WB_FORWARDDATA port map(Rst,mux8_output,read_data1_out_last,Forwarded_Output_WB_RD, ALU_OP_last,IN_CTRL_out,Swap_Wb_last,Mem_read_last,out_Ex_Buffer(231-1 DOWNTO 228),Rs_address_last,Rd_address_last);
-----------------------------------/////////////////-------------///////////----------------
HDU_Comp1234: HDU port map (out_Ex_Buffer(29),out_Ex_Buffer(32),control_signals(8 downto 6),excute_stage (228-1 DOWNTO 225),RS2_address,excute_stage (231-1 DOWNTO 228),out_Ex_Buffer(231-1 DOWNTO 228),HDU_stall);
end architecture processor;