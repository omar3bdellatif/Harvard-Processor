Library ieee;
Use ieee.std_logic_1164.all;

ENTITY EX_MEM_FORWARDDATA IS

--every input is taken from the ex/mem buffer,except for mem_data which is from mem/wb buffer
PORT(
	Reset: IN std_logic;
	Out_ALU,IN_Port,Read_data1,Read_data3: IN std_logic_vector (31 DOWNTO 0);
	Forwarded_Output: OUT std_logic_vector (31 DOWNTO 0);
	ALU_OP:IN std_logic_vector (3 DOWNTO 0);
	In_ctrl,Swap_ctrl: IN std_logic;
	RS_ADDRESS_DEC_EX,RS1_ADDRESS_EX_MEM,RD_ADDRESS_EX_MEM: IN std_logic_vector (2 DOWNTO 0)
);
	
end EX_MEM_FORWARDDATA;


ARCHITECTURE a_EX_MEM_FORWARDDATA of EX_MEM_FORWARDDATA  IS
	SIGNAL Swap_replacement: std_logic_vector (31 DOWNTO 0);
  BEGIN

	Forwarded_Output <= X"00000000" WHEN Reset = '1'
	ELSE IN_PORT WHEN IN_ctrl = '1'
	ELSE Out_ALU WHEN ALU_Op /= "0000"
	ELSE Swap_replacement WHEN Swap_ctrl = '1'
	else X"00000000";
	Swap_replacement <= Read_data3 WHEN RS_ADDRESS_DEC_EX = RS1_ADDRESS_EX_MEM
	ELSE Read_data1 WHEN RS_ADDRESS_DEC_EX = RD_ADDRESS_EX_MEM;
    
END a_EX_MEM_FORWARDDATA  ; 
