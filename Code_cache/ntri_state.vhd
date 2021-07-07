

Library ieee;
Use ieee.std_logic_1164.all;

Entity n_tri_state IS 
Generic(n: integer :=32);
port (Input :IN std_logic_vector (n-1 downto 0);
Output :Out std_logic_vector (n-1 downto 0);
En :IN std_Logic);  --hyb2a l out_ctrl
End Entity n_tri_state;


Architecture tristate1 of n_tri_state is 
Begin
Output <= Input when En ='1'
Else (Others => 'Z') ;
End Architecture tristate1;