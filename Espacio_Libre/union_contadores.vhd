LIBRARY IEEE;

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity union_contadores is

		port(
				clk      : in STD_LOGIC;
				reset    : in STD_LOGIC;
				enable   : in STD_LOGIC;
				
				unidades : out integer range 0 to 9;
				decenas  : out integer range 0 to 9;
				centenas : out integer range 0 to 9;
				miles 	: out integer range 0 to 9
				);
			
end entity;

architecture conteo of union_contadores is

		signal uni : integer range 0 to 9;
		signal dec : integer range 0 to 9;
		signal cen : integer range 0 to 9;
		signal mil : integer range 0 to 9;
		
		begin
				process(clk,reset)
				
				begin
					