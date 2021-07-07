Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.numeric_std_unsigned.all;

ENTITY my_cacheCounter IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Trigger: IN std_logic;
	out1,out2,out3,out4: OUT std_logic
	
);
	
end my_cacheCounter;

ARCHITECTURE a_my_cacheCounter of my_cacheCounter IS

SIGNAL count : std_logic_vector(2 downto 0);
Signal counting: std_logic;

BEGIN

PROCESS(Clk,Reset)

Begin

	if(Reset = '1') then

		out1<='0';
		out2<='0';
		out3<='0';
		out4<='0';
		count <="100";
		counting <= '0';
	elsif(falling_edge(Clk)) then
		if((Trigger ='1' or rising_edge(Trigger)) and counting /= '1') then
			counting <='1';
			out1<= '1';
			count <="100";

		elsif(counting ='1' and count ="100") then
			out1<='0';
			out2<='1';
			count <= count - 1;
		elsif(counting ='1' and count = "011") then
			out2<='0';
			out3<='1';
			count <= count - 1;
		elsif(counting ='1' and count = "010") then
			out3<='0';
			out4<='1';
			count <= count - 1;
		elsif(counting ='1' and count = "001") then
			out4<='0';
			counting <='0';
			count <= "100";
		end if;

	end if;

End Process;


END a_my_cacheCounter;
