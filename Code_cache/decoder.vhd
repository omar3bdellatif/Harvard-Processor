LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity decoder is port 
(SEL : IN std_logic_vector (2 downto 0);
Enable: in std_logic;
output: OUT STD_LOGIC_vector (7 downto 0)
);
end decoder;
ARCHITECTURE deco OF decoder IS
begin 
output<="00000000" when Enable='0'
else "00000001" when SEL="000"   
else "00000010" when SEL="001" 
else "00000100" when SEL="010" 
else "00001000" when SEL="011"   
else "00010000" when SEL="100"   
else "00100000" when SEL="101"   
else "01000000" when SEL="110"   
else "10000000" when SEL="111" ;  
end deco;

