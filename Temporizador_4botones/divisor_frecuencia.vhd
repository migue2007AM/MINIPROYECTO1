LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY divisor_frecuencia IS

    GENERIC (
        FININ : INTEGER := 50000000; -- Frecuencia del oscilador de la FPGA (50 MHz)
        FOUT  : INTEGER := 1         -- Frecuencia deseada para el conteo (1 Hz)
    );

    PORT (
        clk_in  : IN STD_LOGIC;      -- Entra el reloj rápido de 50 MHz
        reset   : IN STD_LOGIC;      -- Reset síncrono/asíncrono
        clk_out : OUT STD_LOGIC      -- Sale la señal dividida de 1 Hz
    );

END ENTITY;


ARCHITECTURE Behavioral OF divisor_frecuencia IS

    CONSTANT LIMITE : INTEGER := (FININ / (2 * FOUT)) - 1;

    SIGNAL contador : INTEGER RANGE 0 TO LIMITE := 0;
    SIGNAL clk_aux  : STD_LOGIC := '0';

BEGIN

    PROCESS(clk_in, reset)

    BEGIN

        IF reset = '0' THEN

            contador <= 0;
            clk_aux <= '0';

        ELSIF rising_edge(clk_in) THEN

            IF contador = LIMITE THEN

                contador <= 0;
                clk_aux <= NOT clk_aux;

            ELSE

                contador <= contador + 1;

            END IF;

        END IF;

    END PROCESS;


    clk_out <= clk_aux;

END Behavioral;