LIBRARY IEEE;

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity union_contadores is

		port(
				numero_entrada : IN integer range 0 to 99;
				
				unidades 		: out integer range 0 to 9;
				decenas  		: out integer range 0 to 9
				);
			
end entity;

architecture conteo of union_contadores is

begin
		decenas <= numero_entrada / 10;
		
		unidades <= numero_entrada mod 10;							
					
end conteo;


					