Library ieee;
Use ieee.std_logic_1164.all;

ENTITY MEM_WB_FORWARDDATA IS

--every input is taken from the mem/wb buffer
PORT(
	Reset: IN std_logic;
	Write_data1,Write_data2: IN std_logic_vector (31 DOWNTO 0);
	Forwarded_Output: OUT std_logic_vector (31 DOWNTO 0);
	ALU_OP: IN std_logic_vector (3 DOWNTO 0);
	In_ctrl,Swap_ctrl,Mem_read: IN std_logic;
	RS_ADDRESS_DEC_EX,RS1_ADDRESS_MEM_WB,RD_ADDRESS_MEM_WB: IN std_logic_vector (2 DOWNTO 0)
);
	
end MEM_WB_FORWARDDATA;


ARCHITECTURE a_MEM_WB_FORWARDDATA of MEM_WB_FORWARDDATA  IS
	SIGNAL Swap_replacement: std_logic_vector (31 DOWNTO 0);
  BEGIN

	Forwarded_Output <= X"00000000" WHEN Reset = '1'
	ELSE Write_data1 WHEN IN_ctrl = '1'
	ELSE Write_data1 WHEN ALU_Op /= "0000"
	ELSE Write_data1 WHEN Mem_read = '1'
	ELSE Swap_replacement WHEN Swap_ctrl = '1'
	else X"00000000";

	Swap_replacement <= Write_data2 WHEN RS_ADDRESS_DEC_EX = RS1_ADDRESS_MEM_WB
	ELSE Write_data1 WHEN RS_ADDRESS_DEC_EX = RD_ADDRESS_MEM_WB;
    
END a_MEM_WB_FORWARDDATA  ; 
