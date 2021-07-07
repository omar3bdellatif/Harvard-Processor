LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY program_counter IS
PORT( Clk,Rst,disable,priority,delay : IN std_logic;
		   d : IN std_logic_vector(32-1 DOWNTO 0);
		   q : OUT std_logic_vector(32-1 DOWNTO 0));
		
END program_counter;
ARCHITECTURE pc OF program_counter IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1'  THEN
		q <= (OTHERS=>'0');
IF  delay ='1' THEN
		q <= d;
end if;
ELSIF rising_edge(Clk) THEN
		if disable='0' or priority='1' then
		q <= d;
		end if;
END IF;
END PROCESS;
END pc;
