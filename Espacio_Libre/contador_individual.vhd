LIBRARY IEEE;

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_individual is
	port(
			
			clk       : in STD_LOGIC;
			reset     : in STD_LOGIC;				-- '1' para activo, '0' para desactivado
			enable 	 : in STD_LOGIC;
				
			carry_out : out STD_LOGIC;
			cuenta 	 : out integer range 0 to 9
			);
			
end entity;

architecture behavorial of contador_individual is 

			signal cuenta_s : integer range 0 to 9 := 0;
			
		begin
			
			process(clk, reset)
			
				begin
			
					if reset = '1' then
						cuenta_s <= 0;
					
					elsif rising_edge(clk) and enable = '1' then
						
						if cuenta_s = 9 then
							cuenta_s <= 0;
						
						else 
							cuenta_s <= cuenta_s + 1;
						
						end if;
					
					end if;
				
			 end process;
			 
		 carry_out <= '1' when(cuenta_s = 9 and enable = '1') else '0';
		 cuenta    <= cuenta_s;
	
end behavorial;


			
			
			