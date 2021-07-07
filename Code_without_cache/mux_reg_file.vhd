LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity mux_reg_file is port 
(r0,r1,r2,r3,r4,r5,r6,r7 : IN std_logic_vector (32-1 downto 0);
SEL:in std_logic_vector (2 downto 0);
output: OUT STD_LOGIC_vector (32-1 downto 0)
);
end mux_reg_file;
ARCHITECTURE mux_reg OF mux_reg_file IS
begin 
output<=r0 when sel="000" 
else r1    when sel="001"  
else r2    when sel="010"
else r3    when sel="011"
else r4    when sel="100" 
else r5    when sel="101" 
else r6    when sel="110" 
else r7    when sel="111";  
end mux_reg;

