LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity my_nadder is
--default value of n is defined 8
--generic (n:integer:=8); 
Port (a,b: In std_logic_vector(31 downto 0);
	cin:In std_logic;
	F:out std_logic_vector(31 downto 0);
	cout: out std_logic);
End my_nadder;

Architecture a_my_nadder of my_nadder is
	component my_adder is
		Port(a,b,cin:in std_logic;s,cout:out std_logic);
	End component;
	signal temp: std_logic_vector(31 Downto 0);
Begin
f0:my_adder Port Map(a(0),b(0),cin,f(0),temp(0));
loop1: For i in 1 to 31 generate
	fz:my_adder Port Map(a(i),b(i),temp(i-1),f(i),temp(i));
End Generate;
cout<=temp(31);
end a_my_nadder;