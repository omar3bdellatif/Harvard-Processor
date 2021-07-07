LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
entity cache_mem is port 
(
clk,rst,c3,hit,c4:std_logic;
write_en : IN std_logic;
read_en : IN std_logic;
Stackop:in std_logic;
data_in : IN std_logic_vector(128-1 DOWNTO 0);
data_processor,Address:in std_logic_vector(32-1 downto 0);
LDM:in std_logic;
Offset: in std_logic_vector (3-1 downto 0);
Index: in std_logic_vector(5-1 downto 0);
data_out:out std_logic_vector (32-1 downto 0);
data_128_out:out std_logic_vector(128-1 downto 0)
);
end cache_mem;
architecture cache_cache of cache_mem is 

TYPE struct2 IS ARRAY(0 TO 31) of std_logic_vector(128-1 DOWNTO 0);
SIGNAL struct_main_memory2 : struct2 := (
OTHERS => X"00000000000000000000000000000000"
);
signal ahmed,ahmed2:std_logic_vector (128-1 downto 0);
signal int1,startaddress,endaddress:integer;
begin
int1<=(to_integer(Unsigned(offset))-1)when stackop='1'
else (to_integer(Unsigned(offset)));

startaddress<=0 when int1=0
else 32 when int1=2
else 64 when int1=4
else 96 when int1=6;
endaddress<=32-1 when int1=0
else 64-1 when int1=2
else 96-1 when int1=4
else 128-1 when int1=6;
PROCESS(clk) IS
BEGIN
IF falling_edge(clk)  THEN

	if (c3='1') Then
	struct_main_memory2(to_integer(Unsigned(Index)))<=data_in;
	elsif (c4='1'and write_en = '1')Then 
	struct_main_memory2(to_integer(Unsigned(index)))( endaddress downto startaddress)<= data_processor;
	elsIF (write_en = '1' and hit='1' and stackop='0'  )   THEN
	struct_main_memory2(to_integer(Unsigned(index)))( endaddress downto startaddress)<= data_processor;
	elsif (write_en = '1' and stackop='1' and hit ='1' ) THEN
	struct_main_memory2(to_integer(Unsigned(index)))( endaddress downto startaddress)<= data_processor;
end if;
end if;
END PROCESS;
ahmed<= struct_main_memory2(to_integer(Unsigned(Index)));
data_out<=ahmed(((to_integer(Unsigned(offset)))-1)*16+32-1 downto ((to_integer(Unsigned(offset))-1))*16 ) when (stackop='1' and (to_integer(Unsigned(offset))/=0) and read_en='1' and LDM='0') 
else ahmed((to_integer(Unsigned(offset)))*16+32-1 downto (to_integer(Unsigned(offset)))*16 )when (LDM='0' and read_en ='1')
else Address when LDM='1';
data_128_out<=ahmed;
end cache_cache;

