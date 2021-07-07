LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY program_counter_cache IS
PORT( Clk,Rst,disable,priority : IN std_logic;
		   d : IN std_logic_vector(32-1 DOWNTO 0);
		   request_read:in std_logic;		
		   q : OUT std_logic_vector(32-1 DOWNTO 0);
                   request_read_out:out std_logic
);
		
END program_counter_cache;
ARCHITECTURE pc_cache OF program_counter_cache IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <= (OTHERS=>'0');
		request_read_out<='1';
ELSIF rising_edge(Clk) THEN
		if disable='0' or priority='1' then
		q <= d;
		request_read_out<='1';
		elsif disable='1' and priority ='0' then
		request_read_out<='0';
		end if;
END IF;
END PROCESS;
END pc_cache;
