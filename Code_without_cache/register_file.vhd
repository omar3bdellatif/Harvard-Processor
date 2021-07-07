LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY register_file IS
port(	
Write_data1,Write_data2:in std_logic_vector (32-1 downto 0);
Rsource_1,Rsource_2,Rd_address:in std_logic_vector(2 downto 0);
Write_address1,Write_address2:in std_logic_vector(2 downto 0);
REG_Write1,Reg_write2:in std_logic ;
Clk,Rst : IN std_logic;
Read_data1,Read_data2,Rd3: out std_logic_vector(32-1 downto 0)
);
end register_file;
architecture reg_file of register_file is
component decoder is port 
(SEL : IN std_logic_vector (2 downto 0);
Enable: in std_logic;
output: OUT STD_LOGIC_vector (7 downto 0)
);
end component decoder;
component mux_reg_file is port 
(r0,r1,r2,r3,r4,r5,r6,r7 : IN std_logic_vector (32-1 downto 0);
SEL:in std_logic_vector (2 downto 0);
output: OUT STD_LOGIC_vector (32-1 downto 0)
);
end component mux_reg_file;
component mux_reg_file_input IS
port(	
Write_data1,Write_data2:in std_logic_vector (32-1 downto 0);
REG_Write1,Reg_write2:in std_logic ;
input_reg :out std_logic_vector(32-1 downto 0)
);
end component mux_reg_file_input;
component  my_nDFF IS
PORT( Clk,Rst,enable : IN std_logic;
		   d : IN std_logic_vector(32-1 DOWNTO 0);
		   q : OUT std_logic_vector(32-1 DOWNTO 0));
		
END component my_nDFF;
------------------------------------//////////////-/////////////------------/
signal reg_write1_out: std_logic_vector (7 downto 0);
signal reg_write2_out: std_logic_vector (7 downto 0);
-----------------------/////////////---------------///////////---------------
signal q0:std_logic_vector (32-1 downto 0); 
signal q1:std_logic_vector (32-1 downto 0);
signal q2:std_logic_vector (32-1 downto 0);
signal q3:std_logic_vector (32-1 downto 0);   
signal q4:std_logic_vector (32-1 downto 0); 
signal q5:std_logic_vector (32-1 downto 0);
signal q6:std_logic_vector (32-1 downto 0);
signal q7:std_logic_vector (32-1 downto 0);  
--------------///////////////////////////---------------------/////////////////////
signal d0:std_logic_vector (32-1 downto 0); 
signal d1:std_logic_vector (32-1 downto 0);
signal d2:std_logic_vector (32-1 downto 0);
signal d3:std_logic_vector (32-1 downto 0);   
signal d4:std_logic_vector (32-1 downto 0); 
signal d5:std_logic_vector (32-1 downto 0);
signal d6:std_logic_vector (32-1 downto 0);
signal d7:std_logic_vector (32-1 downto 0);  
--------------///////////////////////////---------------------/////////////////////
signal Enable_general:std_logic_vector (7 downto 0);
-----////----------------/////////////////////////---------/
begin 
reg_write1_decoder_component: decoder port map (write_address1,Reg_write1,reg_write1_out);
reg_write2_decoder_component: decoder port map (write_address2,Reg_write2,reg_write2_out);
------------------/////////////////-------------/////////////////--------------------
mux_input0:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(0),reg_write2_out(0),d0);
mux_input1:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(1),reg_write2_out(1),d1);
mux_input2:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(2),reg_write2_out(2),d2);
mux_input3:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(3),reg_write2_out(3),d3);
mux_input4:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(4),reg_write2_out(4),d4);
mux_input5:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(5),reg_write2_out(5),d5);
mux_input6:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(6),reg_write2_out(6),d6);
mux_input7:mux_reg_file_input port map (write_data1,write_data2,reg_write1_out(7),reg_write2_out(7),d7);
---------------------/////////////////////////////////-------------------------------------////////////////
Enable_general(0)<=reg_write1_out(0) or reg_write2_out(0);
Enable_general(1)<=reg_write1_out(1) or reg_write2_out(1);
Enable_general(2)<=reg_write1_out(2) or reg_write2_out(2);
Enable_general(3)<=reg_write1_out(3) or reg_write2_out(3);
Enable_general(4)<=reg_write1_out(4) or reg_write2_out(4);
Enable_general(5)<=reg_write1_out(5) or reg_write2_out(5);
Enable_general(6)<=reg_write1_out(6) or reg_write2_out(6);
Enable_general(7)<=reg_write1_out(7) or reg_write2_out(7);
------///////////////---------------------//////////////
r0: my_nDFF port map  (CLK,Rst,Enable_general(0),d0,q0); --//Register number 0 
r1: my_nDFF port map  (CLK,Rst,Enable_general(1),d1,q1); --//Register number 1 
r2: my_nDFF port map  (CLK,Rst,Enable_general(2),d2,q2); --//Register number 2 
r3: my_nDFF port map  (CLK,Rst,Enable_general(3),d3,q3); --//Register number 3 
r4: my_nDFF port map  (CLK,Rst,Enable_general(4),d4,q4); --//Register number 4 
r5: my_nDFF port map  (CLK,Rst,Enable_general(5),d5,q5); --//Register number 5 
r6: my_nDFF port map  (CLK,Rst,Enable_general(6),d6,q6); --//Register number 6 
r7: my_nDFF port map  (CLK,Rst,Enable_general(7),d7,q7); --//Register number 7 
--------------------------//////////////////------------------------//////////////////
mux_Rsource1: mux_reg_file PORT MAP(q0,q1,q2,q3,q4,q5,q6,q7,Rsource_1,Read_data1);
mux_Rsource2: mux_reg_file port map(q0,q1,q2,q3,q4,q5,q6,q7,Rsource_2,Read_data2);
mux_RD:       mux_reg_file port map(q0,q1,q2,q3,q4,q5,q6,q7,Rd_address,RD3);
end reg_file;