Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.numeric_std_unsigned.all;

ENTITY my_RTICounterB IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	RTI_Signal: IN std_logic;
	PC_FETCH_STOP4,INC_1,c4,INC_2,c5: OUT std_logic
	
);
	
end my_RTICounterB;

ARCHITECTURE a_my_RTICounterB of my_RTICounterB IS
Signal count: std_logic_vector(2 downto 0);
Signal counting: std_logic;

Begin

Process(Clk,RTI_Signal)
--Variable counting: std_logic;
--Variable count: std_logic_vector(2 downto 0);
Begin
	if(Reset = '1') then
		PC_FETCH_STOP4 <= '0';
		INC_1 <= '0';
		INC_2<='0';
		c4<='0';
		c5<='0';
		count <= "100";
		counting <= '0';
	
	else
		if(rising_edge(RTI_Signal)) then
			counting <= '1';
			count <= "100";
			PC_FETCH_STOP4 <= '1';
			INC_1<='1';
		end if;
		if (falling_edge(Clk)) then
			if(counting = '1') then
				count <= count - 1;
				if(count = "100") then
					INC_1<='0';
					c4<='1';
				elsif(count = "011") then
					c4<='0';
					INC_2<='1';
				elsif(count = "010") then
					INC_2<='0';
					c5<='1';
				elsif(count = "001") then
					c5<='0';
					count <= "100";
					counting <= '0';
					PC_FETCH_STOP4 <= '0';
				end if;
			end if;	
		end if;
	end if;
End Process;


end a_my_RTICounterB;
