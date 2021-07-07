LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY Fecth_buffer IS
PORT( Clk,Rst,disable,zeros : IN std_logic;
		   d : IN std_logic_vector(96-1 DOWNTO 0);
		   q : OUT std_logic_vector(96-1 DOWNTO 0)); ------///// IN (96-1 TO 64)
----/////////////////////////////////////////////////////////////////---- PC+1 (64-1 DOWNTO )
----/////////////////////////////////////////////////////////////////---- instruction_itself (32-1 DOWNTO 0) 		    
		
END Fecth_buffer;
ARCHITECTURE fect OF fecth_buffer IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1'   THEN
		q <= (OTHERS=>'0');
ELSIF rising_edge(Clk) THEN
		if disable='0' and zeros='0' then
		q <= d;
		end if;
		if zeros='1' then 
		q<=(OTHERS=>'0');
		end if;
END IF;
END PROCESS;
END fect;
