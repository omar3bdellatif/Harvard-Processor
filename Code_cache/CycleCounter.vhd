Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.numeric_std_unsigned.all;

ENTITY my_Counter IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Stalling_Inputs: IN std_logic;
	Interrupt: IN std_logic;
	Interrupt_Out: OUT std_logic;
	PC_FETCH_STOP1: OUT std_logic
	
);
	
end my_Counter;

ARCHITECTURE a_my_Counter of my_Counter IS

SIGNAL count : std_logic_vector(3 downto 0);
Signal counting: std_logic;
Signal counter_out: std_logic;


BEGIN

Interrupt_Out <= counter_out;


PROCESS (Clk,Interrupt)
variable flag: std_logic;
Begin

	if(Reset = '1') then
		counter_out<='0';
		PC_FETCH_STOP1 <= '0';
		counting <= '0';
		count <= "0100";
		flag := '0';
		report "reset was equal to 1";

	else
	
		if rising_edge(Interrupt) then
			counting <= '1';
			count <= "0100";
		end if;
		
		if falling_edge(Clk) then
				
			if(Stalling_Inputs = '1' and counting = '1') then
				--count <= count + 1;
				flag :='1';
			report "inc";
			end if;
		
			if(counting = '0' and counter_out = '1') then
				 counter_out <= '0'; 
			report "x";
			end if;
		
		
			if (counting = '1') then
				report "y";
				if (falling_edge(Clk) and flag = '0') then
					report "z";
					count <= count - 1;
					if(count = "0100") then
						report "w";
						PC_FETCH_STOP1 <= '1';
					elsif(count = "0001") then
						report "u";
						counting <= '0';
						PC_FETCH_STOP1 <= '0';
						counter_out <= '1';
						count <= "0100";
						
					end if;
				end if;
				if (flag = '1') then
					flag := '0';
				end if;
			end if;
			
		end if;


	end if;
	
	
	

End Process;

END a_my_Counter;