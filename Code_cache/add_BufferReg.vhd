LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity add_Buffer is port 
( pc:in std_logic_vector (32-1 downto 0);
opcode:in std_logic_vector (4 downto 0);
pc_plus_one:out std_logic_vector (32-1 downto 0)
);
end entity add_buffer;
architecture add_buffer1 of add_buffer is
component  my_nadder1 is
GENERIC (n : integer := 16);
PORT   (a, b : IN std_logic_vector(n-1 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(n-1 DOWNTO 0);
             cout : OUT std_logic);
END component my_nadder1;
signal cout: std_logic ;
signal add_value: std_logic_vector (32-1 downto 0);
signal control:std_logic;
begin
alu: my_nadder1 generic map(32) port map(pc,add_value,'0',pc_plus_one,cout);

WITH opcode 	
SELECT control <= '1' WHEN "01010",
'1'  WHEN "01110",
'1' WHEN "01111",
'1'  WHEN "10010",
'1'  WHEN "10011",
'1'  WHEN "10100",
      '0' WHEN OTHERS;

add_value<=x"00000002" when control='1'
else x"00000001" when control='0';
end architecture add_buffer1;

