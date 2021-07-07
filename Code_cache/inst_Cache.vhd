LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
entity inst_mem is port 
(
clk,rst,C2,C4:std_logic;
two_bits:in std_logic_vector(2-1 downto 0);
data_in : IN std_logic_vector(128-1 DOWNTO 0);
Offset: in std_logic_vector (3-1 downto 0);
Index: in std_logic_vector(5-1 downto 0);
data_out:out std_logic_vector (32-1 downto 0)
);
end inst_mem;
architecture inst_mem_arch of inst_mem is
TYPE struct2 IS ARRAY(0 TO 31) of std_logic_vector(128-1 DOWNTO 0);
SIGNAL struct_main_memory2 : struct2 := (
OTHERS => X"00000000000000000000000000000000"
);
signal ahmed,ahmed2:std_logic_vector (128-1 downto 0);
signal int1,startaddress,endaddress:integer;
signal out_1,out_2:std_logic_vector (32-1 downto 0);
signal bit1: std_logic;
begin 
int1<= 0 when (to_integer(Unsigned(offset)))<0 
else (to_integer(Unsigned(offset))) ;
startaddress<=0 when int1=0 or (to_integer(Unsigned(offset)))=0
else 16  when int1=1
else 32 when  int1=2
else 48 when  int1=3
else 64 when  int1=4
else 80 when  int1=5
else 96 when  int1=6
else 112 when int1=7
else 0;
endaddress<=32-1 when int1=0 or (to_integer(Unsigned(offset)))=0
else 48-1 when int1=1
else 64-1 when int1=2
else 80-1 when int1=3
else 96-1 when int1=4
else 112-1 when int1=5
else 128-1 when int1=6
else 32; 
bit1<='1' when int1=7
else '0';
PROCESS(clk) IS
BEGIN
IF falling_edge(clk)  THEN

	if (C2='1' and ((two_bits="11") or (two_bits="10"))) Then
	struct_main_memory2(to_integer(Unsigned(Index))+1)<=data_in;
	elsif (c4='1')Then 
	struct_main_memory2(to_integer(Unsigned(index)))<= data_in;
end if;
end if;
END PROCESS;
ahmed<= struct_main_memory2(to_integer(Unsigned(Index)));
out_1<=   X"00000000" WHEN offset="111"
else struct_main_memory2(to_integer(Unsigned(Index))) ((to_integer(Unsigned(offset)))*16+32-1 downto (to_integer(Unsigned(offset)))*16)  ;
out_2(16-1 downto 0) <= X"0000" when bit1='1'
else out_1(16-1 downto 0) when rst='1'
else out_1(32-1 downto 16);
---
out_2(32-1 downto 16) <= ahmed(128-1 downto 112) when bit1='1'
else out_1(32-1 downto 16) when rst='1'
else out_1(15 downto 0);
data_out<=out_2;
end architecture;