LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity stack_pointer_register is port 
( Clk,Rst : IN std_logic;
		   d : IN std_logic_vector(32-1 DOWNTO 0);
		   q : OUT std_logic_vector(32-1 DOWNTO 0));
		
END stack_pointer_register;
ARCHITECTURE sp OF stack_pointer_register IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <=x"000007FF";
ELSIF rising_edge(Clk) THEN
		q <= d;
END IF;
END PROCESS;
END sp;
