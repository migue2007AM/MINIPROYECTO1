library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity caso_1_alerta is
    port (
        clk              : in  STD_LOGIC;
        reset            : in  STD_LOGIC;
        pulso_1s         : in  STD_LOGIC; -- El "tic" que viene de nuestro divisor
        sensor_presencia : in  STD_LOGIC; -- '1' = Ocupado, '0' = Libre
        
        led_alarma       : out STD_LOGIC;
        conteo_base      : out integer range 0 to 35;  -- Muestra los primeros 35s
        conteo_extra     : out integer range 0 to 999  -- Muestra el tiempo extra a facturar
    );
end caso_1_alerta;

architecture mixta of caso_1_alerta is
    -- Señales internas (memorias de los contadores) con 'range' para optimizar silicio
    signal cuenta_35 : integer range 0 to 35 := 0;
    signal cuenta_ex : integer range 0 to 999 := 0;
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
            
        -- 2. Sincronización con el reloj
        elsif rising_edge(clk) then
            
            -- Si el espacio está libre, mantenemos todo apagado/en cero
            if sensor_presencia = '0' then
                cuenta_35 <= 0;
                cuenta_ex <= 0;
                
            -- Si está ocupado y llega el "tic" de 1 segundo...
            elsif pulso_1s = '1' then
                
                -- Lógica de conteo: 
                -- Si no hemos llegado a 35, sumamos al contador base.
                -- Si ya llegamos a 35, empezamos a sumar al contador de facturación extra.
                if cuenta_35 < 35 then
                    cuenta_35 <= cuenta_35 + 1;
                else
                    cuenta_ex <= cuenta_ex + 1;
                end if;
                
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

end mixta;