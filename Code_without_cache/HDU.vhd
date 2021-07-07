Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity HDU is
	Port( ID_EX_MemRead,ID_EX_RegWrite:IN std_logic;
	Source_ctrl:IN std_logic_vector (2 downto 0);
	IF_ID_Rs1, IF_ID_Rs2, IF_ID_RD_Addr, ID_EX_RD_Addr :IN std_logic_vector (2 downto 0);
	hdu_out:OUT std_logic);
--hdu_out is one bit that takes place of any 3 bit output
end HDU;

Architecture HDUArch of HDU is
Begin
	hdu_out<='1' when ID_EX_MemRead='1' and ID_EX_RegWrite='1' and Source_ctrl="001" 
		and IF_ID_Rs1 = ID_EX_RD_Addr
	else '1' when ID_EX_MemRead='1' and ID_EX_RegWrite='1' and Source_ctrl="010" 
		and IF_ID_RD_Addr = ID_EX_RD_Addr
	else '1' when ID_EX_MemRead='1' and ID_EX_RegWrite='1' and Source_ctrl="100" 
		and (IF_ID_Rs1 = ID_EX_RD_Addr or IF_ID_Rs2 = ID_EX_RD_Addr)
	else '1' when ID_EX_MemRead='1' and ID_EX_RegWrite='1' and Source_ctrl="111" 
		and (IF_ID_Rs1 = ID_EX_RD_Addr or IF_ID_RD_Addr = ID_EX_RD_Addr)
	else '0';
	--else "000" when Source_ctrl="000" or ID_EX_MemRead='0' or ID_EX_RegWrite='0'
	--else "000" when ID_EX_MemRead='1' and ID_EX_RegWrite='1' and Source_ctrl="001" 
	--	and IF_ID_Rs1 /= ID_EX_RD_Addr
	--else "000" when ID_EX_MemRead='1' and ID_EX_RegWrite='1' and Source_ctrl="010" 
	--	and IF_ID_RD_Addr /= ID_EX_RD_Addr
	--else "000" when ID_EX_MemRead='1' and ID_EX_RegWrite='1' and Source_ctrl="100" 
	--	and (IF_ID_Rs1 = ID_EX_RD_Addr nor IF_ID_Rs2 = ID_EX_RD_Addr)
end HDUArch;