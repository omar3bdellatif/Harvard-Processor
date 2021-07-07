LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY mux_reg_file_input IS
port(	
Write_data1,Write_data2:in std_logic_vector (32-1 downto 0);
REG_Write1,Reg_write2:in std_logic ;
input_reg :out std_logic_vector(32-1 downto 0)
);
end mux_reg_file_input;
ARCHITECTURE arch11 OF mux_reg_file_input IS
begin 
input_reg<= write_data1 when Reg_write1='1'
else write_data2 when reg_write2='1';
end arch11;
