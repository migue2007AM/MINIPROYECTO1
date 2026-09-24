LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MOD_N IS
		GENERIC(
					limit : INTEGER -- esta entrada recibe el limite de conteo que se quiere dependiendo la situacion
				);
				
		PORT(
				clk      : IN STD_LOGIC; -- esta entrada recibe la señal de reloj del divisor de frecuencia
				reset    : IN STD_LOGIC; -- esta entrada si es '1' el sistema se reinicia, en '0' no se reinicia
				enable   : IN STD_LOGIC; -- esta entrada se encarga de dar luz verde para iniciar el conteo
				running  : IN STD_LOGIC; -- esta entrada lo que hace es recordar la señal que envio el boton pulsado, sea start o stop, esto soluciona el problema de no mantener presionado el boton 
				
				carry    : OUT STD_LOGIC; -- esta salida sirve para dar luz verde pero a otro MOD_N
				seg7_out : OUT STD_LOGIC_VECTOR(6 downto 0) -- esta salida guardara la conversion directa de integer a los 7 segmentos para poder conectar directamente al display
			);
			
END ENTITY;

ARCHITECTURE conteo of MOD_N is

