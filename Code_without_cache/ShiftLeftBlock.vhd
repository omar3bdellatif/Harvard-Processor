library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ShiftLeftBlock is

	Port(Reg,Shift_Value:IN std_logic_vector (31 downto 0);
	Isleft: IN std_logic;
	output:Out std_logic_vector (31 downto 0);
	carryOut:OUT std_logic);

end Entity;



Architecture SHLArch of ShiftLeftBlock is
	signal accumLeft,accumRight: std_logic_vector(31 downto 0);
	signal carryoutLeft,carryoutRight: std_logic;
	
begin
accumLeft <= std_logic_vector(shift_left(unsigned(Reg), to_integer(unsigned(Shift_value)))); 
accumRight <= std_logic_vector(shift_right(unsigned(Reg), to_integer(unsigned(Shift_value))));
output<=accumLeft when Isleft='1'
else accumRight when Isleft='0';
carryOutLeft<='0' when Shift_value=x"00000000" or (to_integer(unsigned(Shift_value))) > 32 or (to_integer(unsigned(Shift_value))) =0 Or shift_value(31)='1'
else Reg(32-(to_integer(unsigned(Shift_value))));
carryOutRight<='0' when Shift_value=x"00000000" or (to_integer(unsigned(Shift_value))) > 32 or (to_integer(unsigned(Shift_value))) = 0 Or shift_value(31)='1'
else Reg((to_integer(unsigned(Shift_value)))-1);
carryOut<=carryoutLeft when Isleft='1'
else  carryoutRight when Isleft='0';

end SHLArch;
