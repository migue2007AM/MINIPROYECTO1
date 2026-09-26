LIBRARY IEEE;
LIBRARY WORK;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.temporizador_4botones_pkg.ALL;

ENTITY temporizador_4botones is
	PORT(	
			clk : IN STD_LOGIC;
			start : IN STD_LOGIC;
			stop : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			
			disp_sec1 : OUT STD_LOGIC_VECTOR(6 downto 0);
			disp_sec2 : OUT STD_LOGIC_VECTOR(6 downto 0);
			disp_min : OUT STD_LOGIC_VECTOR(6 downto 0);
			disp_punto : OUT STD_LOGIC
			
		);
		
END ENTITY;

ARCHITECTURE conteo OF temporizador_4botones IS
	
	SIGNAL running : STD_LOGIC := '0';
	SIGNAL clk_1HZ : STD_LOGIC;
	SIGNAL carry1  : STD_LOGIC;
	SIGNAL carry2  : STD_LOGIC;
	SIGNAL reset_invertido :STD_LOGIC;
	SIGNAL start_btn : STD_LOGIC;
	SIGNAL stop_btn : STD_LOGIC;

begin	
	reset_invertido <= not reset;
	start_btn <= not start;
	stop_btn <= not stop;
	process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				running <= '0';
			elsif start_btn = '1' then
				running <= '1';
			elsif stop_btn = '1' then
				running <= '0';
			end if;
		end if;
	end process;

	U_divisor_frecuencia : divisor_frecuencia
		GENERIC MAP(
						FININ => 49999999,
						FOUT => 1
						)
						
		PORT MAP(
					clk_in => clk,
					reset => reset,
					clk_out => clk_1HZ
				);
				
	U_UNIDADES_SEC : MOD_N
		PORT MAP(
					clk => clk_1HZ,
					reset => reset_invertido,
					enable => running,
					
					carry => carry1,
					seg7_out => disp_sec1
				);
				
	U_DECENAS_SEC : MOD_N
		GENERIC MAP(
						limit => 5
					)
		
		PORT MAP(
					clk => clk_1HZ,
					reset => reset_invertido,
					enable => carry1,
					
					carry => carry2,
					seg7_out => disp_sec2
				);
				
	U_UNIDADES_MIN : MOD_N
		PORT MAP(
					clk => clk_1HZ,
					reset => reset_invertido,
					enable => carry2,
					
					carry => open,
					seg7_out => disp_min
				);
				
	disp_punto <= running;
				
END conteo;

