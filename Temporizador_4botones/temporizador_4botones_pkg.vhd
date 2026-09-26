LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

PACKAGE temporizador_4botones_pkg is
	
	COMPONENT MOD_N is
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
	END COMPONENT;
	
	COMPONENT divisor_frecuencia is
		GENERIC (
        FININ : INTEGER := 49999999; -- Frecuencia del oscilador de la FPGA (50 MHz)
        FOUT  : INTEGER := 1         -- Frecuencia deseada para el conteo (1 Hz)
		 );

		 PORT (
			  clk_in  : IN STD_LOGIC;      -- Entra el reloj rápido de 50 MHz
			  reset   : IN STD_LOGIC;      -- Reset síncrono/asíncrono
			  clk_out : OUT STD_LOGIC      -- Sale la señal dividida de 1 Hz
		 );
	END COMPONENT;
	
END temporizador_4botones_pkg;