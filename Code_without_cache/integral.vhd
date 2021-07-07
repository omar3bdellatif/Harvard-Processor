
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
entity integrate 
is
Generic(x: integer :=32 ; n: integer:=16 ; m:integer:=32);
port
(
 clk,rst:IN std_logic;
 --Input_bus: IN std_logic_vector (31 downto 0); --lhowa l input port
 output_bus: out std_logic_vector (31 downto 0)--l howa l output port
);
end integrate;

architecture behavioral of integrate 
is
component and2 IS
	PORT( a,b : IN std_logic;
		  z : OUT std_logic);
END component and2;
component general_maux IS 
	Generic ( n : Integer:=32);
	PORT ( in0,in1 : IN std_logic_vector (n-1 DOWNTO 0);
			sel : IN  std_logic;
			output : OUT std_logic_vector (n-1 DOWNTO 0));
END component;
component n_tri_state IS 
Generic(n: integer :=32);
port (Input :IN std_logic_vector (n-1 downto 0);
Output :Out std_logic_vector (n-1 downto 0);
En :IN std_Logic);  --hyb2a l out_ctrl
End component n_tri_state;
component gate is --fe 7alet ana msh m7tag 4 input h7ot input menhom b zero mslan 
port(
a : in std_logic;
b : in std_logic;
c : in std_logic;
d : in std_logic;
output: out std_logic);
end component gate;
component storage IS
PORT 
(
	clk : IN std_logic;
        rst: IN std_logic;  --lsa hnshof n3mlha wla eh
	write_en : IN std_logic;
        read_en : IN std_logic;
	address : IN std_logic_vector(31 DOWNTO 0);
	datain : IN std_logic_vector(31 DOWNTO 0);
	dataout : OUT std_logic_vector(31 DOWNTO 0)
          
);
END component  storage;
component writeback_flip IS
PORT(Clk,Rst: IN std_logic;
		   ctrl_sig_1,ctrl_sig_2,ctrl_sig_3,ctrl_sig_4,ctrl_sig_5 : IN std_logic;
                   read_data1,read_data3,output_alu,data_mem_out,Input_bus : IN std_logic_vector(31 downto 0); -- 32 bit
                   Rs_address,Rd_address: IN std_logic_vector(2 downto 0); -- 3bit address
		   ctrl_sig_1_out,ctrl_sig_2_out,ctrl_sig_3_out,ctrl_sig_4_out,ctrl_sig_5_out : out std_logic;
                --   lowerdataout_out,upperdataout_out: Out std_logic_vector(15 downto 0);
                   read_data1_out,read_data3_out,output_alu_out,data_mem_out_output,Input_bus_output : out std_logic_vector(31 downto 0); -- 32 bit
                   Rs_address_out,Rd_address_out: out std_logic_vector(2 downto 0)); -- 3bit address);
END component   writeback_flip;
signal  call_signal,stack_op,Mem_write,Mem_read,Swap_Wb,out_ctrl,Mem_to_reg: std_logic;
signal or_output1,or_output2,or_output3:std_logic;
signal read_data1_out,read_data3_out,output_alu_out,data_mem_out,Input_bus_output: std_logic_vector(31 downto 0); --32 bit
signal data_mem_out_frombuffer : std_logic_vector(31 downto 0);
signal mux1_output,mux2_output,mux3_output,mux4_output,mux5_output,mux6_output,mux7_output,mux8_output: std_logic_vector(31 downto 0); --output of muxes
signal PC_1,PC : std_logic_vector(31 downto 0);-- 32bit --l mfrod htkon gyaly mn l buffer l ablo
signal two_extended: std_logic_vector(31 downto 0); --l mfrod htkon gyaly ka signal mn bra
signal EA_32 : std_logic_vector (31 downto 0); -- l mfrod htkon gyaly ml buffer l ably
signal Sp_out: std_logic_vector(31 downto 0); -- l mfrod htkon gyaly ml SP k-signal
signal CCR:Std_logic_vector(31 downto 0); --l7d ama ygely
signal C1,C2,C3,C4,C5: std_logic; --l7d ama ygolyyyy
signal Reg_write1,reg_write2: std_logic; --gyenly ml buffer l ably
signal zeros:std_logic; --3shan bs a3rf ad5lha fl OR gate
signal Rs_address,Rd_address: std_logic_vector(2 downto 0);
signal and_output : std_logic;
signal not_call: std_logic;
--signal lower_data_mem_out_output,upper_data_mem_out_output: std_logic_vector(15 downto 0);
begin
not_call<= not call_signal;
mux1: general_maux generic map (32) port map(EA_32,Sp_out,or_output3,mux1_output);

mux2: general_maux  generic map (32) port map(mux1_output,two_extended,C3,mux2_output);

mux3: general_maux  generic map (32) port map(read_data3_out,PC_1,call_signal,mux3_output);

mux4: general_maux  generic map (32) port map(read_data1_out,mux3_output,and_output,mux4_output);

mux5: general_maux  generic map (32) port map(mux4_output,CCR,C1,mux5_output);

mux6: general_maux  generic map (32) port map(mux5_output,PC,C2,mux6_output);
or1: gate port map(C3,C4,C5,Mem_read,or_output1);
or2: gate port map(C1,C2,Mem_write,zeros,or_output2);
or3: gate port map(C1,C2,C4,stack_op,or_output3);
and1: and2 port map(not_call,Mem_write,and_output);
storage1: storage  port map(clk,rst,or_output2,or_output1,mux2_output,mux6_output,data_mem_out);
wb_buffer:writeback_flip port map(clk,rst,Mem_to_reg,out_ctrl,Swap_Wb,Reg_write1,reg_write2,read_data1_out,read_data3_out,output_alu_out,data_mem_out,Input_bus_output,Rs_address,Rd_address,Mem_to_reg,out_ctrl,Swap_Wb,Reg_write1,reg_write2,read_data1_out,read_data3_out,output_alu_out,data_mem_out_frombuffer,Input_bus_output,Rs_address,Rd_address); -- hena mkrren mrten l howa input w output y3ny
--dol fl writeback(7,8,9) wl tri state brdo
mux7: general_maux generic map (m) port map(output_alu_out,data_mem_out_frombuffer,Mem_to_reg,mux7_output);
mux8:general_maux generic map (m) port map(mux7_output,read_data3_out,Swap_Wb,mux8_output);
tri_state: n_tri_state  generic map (m) port map(read_data3_out,output_bus,out_ctrl);
end behavioral;