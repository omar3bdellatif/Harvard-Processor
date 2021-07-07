
library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY writeback_flip IS
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
END   writeback_flip;
ARCHITECTURE flip1 OF writeback_flip IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
		 ctrl_sig_1_out<='0';ctrl_sig_2_out<='0';ctrl_sig_3_out<='0';ctrl_sig_4_out<='0';ctrl_sig_5_out<='0';ctrl_sig_6_out<='0';
                  --lowerdataout_out<= (OTHERS=>'0');upperdataout_out<= (OTHERS=>'0');
                   DST_control_out<="00";IN_CTRL_out<='0';
read_data1_out<= (OTHERS=>'0');read_data3_out<= (OTHERS=>'0');output_alu_out<= (OTHERS=>'0');data_mem_out_output<= (OTHERS=>'0');Rs_address_out<= (OTHERS=>'0');Rd_address_out <= (OTHERS=>'0'); ALU_OP_out<= "0000";Mem_read_out<='0';-- 5lehom kulhom b zero
ELSIF rising_edge(Clk) THEN
 	 if zero = '0' then
		ctrl_sig_1_out<=ctrl_sig_1;ctrl_sig_2_out<=ctrl_sig_2;ctrl_sig_3_out<=ctrl_sig_3;ctrl_sig_4_out<=ctrl_sig_4;ctrl_sig_5_out<=ctrl_sig_5;ctrl_sig_6_out<=ctrl_sig_6;
                   --lowerdataout_out<=lowerdataout;upperdataout_out<=upperdataout;
                   read_data1_out<=read_data1;read_data3_out<=read_data3;output_alu_out<=output_alu;data_mem_out_output<=data_mem_out;Rs_address_out<=Rs_address;Rd_address_out<=Rd_address;
		DST_control_out<=DST_control_in;
		ALU_OP_out<=ALU_OP_IN;
		Mem_read_out<=Mem_read_in;
		IN_CTRL_out<=IN_CTRL_IN;
	elsif zero='1' then
	ctrl_sig_1_out<='0';ctrl_sig_2_out<='0';ctrl_sig_3_out<='0';ctrl_sig_4_out<='0';ctrl_sig_5_out<='0';ctrl_sig_6_out<='0';
                  --lowerdataout_out<= (OTHERS=>'0');upperdataout_out<= (OTHERS=>'0');
                   DST_control_out<="00";IN_CTRL_out<='0';
read_data1_out<= (OTHERS=>'0');read_data3_out<= (OTHERS=>'0');output_alu_out<= (OTHERS=>'0');data_mem_out_output<= (OTHERS=>'0');Rs_address_out<= (OTHERS=>'0');Rd_address_out <= (OTHERS=>'0'); ALU_OP_out<= "0000";Mem_read_out<='0';-- 5lehom kulhom b zero
end if;
END IF;
END PROCESS;
END flip1;
