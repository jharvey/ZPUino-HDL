---------------------------------------------------------------------
--	Filename:	gh_fasm.vhd
--
--			
--	Description:
--		FASM (FPGA and ASIC Subset Model)
--		Synchronous write port, Asynchronous read
--              
--	Copyright (c) 2005, 2008 by George Huber 
--		an OpenCores.org Project
--		free to use, but see documentation for conditions 								 
--
--	Revision	History:
--	Revision	Date      	Author   	Comment
--	--------	----------	---------	-----------
--	1.0     	11/13/05  	S A Dodd 	Initial revision
--	1.1     	09/20/08  	hlefevre 	add simulation init
--	        	          	          	  (to '0') to ram data 
--	
--------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

entity gh_fasm is
	GENERIC (size_add: INTEGER :=10 ;
	         size_data: INTEGER :=32 );
	port (					
		clk  : in STD_LOGIC;
		WE   : in STD_LOGIC;
		add  : in STD_LOGIC_VECTOR(size_add-1 downto 0);
		D    : in STD_LOGIC_VECTOR (size_data-1 downto 0);
		Q    : out STD_LOGIC_VECTOR (size_data-1 downto 0));
end entity;

architecture a of gh_fasm is

	type ram_mem_type is array ((2**size_add-1) downto 0) 
	        of STD_LOGIC_VECTOR (size_data-1 downto 0);
	signal ram_mem : ram_mem_type := (others => (others => '0')); 

begin

process (clk)
begin
	if (rising_edge(clk)) then
		if (WE = '1') then
			ram_mem(CONV_INTEGER(add)) <= D;
		end if;
	end if;		
end process;

	Q <= ram_mem(CONV_INTEGER(add));
	
end architecture;
