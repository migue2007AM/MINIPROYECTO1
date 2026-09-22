LIBRARY IEEE;

USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.espacio_libre_pkg.ALL;

ENTITY espacio_libre is
	port(
	
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

			SIGNAL clk_1HZ		  : STD_LOGIC := '0';
			SIGNAL s_unidades   : INTEGER range 0 to 9;
			SIGNAL s_decenas    : INTEGER range 0 to 9;
			SIGNAL s_centenas   : INTEGER range 0 to 9;
			SIGNAL s_miles 	  : INTEGER range 0 to 9;
			SIGNAL dec_unidades : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_decenas  : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_centenas : STD_LOGIC_VECTOR (3 downto 0);
			SIGNAL dec_miles 	  : STD_LOGIC_VECTOR (3 downto 0);
			
