LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY ram IS
Generic(n: integer :=32 ; m: integer:=16);
 PORT (
	rst,Clk,c2:in std_logic;	 
	address : IN std_logic_vector(n-1 DOWNTO 0);
	 dataout : OUT std_logic_vector(n-1 DOWNTO 0) );
END ENTITY ram;
ARCHITECTURE sync_ram_a OF ram IS  
  TYPE ram_type IS ARRAY(0 TO (2**11)-1 ) of std_logic_vector(m-1 DOWNTO 0);
SIGNAL ram : ram_type := (
0 => X"3A00",
1 => X"3B00",
2=>X"3C00",
3=>X"9100",
4=>X"00F5",
5=>X"8100",
6=>X"8200",
7=>X"8900",
8=>X"8A00",
9=>X"A040",
10=>X"00C8",
11=>X"A020",
12=>X"00CA",
13=>X"9B00",
14=>X"00CA",
15=>X"9C00",
16=>X"00C8",
17=>X"0000",
18=>X"0000",
30=>x"9300",
31=>x"002B",
32=>x"4300",
33=>x"4C0C",
34=>x"5810",
35=>x"8100",
36=>x"8A00",
37=>x"4C0C",
38=>x"8200",
39=>x"9840",
40=>x"8200",
41=>x"8E00",
42=>x"D000",
252=>x"0800",
253=>x"D800",
OTHERS => X"2000"
); 
signal int1,int2: integer;
BEGIN
int1<=33;
int2<=32;
dataout(16-1 downto 0) <= ram(to_integer(Unsigned(Address))) when rst='1'
else ram(2) when c2='1'
else ram(to_integer(Unsigned(Address))+1);
dataout(32-1 downto 16) <= ram(to_integer(Unsigned(Address))+1) when rst='1'
else ram(3) when c2='1'
else ram(to_integer(Unsigned(Address)));

END sync_ram_a;

