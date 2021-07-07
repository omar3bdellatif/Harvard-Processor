LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY jump_register IS
PORT( Clk,Rst : IN std_logic;
		   d : IN std_logic;
		   q : OUT std_logic);
		
END jump_register;
ARCHITECTURE a_my_reg OF jump_register IS
BEGIN
PROCESS (Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <= '0';
ELSIF falling_edge(Clk) THEN
		q <= d;
END IF;
END PROCESS;
END a_my_reg;

