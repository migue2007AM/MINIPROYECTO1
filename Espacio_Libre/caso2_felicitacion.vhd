LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity caso2_felicitacion is
	port(
			clk              : in  STD_LOGIC;
			reset            : in  STD_LOGIC;
			pulso_1s         : in  STD_LOGIC; -- El "tic" que viene de nuestro divisor
			sensor_presencia : in  STD_LOGIC; -- '1' = Ocupado, '0' = Libre
			
			led_felicitacion : out STD_LOGIC; -- Por medio de un LED se avisara de la felicitacion
			conteo_base      : out integer range 0 to 35);  -- Muestra los primeros 35s

end entity;

architecture felicitacion of caso2_felicitacion is

	signal cuenta_35 : integer range 0 to 35 := 0;
	signal sensor_anterior: STD_LOGIC := '0';
	signal felicitacion_reg: STD_LOGIC := '0';
	
begin
	
	process(clk,reset)
	begin
			if reset = '1' then
				cuenta_35 <= 0;
				sensor_anterior <= '0';
				felicitacion_reg <= '0';
				
			elsif rising_edge(clk) then -- rising_edge(clk) sirve para usar los flancos de subida de un clk
				
				-- Esto se hace para despues comparar la presencia inicial
				sensor_anterior <= sensor_presencia; 
				
				-- Esto nos indica que la persona acaba de salir
				if sensor_anterior = '1' and sensor_presencia = '0'  then
					
					if cuenta_35 < 35 then
						felicitacion_reg <= '1';
					
					end if;
					
				end if;
				
				if sensor_anterior = '0' and sensor_presencia = '1' then
				
					cuenta_35 <= 0;
					felicitacion_reg <= '0';
					
				elsif sensor_presencia = '1' and pulso_1s = '1' and cuenta_35 < 35 then
					cuenta_35 <= cuenta_35 + 1;
				
				end if;
				
			end if;
			
	end process;

	led_felicitacion <= felicitacion_reg;
	conteo_base <= cuenta_35;

end felicitacion;
		
						
						