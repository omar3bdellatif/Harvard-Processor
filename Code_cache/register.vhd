LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY my_nDFF IS
PORT( Clk,Rst,enable : IN std_logic;
		   d : IN std_logic_vector(32-1 DOWNTO 0);
		   q : OUT std_logic_vector(32-1 DOWNTO 0));
		
END my_nDFF;
ARCHITECTURE a_my_nDFF OF my_nDFF IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <= (OTHERS=>'0');
ELSIF falling_edge(Clk) THEN
		if enable='1' then
		q <= d;
		end if;
END IF;
END PROCESS;
END a_my_nDFF;
