LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity Decode_Excute_Buffer is port
( Clk,RST : IN std_logic;
		   d : IN std_logic_vector(263-1 DOWNTO 0);
		   q : OUT std_logic_vector(263-1 DOWNTO 0);
		RS2_address:in std_logic_vector(2 downto 0);
		out_RS2_address:out std_logic_vector(2 downto 0)
);
----/////////////////////////////////////////////////////////////////---- control_signals_out (33-1 DOWNTO 0); 
----/////////////////////////////////////////////////////////////////---- PC+1 (65-1 downto 33)
----/////////////////////////////////////////////////////////////////---- Read_data1_out (97-1 DOWNTO 65)
----/////////////////////////////////////////////////////////////////---- read_data2 _out( 129-1 DOWNTO 97
----/////////////////////////////////////////////////////////////////---- RD_3_out (161-1 DOWNTO 129) 
----/////////////////////////////////////////////////////////////////---- IMM_EA_32 (193-1 DOWNTO 161)
--------//////////////////////////////////////////////////////////--------IMM(225-1 downto 193)
----/////////////////////////////////////////////////////////////////----  Rs1_address(228-1 DOWNTO 225) 
----/////////////////////////////////////////////////////////////////---- Rd_address (231-1 DOWNTO 228)
----////////////////////////////////////////////////////////////---------- IN ( 263-1  downto 231)
----////////////////////////////////////////////////////////////---------- RS2_address:in std_logic_vector(2 downto 0)
end entity Decode_Excute_Buffer;
Architecture DE_BUFFER of Decode_Excute_Buffer is
BEGIN 
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <= (OTHERS=>'0');
		out_RS2_address<="000";
ELSIF rising_edge(Clk) THEN
		q <= d;
		out_RS2_address<=RS2_address;
END IF;
END PROCESS;






END DE_BUFFER;