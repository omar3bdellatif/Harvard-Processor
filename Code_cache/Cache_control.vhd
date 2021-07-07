LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
Entity Cache_control is port
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
two_bits: out std_logic_vector (2-1 downto 0);
    dataout:out std_logic_vector(128-1 downto 0)



);
end Cache_control;
architecture Cache_Controlling of Cache_control is 
TYPE struct_inst IS ARRAY(0 TO 31) of std_logic_vector( 5-1 DOWNTO 0);
SIGNAL struct_inst_signal: struct_inst := (
OTHERS => "00000"
);
TYPE struct_data IS ARRAY(0 TO 31) of std_logic_vector( 5-1 DOWNTO 0);
SIGNAL struct_data_signal : struct_data := (
OTHERS => "00000"
);
component main_memory IS
PORT 
(
	clk : IN std_logic;
        rst,c1,c2,c1_inst,c3_inst: IN std_logic;
	index:in std_logic_vector (5-1 downto 0);
	Tag:in std_logic_vector (3-1 downto 0);
	datain : in std_logic_vector(128-1 DOWNTO 0);
	Address:in std_logic_vector(11-1 downto 0);
	data_32_out:out std_logic_vector(16-1 downto 0); 
	dataout : OUT std_logic_vector(128-1 DOWNTO 0)  
);
END  component main_memory;
component my_cacheCounter IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Trigger: IN std_logic;
	out1,out2,out3,out4: OUT std_logic
	
);
end component my_cacheCounter;
signal array_inst,array_data,INDEX_IN_MAIN,Final_C1_4,Final_C2_4,array_inst_con:std_logic_vector (5-1 downto 0);
signal vaild_bit_inst,vaild_bit_data,TAG_inst_check,TAG_data_check,C1_main,C2_main:std_logic;
signal C1_1,C1_2,C1_3,C1_4,Trigger1,check_1,Rst_actual,vaild_bit_inst_con,a_con,TAG_inst_check_con:std_logic; 	
signal C2_1,C2_2,C2_3,C2_4,Trigger2,Request_R_OR_W,control,con:std_logic; 
signal C3_1,C3_2,C3_3,C3_4,Trigger3:std_logic;
signal jump_check_D,jump_check_E,a,b:std_logic;	
signal Tag_in_main:std_logic_vector(3-1 downto 0);
signal address_main_memory:std_logic_vector(11-1 downto 0);
signal data_mem_out_16:std_logic_vector(16-1 downto 0);
BEGIN 
jump_check_D<= '0' when  (jumptype_decode(0)='0' and  jumptype_decode(1)='0' and jump_decode='1')
else '1';
jump_check_E<='0' when  (jumptype_excute(0)='0' and   jumptype_excute(1)='0' and jump_excute='1')
else '1';
check_1<=Request_Read_instruction and  jump_check_D and jump_check_E and  (not call_Decode) and (not call_excute) and (not RET_decode) and (not Ret_Excute) and (not Ret_memory) ;
array_inst<=struct_inst_signal (to_integer(Unsigned(index_instruction)));
array_data<=struct_data_signal (to_integer(Unsigned(index_data)));
vaild_bit_inst<=array_inst(3);
vaild_bit_data<=array_data(3);
TAG_inst_check<='0' when (TAG_instruction=array_inst(3-1 downto 0))
else '1';--if equal 0 is correction
TAG_data_check<='0' when (Tag_data=array_data(3-1 downto 0))
else '1';
a<=(not vaild_bit_inst)  or TAG_inst_check;
b<=(not vaild_bit_data)  or TAG_data_check;
Trigger1<=(a and check_1) OR C3_4 or (a_con and check_1);
Trigger2<= b and Request_R_OR_W ;
Request_R_OR_W<= Request_Read_data OR Reqest_Write_data;
Trigger3<=Trigger1 and Trigger2;
Rst_actual<= C3_1 or C3_2 OR C3_3;
Cache1_inst: my_cacheCounter port map(Rst_actual,clk,Trigger1,C1_1,C1_2,C1_3,C1_4);
Cache2_MEM: my_cacheCounter port map(rst,clk,Trigger2,C2_1,C2_2,C2_3,C2_4);
Cashe_aux:my_cacheCounter port map(rst,clk,Trigger3,C3_1,C3_2,C3_3,C3_4);
------------------Tazbet el Counters bet33ml a------------------
C1_main<=C2_1 AND array_data(4);
C2_main<=C2_2 OR C1_2;
INDEX_IN_MAIN<= index_instruction when c1_2='1'
else index_data when (c2_2='1' or C1_main='1')
else index_instruction;
Tag_in_main<= TAG_instruction when c1_2='1'
else Tag_data when c2_2='1'
else  array_data(3-1 downto 0) when C1_main='1'
else TAG_instruction;
--------------------------------
memory_orignal: main_memory port map(clk,rst,C1_main ,C2_main,C1_1,C1_3,INDEX_IN_MAIN,Tag_in_main,indata_Data,address_main_memory,data_mem_out_16,dataout);
Final_C2_4(3-1 downto 0)<= TAG_Data;
Final_C1_4(3-1 downto 0)<= TAG_instruction;
---------------
Final_C2_4(3)<='1';
Final_C2_4(4)<='0';
-----------------------------
Final_C1_4(3)<='1';
Final_C1_4(4)<='0';
-------------------------------
hit<= not Trigger2;
process(clk) is
begin
IF falling_edge(clk)  THEN	
        if (C1_4='1')	Then
	struct_inst_signal (to_integer(Unsigned(index_instruction)))<= 	Final_C1_4;
	end if;
	if (a_con='1' and C1_4='1') then
 	struct_inst_signal (to_integer(Unsigned(index_instruction))+1)<= 	Final_C1_4;
 	end if;
	if (C2_4='1')	Then
	struct_data_signal (to_integer(Unsigned(index_data)))<= 	Final_C2_4;
 	end if;
	if(Reqest_Write_data='1' and C2_4='1') then
	struct_data_signal (to_integer(Unsigned(index_data)))(4)<='1';
        end if;
end if;
end process;
----------------------
address_main_memory(3-1 downto 0)<=offset_instruction;
address_main_memory(8-1 downto 3)<=index_instruction;
address_main_memory(11-1 downto 8)<=TAG_instruction;
------------------------
array_inst_con<=struct_inst_signal (to_integer(Unsigned(index_instruction))+1);
vaild_bit_inst_con<=array_inst_con(3);
TAG_inst_check_con<='0' when (TAG_instruction=array_inst_con(3-1 downto 0))
else '1';--if equal 0 is correction
a_con<=((not vaild_bit_inst_con)  or TAG_inst_check_con )and con;

con<='1' when (address_main_memory(3-1 downto 0)="111" and control='1')
else '0';
two_bits<="00" when (a_con='0' and a='0') 
else "10" when (a_con='1' and a='0')
else "01" when (a_con='0' and a='1')
else "11" when (a_con='1' and a='1');

WITH data_mem_out_16(16-1 downto 11)	
SELECT control <= '1' WHEN "01010",
'1'  WHEN "01110",
'1' WHEN "01111",
'1'  WHEN "10010",
'1'  WHEN "10011",
'1'  WHEN "10100",
'0' WHEN OTHERS;
--------------------set outputs
C1_inst<=C1_1 ;
C2_inst<=C1_2; 
C3_inst<=C1_3;
C4_inst<=C1_4;
---------------------
C1_mem<=C2_1 ;
C2_mem<=C2_2; 
C3_mem<=C2_3;
C4_mem<=C2_4;
-----------------------


end Cache_Controlling ;
