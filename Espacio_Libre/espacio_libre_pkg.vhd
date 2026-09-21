LIBRARY IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

package espacio_libre_pkg is
	
	COMPONENT caso_1_alerta is
	
		PORT(
				clk              : in  STD_LOGIC;
				reset            : in  STD_LOGIC;
				pulso_1s         : in  STD_LOGIC; -- El "tic" que viene de nuestro divisor
				sensor_presencia : in  STD_LOGIC; -- '1' = Ocupado, '0' = Libre
        
				led_alarma       : out STD_LOGIC;
				conteo_base      : out integer range 0 to 35;  -- Muestra los primeros 35s
				conteo_extra     : out integer range 0 to 999  -- Muestra el tiempo extra a facturar
				);  
				
	END COMPONENT;
	
	COMPONENT caso2_felicitacion is 
		
			PORT(
					clk              : in  STD_LOGIC;
					reset            : in  STD_LOGIC;
					pulso_1s         : in  STD_LOGIC; -- El "tic" que viene de nuestro divisor
					sensor_presencia : in  STD_LOGIC; -- '1' = Ocupado, '0' = Libre
					
					led_felicitacion : out STD_LOGIC; -- Por medio de un LED se avisara de la felicitacion
					conteo_base      : out integer range 0 to 35 -- Muestra los primeros 35s
					); 
					
	END COMPONENT;
	
	COMPONENT divisor_frecuecia is
			
			GENERIC(
				 -- Esto hace que el código sea reutilizable. 
				 -- Si tu FPGA es de 50MHz, cuenta hasta 50,000,000 para lograr 1 segundo.
				 F_RELOJ : integer := 50000000 
				 );
			
			PORT(
					clk      : in  STD_LOGIC;
					reset    : in  STD_LOGIC;
					pulso_1s : out STD_LOGIC -- Representa los flancos de subida del clk 
					);
			 
	END COMPONENT;
	
	COMPONENT DEC_BCD is
	
			PORT(
					port(x: in  STD_LOGIC_VECTOR (9 downto 0);
					y: out STD_LOGIC_VECTOR(3 downto 0)
					);
					
	END COMPONENT;
	
	COMPONENT BCD_7SEG is 
	
			PORT(
					A: in STD_LOGIC_VECTOR(3 downto 0);
					B: out STD_LOGIC_VECTOR(6 downto 0)
					);
					
	END COMPONENT;
	
			
		