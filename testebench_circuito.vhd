--                  Circuito completo                   |
--              Levindo Gabriel Taschetto Neto          |
--        Sistemas Digitais para Computacao   2016-1    |
---------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Entidade do TesteBench do circuito
entity testebench_circuito is
end testebench_circuito;

architecture comportamentoTB of testebench_circuito is
    -- Declaracao do componente do circuito
    component circuito
    port(
         clkCircuito            :  in std_logic;
         up_downCircuito        :  in std_logic;
         resetCircuito          :  in std_logic;
         seletorCircuito        :  in std_logic;
         entradaCircuito        :  in std_logic_vector (7 downto 0);
         saidaCircuito          : out std_logic_vector (13 downto 0));  -- Saida de 14 bits
	  end component;
   -- Entradas
   signal clkCircuito           : std_logic := '0';
   signal up_downCircuito       : std_logic := '0';
   signal resetCircuito         : std_logic := '0';
   signal seletorCircuito       : std_logic := '0';
   signal entradaCircuito       : std_logic_vector(7 downto 0) := "00000000";

 	-- Saida
   signal saidaCircuito         : std_logic_vector(13 downto 0);

   -- Clock period definitions
   constant clkCircuito_period  : time := 10 ns;
 
begin
 
	-- Instanciando the Unit Under Test (UUT)
   uut: circuito port map (
          clkCircuito            => clkCircuito,
          up_downCircuito        => up_downCircuito,
          resetCircuito          => resetCircuito,
          seletorCircuito        => seletorCircuito,
          entradaCircuito        => entradaCircuito,
          saidaCircuito          => saidaCircuito
        );

   -- Definicoes do processo de clock
   clkCircuito_process :process
   begin
		clkCircuito <= '0';
		wait for clkCircuito_period/2;
		clkCircuito <= '1';
		wait for clkCircuito_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- Esperar estado de reset por 100 ns.
      wait for 100 ns;	
			resetCircuito   <= '1';
		wait for clkCircuito_period;
			resetCircuito   <= '0';
		wait for clkCircuito_period;
		
		entradaCircuito    <= "11110000";
		up_downCircuito    <= '0';
		seletorCircuito    <= '0';
		
		wait for clkCircuito_period;
			seletorCircuito <= '1';
		wait for clkCircuito_period;
			entradaCircuito <= "11110000";
			up_downCircuito <= '1';
			seletorCircuito <= '1';

	   for m in std_logic range '0' to '1' loop         -- Para o up_downCircuito
			for n in std_logic range '0' to '1' loop      -- Para o seletorCircuito
				for o in 0 to 255 loop -- Para o entradaCircuito
					up_downCircuito <= m;
					seletorCircuito <= n;
					entradaCircuito <= conv_std_logic_vector (o,8);
					wait for clkCircuito_period*100;               -- Para dar tempo de ocorrer as variacoes com o clock
			   end loop;
			end loop;	
		end loop;		
      wait;
   end process;
end;