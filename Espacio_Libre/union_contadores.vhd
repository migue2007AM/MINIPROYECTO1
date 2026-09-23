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
				decenas  : out integer range 0 to 9
				);
			
end entity;

architecture conteo of union_contadores is

		signal carry_uni : STD_LOGIC;
		signal carry_dec : STD_LOGIC;
		
		COMPONENT contador_individual is
		
			port(
					clk       : in STD_LOGIC;
					reset     : in STD_LOGIC;	-- '1' para activo, '0' para desactivado
					enable 	 : in STD_LOGIC;
			
					carry_out : out STD_LOGIC;	
					cuenta 	 : out integer range 0 to 9
					);
						
		end COMPONENT;
		
		begin
				U_UNIDADES : contador_individual 
					port map(
								clk 		 => clk,
								reset 	 => reset,
								enable 	 => enable,
								
								carry_out => carry_uni,
								cuenta    => unidades
								);
				
				U_DECIMAS : contador_individual
					port map(
								clk       => clk,
								reset 	 => reset,
								enable 	 => carry_uni,
								
								carry_out => open,
								cuenta 	 => decimas
								);
								
					
end conteo;


					