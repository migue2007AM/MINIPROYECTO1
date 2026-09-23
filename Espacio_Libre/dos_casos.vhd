LIBRARY IEEE;

USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.espacio_libre_pkg.ALL;

entity dos_casos is

		PORT(	
				clk              : in  STD_LOGIC;
				reset            : in  STD_LOGIC;
				pulso_1s         : in  STD_LOGIC; -- El "tic" que viene de nuestro divisor
				sensor_presencia : in  STD_LOGIC; -- '1' = Ocupado, '0' = Libre
				unidades 		  : in integer range 0 to 9;
				decenas  		  : in integer range 0 to 9;
				centenas 		  : in integer range 0 to 9;
				miles 			  : in integer range 0 to 9;
				
				