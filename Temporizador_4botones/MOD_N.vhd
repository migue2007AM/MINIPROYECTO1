LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MOD_N IS
		GENERIC(
					limit : INTEGER := 9 -- esta entrada recibe el limite de conteo que se quiere dependiendo la situacion
				);
				
		PORT(
				clk      	 	 : IN STD_LOGIC; -- esta entrada recibe la señal de reloj del divisor de frecuencia
				reset    		 : IN STD_LOGIC; -- esta entrada si es '1' el sistema se reinicia, en '0' no se reinicia
				enable   		 : IN STD_LOGIC; -- esta entrada se encarga de dar luz verde para iniciar el conteo
				
				carry    		 : OUT STD_LOGIC; -- esta salida sirve para dar luz verde pero a otro MOD_N
				seg7_out 		 : OUT STD_LOGIC_VECTOR(6 downto 0) -- esta salida guardara la conversion directa de integer a los 7 segmentos para poder conectar directamente al display
			);
			
END ENTITY;

ARCHITECTURE conteo of MOD_N is

	SIGNAL conteo : INTEGER RANGE 0 TO limit;
	
begin 
		
		PROCESS(clk, reset)
		
			begin
				if reset = '1' then
					conteo <= 0;
					
				elsif rising_edge(clk) then 
					
					if enable = '1' then
						
						if conteo = limit then
							conteo <= 0;
						
						else 
							conteo <= conteo + 1;
							
						end if;
					
					end if;
				
				end if;
			
		end PROCESS;
		
carry <= '1' when (conteo = limit and enable = '1') else '0';

		PROCESS(conteo)
			begin
			CASE conteo is
				when 0 => seg7_out <= "0000001";
				when 1 => seg7_out <= "1001111";
				when 2 => seg7_out <= "0010010";
				when 3 => seg7_out <= "0000110";
				when 4 => seg7_out <= "1001100";
				when 5 => seg7_out <= "0100100";
				when 6 => seg7_out <= "0100000";
				when 7 => seg7_out <= "0001110";
				when 8 => seg7_out <= "0000000";
				when 9 => seg7_out <= "0000100";
				when others => seg7_out <= "1111111";
			end CASE;
		end PROCESS;

end architecture;		