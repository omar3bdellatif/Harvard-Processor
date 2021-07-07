LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity mux32_decode is 
GENERIC (m : integer := 32);
port
(
input0,input1: IN STD_LOGIC_VECTOR(m-1 downto 0);
SEL:IN std_logic;
output:out std_logic_vector (m-1 downto 0)
);
End entity mux32_decode;
architecture muxing of mux32_decode is
begin
output<= input1 when SEL='1'
else input0 when SEL='0';
end muxing;

