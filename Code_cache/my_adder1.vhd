LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY my_adder1 IS
	PORT (a,b,cin : IN  std_logic;
		  s, cout : OUT std_logic );
END my_adder1;

ARCHITECTURE a_my_adder1 OF my_adder1 IS
	BEGIN
		
				s <= a XOR b XOR cin;
				cout <= (a AND b) OR (cin AND (a XOR b));
		
END a_my_adder1;