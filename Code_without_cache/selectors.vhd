

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY general_maux IS 
	Generic ( n : Integer:=32);
	PORT ( in0,in1 : IN std_logic_vector (n-1 DOWNTO 0);
			sel : IN  std_logic;
			output : OUT std_logic_vector (n-1 DOWNTO 0));
END general_maux;


ARCHITECTURE generic_mux OF general_maux is
	BEGIN
		
  output <= 	in0 when sel = '0'
	else	in1 when sel = '1';
	
END generic_mux;