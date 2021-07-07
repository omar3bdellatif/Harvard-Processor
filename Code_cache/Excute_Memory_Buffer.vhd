LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity Excute_MEMORY_Buffer is port
( Clk,RST,Zeros,disable : IN std_logic;
		   d : IN std_logic_vector (199-1  downto 0);
		   q : OUT std_logic_vector (199-1  downto 0));
---- control_signals_out (33-1 DOWNTO 0); 
---PC+1 (65-1 downto 33)
------Out_Alu
 --- IMM_EA_32 (193-1 DOWNTO 161)
 ---/////Rs1_address
---/////address_select
end entity Excute_MEMORY_Buffer;
Architecture EM_BUFFER of Excute_MEMORY_Buffer is
BEGIN 
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <= (OTHERS=>'0');
ELSIF rising_edge(Clk) THEN
	if (zeros='0' and disable='0')	Then 
             q <= d;
	elsif (zeros='1') Then 
	q <= (OTHERS=>'0');
END IF;
END IF;
END PROCESS;






END EM_BUFFER;
