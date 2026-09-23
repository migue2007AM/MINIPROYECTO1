LIBRARY IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

package espacio_libre_pkg is
	
	
	COMPONENT divisor_frecuecia is
			
			GENERIC (
			FININ : INTEGER := 50000000; -- Frecuencia del oscilador de la FPGA (50 MHz)
			FOUT  : INTEGER := 1         -- Frecuencia deseada para el conteo (1 Hz)
			);

			PORT (
				 clk_in  : IN STD_LOGIC;      -- Entra el reloj rápido de 50 MHz
				 reset   : IN STD_LOGIC;      -- Reset síncrono/asíncrono
				 clk_out : OUT STD_LOGIC      -- Sale la señal dividida de 1 Hz
			  );
			 
	END COMPONENT;
	
	COMPONENT DEC_BCD is
	
			PORT(
					x: in  STD_LOGIC_VECTOR (9 downto 0);
					y: out STD_LOGIC_VECTOR(3 downto 0)
					);
					
	END COMPONENT;
	
	COMPONENT BCD_7SEG is 
	
			PORT(
					A: in STD_LOGIC_VECTOR(3 downto 0);
					B: out STD_LOGIC_VECTOR(6 downto 0)
					);
					
	END COMPONENT;
	
	COMPONENT union_contadores is
	
			port(
				numero_entrada : IN integer range 0 to 99;
				
				unidades 		: out integer range 0 to 9;
				decenas  		: out integer range 0 to 9
				);
			
	END COMPONENT;
	
	COMPONENT dos_casos is
			PORT(	
				clk              : in  STD_LOGIC;
				reset            : in  STD_LOGIC;
				sensor_presencia : in  STD_LOGIC; -- '1' = Ocupado, '0' = Libre
				
				led_alarma 		  : OUT STD_LOGIC;
				led_felicitacion : OUT STD_LOGIC;
				conteo_base 	  : OUT integer range 0 to 35;
				conteo_extra 	  : OUT integer range 0 to 99
				
			);
			
	END COMPONENT;
	
END PACKAGE espacio_libre_pkg;