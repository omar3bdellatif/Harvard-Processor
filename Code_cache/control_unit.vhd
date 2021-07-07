LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity control_unit is
port (
opcode: in std_logic_vector (5-1 downto 0);
control_signals :out std_logic_vector ( 33-1 downto 0)
);
end control_unit;
architecture controlling of control_unit is
begin
WITH opcode
select control_signals(31 downto 0)<=x"00000800" when "00000",
x"01000800" when "00001",
 x"00800800" when "00010",
 x"04004890" when "00011",
x"02004890" when "00100",
x"06004890" when "00101",
x"00000882" when "00110",
 x"00000811" when "00111" ,
 x"80010BF0" when "01000",
 x"08000910" when "01001",
x"08002850" when"01010",
x"0A000910" when "01011",
 x"0C000910" when"01100",
 x"0E000910" when"01101",
 x"10002060" when"01110",
 x"12002060" when"01111",
 x"40001888" when "10000",
 x"20001C14" when"10001",
x"20008C10" when"10010",
 x"20000C10" when"10011",
 x"40000840" when"10100",
 x"00500880" when"10101",
x"00600880" when"10110",
 x"00700880" when "10111",
x"00400880" when "11000",
 x"40081888" when"11001",
 x"20021804" when "11010",
 x"00040800" when "11011",
x"00000800" when others;
---------///--//////
-----------------------------------///////////////////////---------------/
WITH opcode
select control_signals(32)<='0' when "00000",
 '0'  when "00001",
'0' when "00010",
'1'  when "00011",
'1'  when "00100",
'1' when "00101",
 '0'  when "00110",
 '1' when "00111",
'1' when "01000",
 '1'  when "01001",
 '1'  when "01010",
 '1'  when "01011",
'1' when "01100",
 '1' when "01101",
'1'  when "01110",
'1'  when "01111",
'0'  when "10000",
 '1'  when "10001",
 '1' when "10010",
'1'  when "10011",
 '0' when "10100",
'0'  when  "10101",
 '0' when "10110",
'0' when "10111",
 '0'  when "11000",
 '0'  when "11001",
'0' when "11010",
'0' when "11011",
'0' when others;
end  controlling ;