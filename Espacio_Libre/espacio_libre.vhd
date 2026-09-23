LIBRARY IEEE;

USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY espacio_libre is
	GENERIC(
				freq_fpga : integer := 50000000
				);
	
	PORT(
	
			clk_fpga 		  : IN STD_LOGIC;
			btn_reset 		  : IN STD_LOGIC;
			sensor 			  : IN STD_LOGIC;
			
			led_alarma 		  : OUT STD_LOGIC;
			led_felicitacion : OUT STD_LOGIC;
			disp_unidades    : OUT STD_LOGIC_VECTOR (6 downto 0);
			disp_decenas 	  : OUT STD_LOGIC_VECTOR (6 downto 0);
			disp_centenas 	  : OUT STD_LOGIC_VECTOR (6 downto 0);
			disp_miles 		  : OUT STD_LOGIC_VECTOR (6 downto 0)
			);
			
END ENTITY;

architecture procedimiento of espacio_libre is

			SIGNAL clk_1HZ		   : STD_LOGIC := '0';
			SIGNAL s_unidades    : INTEGER range 0 to 9;
			SIGNAL s_decenas     : INTEGER range 0 to 9;
			SIGNAL s_centenas    : INTEGER range 0 to 9;
			SIGNAL s_miles 	   : INTEGER range 0 to 9;
			SIGNAL dec_unidades  : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_decenas   : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_centenas  : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_miles 	   : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL s_conteobase  : INTEGER range 0 to 35;
			SIGNAL s_conteoextra : INTEGER range 0 to 999;
			
			U_divisor_frecuencia : divisor_frecuencia
					GENERIC MAP(
									F_RELOJ => freq_fpga
									);
					
					PORT MAP(
								clk => clk_fpga,
								reset => btn_reset,
								pulso_1s => clk_1HZ
								);
								
			U_caso1 : caso_1_alerta
					PORT MAP(
								clk => clk_fpga,
								reset => btn_reset,
								sensor_presencia => sensor,
								
								led_alarma => led_alarma,
								conteo_base => s_conteobase,
								conteo_extra => s_conteoextra
								);
								
			U_caso2 : caso2_felicitacion
					PORT MAP(
								clk => clk_fpga,
								reset => btn_reset,
								sensor_presencia => sensor,
								
								led_felicitacino => led_felicitacion,
								conteo_base => s_conteobase
								);
								
			