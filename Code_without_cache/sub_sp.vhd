LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity sub_stack_pointer is port 
( sel :in std_logic ;
input : IN std_logic_vector(32-1 DOWNTO 0);
 output : OUT std_logic_vector(32-1 DOWNTO 0)
);
		
END sub_stack_pointer;
architecture sub_sp  of sub_stack_pointer is
component  my_nadder1 is
GENERIC (n : integer := 16);
PORT   (a, b : IN std_logic_vector(n-1 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(n-1 DOWNTO 0);
             cout : OUT std_logic);
END component my_nadder1;
signal input2,output2,input3: std_logic_vector (32-1 downto 0);
signal cout : std_logic;
begin
input2<=x"00000002";
input3<= not input2;
alu: my_nadder1 generic map(32) port map(input,input3,'1',output2,cout);
output<=output2 when sel='1'
else input when sel='0';
end sub_sp;
