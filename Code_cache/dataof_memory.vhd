

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY storage IS
PORT 
(
	clk : IN std_logic;
        rst: IN std_logic;  --lsa hnshof n3mlha wla eh
	write_en : IN std_logic;
        read_en : IN std_logic;
	Stackop:in std_logic;
	address : IN std_logic_vector(31 DOWNTO 0);
	datain : IN std_logic_vector(31 DOWNTO 0);
	LDM:in std_logic;
	dataout : OUT std_logic_vector(31 DOWNTO 0)
          
);
END  storage;

ARCHITECTURE struct OF storage IS
TYPE struct IS ARRAY(0 TO (2**11)-1) of std_logic_vector(15 DOWNTO 0);
SIGNAL store : struct := (
0 => X"00C3",
1 => X"0038", 
2 => X"00FC", ---INTERUPT LOCATION
3=> X"0000", ----INTERUPT LOCATION
4=> X"FFFF",
7=>X"00BA",
9=>X"00EE",
10=>X"00EF",
26=>X"00AE",
27=>X"0000",
32=>X"0000",
33=>X"0000",
OTHERS => X"0001"
);
BEGIN
PROCESS(clk) IS
BEGIN
IF rst = '1' THEN
		dataout <= (OTHERS=>'0');
end if;
IF falling_edge(clk) and to_integer(Unsigned(Address)) <65536 THEN
	IF write_en = '1' and stackop='0'   THEN
	store(to_integer(Unsigned(address))) <= datain(15 downto 0);
        store(to_integer(Unsigned(address))+1) <= datain(32-1 downto 16);
	elsif write_en = '1' and stackop='1' THEN
	store(to_integer(Unsigned(address))-1) <= datain(15 downto 0);
        store(to_integer(Unsigned(address))) <= datain(32-1 downto 16);
	end if;
        IF read_en ='1' and stackop='0' and LDM='0' THEN
                dataout(15 downto 0) <= store(to_integer(Unsigned(address)));
                dataout(31 downto 16) <= store(to_integer(Unsigned(address))+1);
	elsif read_en ='1' and stackop='1' AND LDM='0' THEN
		dataout(15 downto 0) <= store(to_integer(Unsigned(address))-1);
                dataout(31 downto 16) <= store(to_integer(Unsigned(address)));
	elsif  read_en ='1' and stackop='0' AND LDM='1' THEN
		dataout<=address;
	END IF;
END IF;

END PROCESS;
	
END struct; 
