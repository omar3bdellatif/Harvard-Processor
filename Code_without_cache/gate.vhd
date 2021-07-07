

Library ieee;
use ieee.std_logic_1164.all;

entity gate is --fe 7alet ana msh m7tag 4 input h7ot input menhom b zero mslan 

port(
a : in std_logic;
b : in std_logic;
c : in std_logic;
d : in std_logic;
output: out std_logic);

end entity gate;

Architecture o1 of gate is
begin
output <= a or b or c or d;
end o1;