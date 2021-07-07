Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.numeric_std_unsigned.all;

ENTITY my_InterruptCounterB IS

PORT(
	
	Reset: IN std_logic;
	Clk: IN std_logic;
	Interrupt: IN std_logic;
	PC_FETCH_STOP2,c1,c2,c3,dec: OUT std_logic
	
);
	
end my_InterruptCounterB ;

ARCHITECTURE a_my_InterruptCounterB of my_InterruptCounterB IS

SIGNAL count : std_logic_vector(3 downto 0);
Signal counting: std_logic;



BEGIN




PROCESS (Clk,Interrupt)

Begin

	if(Reset = '1') then
		c1<='0';
		c2<='0';
		c3<='0';
		dec<='0';
		PC_FETCH_STOP2 <= '0';
		counting <= '0';
		count <= "0100";
		report "reset was equal to 1";

	else
	
		if rising_edge(Interrupt) then
			counting <= '1';
			count <= "0100";
			c1<='1';
			PC_FETCH_STOP2 <= '1';
		end if;
		
		if falling_edge(Clk) then
			if (counting = '1') then
				report "y";
				count <= count - 1;
				if(count = "0100") then
					report "w";
					c1<='0';
					dec <='1';
				elsif(count = "0011") then
					dec<='0';
					c2 <='1';
				elsif(count = "0010") then
					c2<='0';
					c3 <='1';
				elsif(count = "0001") then
					report "u";
					counting <= '0';
					c3 <='0';
					count <= "0100";
					PC_FETCH_STOP2 <= '0';
				end if;
			end if;
		end if;
	end if;
	
End Process;

END a_my_InterruptCounterB;
