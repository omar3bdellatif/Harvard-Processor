Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.numeric_std_unsigned.all;

ENTITY my_RTICounterA IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	RTI_Control_Signal_Decode,Call_Signal_EX,JMP_Signal_EX: IN std_logic;
	PC_FETCH_STOP3,RTI_Out: OUT std_logic
	
);
	
end my_RTICounterA;

ARCHITECTURE a_my_RTICounterA of my_RTICounterA IS
Signal count: std_logic_vector(2 downto 0);
Signal counting: std_logic;
Signal RTI_Out_sig: std_logic;

Begin

RTI_Out <= RTI_Out_sig;

Process(Clk)
--Variable counting: std_logic;
--Variable count: std_logic_vector(2 downto 0);
Begin
	if(Reset = '1') then
		PC_FETCH_STOP3 <= '0';
		RTI_Out_sig <= '0';
		count <= "010";
		counting <= '0';
	
	else
		if (falling_edge(Clk)) then
			if(RTI_Out_sig ='1') then
				RTI_Out_sig <='0';
			end if;
			if(RTI_Control_Signal_Decode = '1' and Call_Signal_EX = '0' and JMP_Signal_EX = '0' and counting = '0') then
				counting <= '1';
				count <= "010";
				PC_FETCH_STOP3 <= '1';
			end if;
			if(counting = '1') then
				count <= count - 1;
				if(count = "001") then
					RTI_Out_sig <= '1';
					count <= "010";
					counting <= '0';
					PC_FETCH_STOP3 <= '0';
				end if;
			end if;	
		end if;
	end if;
End Process;


end a_my_RTICounterA;
