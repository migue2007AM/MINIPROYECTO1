LIBRARY IEEE;

USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.espacio_libre_pkg.ALL;

entity dos_casos is

		PORT(	
				clk              : in  STD_LOGIC;
				reset            : in  STD_LOGIC;
				sensor_presencia : in  STD_LOGIC; -- '1' = Ocupado, '0' = Libre
				
				led_alarma 		  : OUT STD_LOGIC;
				led_felicitacion : OUT STD_LOGIC;
				conteo_base 	  : OUT integer range 0 to 35;
				conteo_extra 	  : OUT integer range 0 to 99
				
			);
			
END ENTITY;

architecture mixta of dos_casos is
    
	 -- Señales internas (memorias de los contadores) con 'range' para optimizar silicio
    signal cuenta_ex 	   : integer range 0 to 99  := 0;
	 signal cuenta_35 	   : integer range 0 to 35 := 0;
	 signal sensor_anterior : STD_LOGIC := '0';
	 signal felicitacion_reg: STD_LOGIC := '0';
	 
begin

    -- =========================================================================
    -- PARTE COMPORTAMENTAL: Manejo del tiempo (Secuencial)
    -- =========================================================================
    process(clk, reset)
    begin
        -- 1. Prioridad absoluta física: El Reset
        if reset = '1' then
            cuenta_35 <= 0;
            cuenta_ex <= 0;
				felicitacion_reg <= '0';
				sensor_anterior <= '0';
            
        -- 2. Sincronización con el reloj
        elsif rising_edge(clk) then
            
				-- Esto se hace para despues comparar la presencia inicial
				sensor_anterior <= sensor_presencia; 
					 
				if sensor_anterior = '1' and sensor_presencia = '0' then
						felicitacion_reg <= '1';
						cuenta_35 <= 0;
						cuenta_ex <= 0;
						
				elsif sensor_anterior = '0' and sensor_presencia = '1' then
						cuenta_35 <= 0;
						cuenta_ex <= 0;
						felicitacion_reg <= '0';
                
            elsif  sensor_presencia = '1' then
                
                -- Lógica de conteo: 
                -- Si no hemos llegado a 35, sumamos al contador base.
                -- Si ya llegamos a 35, empezamos a sumar al contador de facturación extra.
                if sensor_presencia = '1' and cuenta_35 < 35 then
                    cuenta_35 <= cuenta_35 + 1;
                else
                    cuenta_ex <= cuenta_ex + 1;
                end if;
					 
				-- Si el espacio está libre, mantenemos todo apagado/en cero
            elsif sensor_presencia = '0' then
                cuenta_35 <= 0;
                cuenta_ex <= 0;
                
            end if;
        end if;
    end process;

    -- =========================================================================
    -- PARTE DE FLUJO DE DATOS: Lógica directa (Optimizada sin 'if')
    -- =========================================================================
    
    -- El LED de alarma es un circuito combinacional puro. 
    -- Se encenderá DE INMEDIATO (sin retardos de reloj) en cuanto la cuenta llegue a 35
    -- y la persona siga ahí.
    led_alarma <= '1' when (cuenta_35 = 35 and sensor_presencia = '1') else '0';
    
    -- Conectamos las memorias internas hacia los cables de salida para visualizarlos
    conteo_base  <= cuenta_35;
    conteo_extra <= cuenta_ex;
	 led_felicitacion <= felicitacion_reg;

end mixta;


				
				
				