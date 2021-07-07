LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
entity sign_extent is
GENERIC (n : integer := 16);
PORT   (a:in std_logic_vector (n-1 DOWNTO 0); 
             s : OUT std_logic_vector(32-1 DOWNTO 0)
);
END sign_extent;
ARCHitecture sign of sign_extent is
begin
    loop1: for i in 0 to n-1 generate
		       s(i)<=a(i);
		 end generate ;
 loopk: for i in n to 32-1 generate
		       s(i)<='0';
		 end generate ;

end sign;