Library ieee;
Use ieee.std_logic_1164.all;

ENTITY my_CCR IS

PORT(
	Reset_enable: IN std_logic;
	Enable: IN std_logic;
	Jump_types: IN std_logic_vector(1 DOWNTO 0);
	Reset_all: IN std_logic;
	C,N,Z: IN std_logic;
	C_Out,N_Out,Z_Out: OUT std_logic;
	Clk: IN std_logic
);
	
end my_CCR;

ARCHITECTURE a_my_CCR OF my_CCR
IS 
BEGIN 

process (Clk,RESET_ALL)
begin

if(RESET_ALL = '1') then
	C_Out<='0';
	N_Out <= '0';
	Z_Out <= '0';

elsif falling_edge (Clk) then

	if (Reset_enable ='1' and Jump_types = "11") then
		C_Out <= '0';
	elsif (Enable = '1' and Reset_enable = '0') then
		C_Out <= C;
	end if;


	if (Reset_enable ='1' and Jump_types = "10") then
		N_Out <= '0';
	elsif (Enable = '1' and Reset_enable = '0') then
		N_Out <= N;
	end if;


	if (Reset_enable ='1' and Jump_types = "01") then
		Z_Out <= '0';
	elsif (Enable = '1' and Reset_enable = '0') then
		Z_Out <= Z;
	end if;
	
end if;

end process;
--C_Out <= '0' when RESET_ALL = '1'
--else '0' when (Reset_enable ='1' and Jump_types = "11")
--else C when (Enable = '1' and Reset_enable = '0');
--
--N_Out <= '0' when RESET_ALL = '1'
--else '0' when (Reset_enable ='1' and Jump_types = "10")
--else N when (Enable = '1' and Reset_enable = '0');
--
--Z_Out <= '0' when RESET_ALL = '1'
--else '0' when (Reset_enable ='1' and Jump_types = "01")
--else Z when (Enable = '1' and Reset_enable = '0');



END a_my_CCR;