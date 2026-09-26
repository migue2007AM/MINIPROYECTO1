LIBRARY IEEE;
LIBRARY WORK;

USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
use work.espacio_libre_pkg.ALL;

ENTITY espacio_libre is
	
	PORT(
	
			clk_fpga 		   : IN STD_LOGIC;
			btn_reset 		   : IN STD_LOGIC;
			sensor 			   : IN STD_LOGIC;
			
			led_alarma 		   : OUT STD_LOGIC;
			led_felicitacion  : OUT STD_LOGIC;
			disp_unidadesb    : OUT STD_LOGIC_VECTOR (6 downto 0);
			disp_decenasb 	   : OUT STD_LOGIC_VECTOR (6 downto 0);
			disp_unidadese    : OUT STD_LOGIC_VECTOR (6 downto 0);
			disp_decenase 	   : OUT STD_LOGIC_VECTOR (6 downto 0)
			);
			
END ENTITY;

architecture procedimiento of espacio_libre is

			SIGNAL clk_1HZ		    : STD_LOGIC;
			SIGNAL s_unidadesb    : INTEGER range 0 to 9;
			SIGNAL s_decenasb     : INTEGER range 0 to 9;
			SIGNAL s_unidadese    : INTEGER range 0 to 9;
			SIGNAL s_decenase     : INTEGER range 0 to 9;
			SIGNAL dec_unidadesb  : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_decenasb   : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_unidadese  : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_decenase   : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL s_conteobase   : INTEGER range 0 to 35;
			SIGNAL s_conteoextra  : INTEGER range 0 to 99;
			
			
begin
			U_divisor_frecuencia : entity work.divisor_frecuencia
					GENERIC MAP(
									FININ => 49999999,
									FOUT => 1
									)
					
					PORT MAP(
								clk_in => clk_fpga,
								reset => btn_reset,
								clk_out => clk_1HZ
							 );
							
			U_dos_casos : dos_casos
					PORT MAP(
								clk => clk_1HZ,
								reset => btn_reset,
								sensor_presencia => sensor,
								led_alarma => led_alarma,
								led_felicitacion => led_felicitacion,
								conteo_base => s_conteobase,
								conteo_extra => s_conteoextra,
								unidades_base => dec_unidadesb,
								decenas_base => dec_decenasb,
								unidades_extra => dec_unidadese,
								decenas_extra => dec_decenase
							);
							
												
			U_7SEG_conteobase_unidades : BCD_7SEG
										PORT MAP(
													A => dec_unidadesb,
													B => disp_unidadesb
												);
												
			U_7SEG_conteobase_decenas : BCD_7SEG
										PORT MAP(
													A => dec_decenasb,
													B => disp_decenasb
												);
												
			U_7SEG_conteoextra_unidades : BCD_7SEG
										PORT MAP(
													A => dec_unidadese,
													B => disp_unidadese
												);
												
			U_7SEG_conteoextra_decenas : BCD_7SEG
										PORT MAP(
													A => dec_decenase,
													B => disp_decenase
												);
												
end procedimiento;
										
			
												
			
								
			