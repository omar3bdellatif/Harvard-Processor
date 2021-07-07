LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
entity Transfer_address is
port (
address:in std_logic_vector(32-1 downto 0);
Offset: out std_logic_vector (3-1 downto 0);
Index: out std_logic_vector(5-1 downto 0);
Tag: out std_logic_vector (3-1 downto 0)
);
end Transfer_address;
architecture Transfer_trans of Transfer_address is
begin
Offset<=address(3-1 downto 0);
Index<= address(8-1 downto 3);
Tag<= address (11-1 downto 8);
end Transfer_trans ;