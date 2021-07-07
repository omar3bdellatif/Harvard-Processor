LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY main_memory IS
PORT 
(
	clk : IN std_logic;
        rst,c1,c2,c1_inst,c3_inst: IN std_logic;
	index:in std_logic_vector (5-1 downto 0);
	Tag:in std_logic_vector (3-1 downto 0);
	datain : in std_logic_vector(128-1 DOWNTO 0);
	Address:in std_logic_vector(11-1 downto 0);
	data_32_out:out std_logic_vector(16-1 downto 0); 
	dataout : OUT std_logic_vector(128-1 DOWNTO 0)  
);
END  main_memory;

ARCHITECTURE struct_main_memory OF main_memory IS
TYPE struct1 IS ARRAY(0 TO (2**11)-1) of std_logic_vector(15 DOWNTO 0);
SIGNAL struct_main_memory : struct1 := (
0 => X"0010",
1 => X"0000", 
2 => X"00FC", ---INTERUPT LOCATION
3=> X"0000", ----INTERUPT LOCATION
4=> X"FFFF",
7=>X"90BA",
9=>X"00EE",
10=>X"00EF",
26=>X"00AE",
27=>X"0000",
32=>X"0000",
33=>X"0000",
OTHERS => X"0001"
);
signal index_int,start_address,n,index_int_1,start_address_1: integer ;
BEGIN
index_int<=0 when index="00000"
else 8 when index="00001"
else 8*2 when index="00010"
else 8*3 when index="00011"
else 8*4 when index="00100"
else 8*5 when index="00101"
else 8*6 when index="00110"
else 8*7 when index="00111"
else 8*8 when index="01000"
else 8*9 when index="01001"
else 8*10 when index="01010"
else 8*11 when index="01011"
else 8*12 when index="01100"
else 8*13 when index="01101"
else 8*14 when index="01110"
else 8*15 when index="01111"
else 8*16 when index="10000"
else 8*17 when index="10001"
else 8*18 when index="10010"
else 8*19 when index="10011"
else 8*20 when index="10100"
else 8*21 when index="10101"
else 8*22 when index="10110"
else 8*23 when index="10111"
else 8*24 when index="11000"
else 8*25 when index="11001"
else 8*26 when index="11010"
else 8*27 when index="11011"
else 8*28 when index="11100"
else 8*29 when index="11101"
else 8*30 when index="11110"
else 8*31 when index="11111";
index_int_1<=index_int+8;

start_address<=(index_int+(to_integer(Unsigned(Tag)))*255) when Tag="000"
else index_int+(to_integer(Unsigned(Tag)))*256;
start_address_1<=start_address+8;
PROCESS(clk) IS
BEGIN
IF falling_edge(clk)  THEN
	if(c1_inst='1' ) then
	dataout(16-1 downto 0) <= struct_main_memory (start_address_1) ;
	dataout(32-1 downto 16) <= struct_main_memory (start_address_1+1);
	dataout(48-1 downto 32) <= struct_main_memory ((start_address_1+2));
	dataout(64-1 downto 48) <= struct_main_memory (start_address_1+3) ;
	dataout(80-1 downto 64) <= struct_main_memory (start_address_1+4);
	dataout(96-1 downto 80) <= struct_main_memory (start_address_1+5);
	dataout(112-1 downto 96) <= struct_main_memory (start_address_1+6);
	dataout(128-1 downto 112) <= struct_main_memory (start_address_1+7) ;
	elsif(c3_inst='1' ) then
	dataout(16-1 downto 0) <= struct_main_memory (start_address) ;
	dataout(32-1 downto 16) <= struct_main_memory (start_address+1);
	dataout(48-1 downto 32) <= struct_main_memory ((start_address+2));
	dataout(64-1 downto 48) <= struct_main_memory (start_address+3) ;
	dataout(80-1 downto 64) <= struct_main_memory (start_address+4);
	dataout(96-1 downto 80) <= struct_main_memory (start_address+5);
	dataout(112-1 downto 96) <= struct_main_memory (start_address+6);
	dataout(128-1 downto 112) <= struct_main_memory (start_address+7) ;
	elsIF (c1='1') Then
	struct_main_memory (start_address) <= datain(16-1 downto 0);
	struct_main_memory (start_address+1) <= datain(32-1 downto 16);
	struct_main_memory ((start_address+2)) <= datain(48-1 downto 32);
	struct_main_memory (start_address+3) <= datain(64-1 downto 48);
	struct_main_memory (start_address+4) <= datain(80-1 downto 64);
	struct_main_memory (start_address+5) <= datain(96-1 downto 80);
	struct_main_memory (start_address+6) <= datain(112-1 downto 96);
	struct_main_memory (start_address+7) <= datain(128-1 downto 112);
	elsif (c2='1') then
	dataout(16-1 downto 0) <= struct_main_memory (start_address) ;
	dataout(32-1 downto 16) <= struct_main_memory (start_address+1);
	dataout(48-1 downto 32) <= struct_main_memory ((start_address+2));
	dataout(64-1 downto 48) <= struct_main_memory (start_address+3) ;
	dataout(80-1 downto 64) <= struct_main_memory (start_address+4);
	dataout(96-1 downto 80) <= struct_main_memory (start_address+5);
	dataout(112-1 downto 96) <= struct_main_memory (start_address+6);
	dataout(128-1 downto 112) <= struct_main_memory (start_address+7) ;
	
End if;
END IF;
END PROCESS;
data_32_out(15 downto 0) <= struct_main_memory (to_integer(Unsigned(address)));	
END struct_main_memory; 
