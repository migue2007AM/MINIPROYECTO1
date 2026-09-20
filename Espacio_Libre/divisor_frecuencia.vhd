library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Usamos NUMERIC_STD porque es el estándar moderno y más óptimo para matemáticas
use IEEE.NUMERIC_STD.ALL; 

entity divisor_1Hz is
    generic (
        -- Esto hace que el código sea reutilizable. 
        -- Si tu FPGA es de 50MHz, cuenta hasta 50,000,000 para lograr 1 segundo.
        F_RELOJ : integer := 50000000 
    );
    port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        pulso_1s : out STD_LOGIC
    );
end divisor_1Hz;

architecture comportamental of divisor_1Hz is
    -- OPTIMIZACIÓN 1: Restringimos el rango del integer. 
    -- Si no ponemos el "range", Quartus gasta 32 Flip-Flops. 
    -- Al ponerle el límite, Quartus calcula matemáticamente y usa solo 26 Flip-Flops.
    signal contador : integer range 0 to F_RELOJ - 1 := 0;
begin
    -- El process "despierta" solo con el reloj o el botón de reset
    process(clk, reset)
    begin
        -- OPTIMIZACIÓN 2: El 'if' aquí es obligatorio porque el RESET debe 
        -- tener prioridad física absoluta sobre todo el circuito.
        if reset = '1' then
            contador <= 0;
            pulso_1s <= '0';
            
        elsif rising_edge(clk) then
            -- Cuando llegamos al límite (ha pasado 1 segundo real)
            if contador = F_RELOJ - 1 then
                contador <= 0;
                pulso_1s <= '1'; -- Disparamos la señal
            else
                contador <= contador + 1;
                pulso_1s <= '0'; -- Mantenemos apagado
            end if;
        end if;
    end process;
end comportamental;