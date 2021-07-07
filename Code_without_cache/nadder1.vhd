LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity my_nadder1 is
GENERIC (n : integer := 16);
PORT   (a, b : IN std_logic_vector(n-1 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(n-1 DOWNTO 0);
             cout : OUT std_logic);
END my_nadder1;


ARCHITECTURE a_my_nadder1 OF my_nadder1 IS
	component my_adder1 is 
	  port (a,b,cin : IN std_logic; s,cout:OUT std_logic );
		end component;
		signal temp: std_logic_vector( n-1 downto 0);
		begin  
		  f0: my_adder1 port map (a(0),b(0),cin,s(0),temp(0));
		    loop1: for i in 1 to n-1 generate
		      fx:my_adder1 port map (a(i),b(i),temp(i-1),s(i),temp(i)); 
		 end generate ;
		 cout <= temp(n-1);
						
END a_my_nadder1;