Library ieee;
Use ieee.std_logic_1164.all;
entity jump_mux is port
(
jump_signal,Z_Flag,N_Flag,C_Flag: in std_logic;
Jump_type:in std_logic_vector (2-1 downto 0);
jump_Destination:out std_logic
);
end jump_mux;
architecture jump_mux11 of jump_mux is 
signal out_and0,out_and1,out_and2,out_and3: std_logic;
begin
out_and0<=jump_signal and jump_signal;
out_and1<=jump_signal and Z_Flag;
out_and2<=jump_signal and N_Flag;
out_and3<=jump_signal and C_Flag;
jump_Destination<=out_and0  when jump_type="00"
else out_and1 when jump_type="01"
else out_and2 when jump_type="10"
else out_and3 when jump_type="11";
end architecture jump_mux11;
