--               Multiplicador de 8 bits                |
--              Posicao no circuito: [1,1]              |
---------------------------------------------------------
-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidade do multiplicador de 8 bits (implementando o multi gerado pelo CoreGenerator)
entity multiplicador is
    port (  e0Multiplicador8    :  in  std_logic_vector (7 downto 0);
            e1Multiplicador8    :  in  std_logic_vector (7 downto 0);
            saidaMultiplicador8 : out  std_logic_vector (7 downto 0));
end multiplicador;

-- Arquitetura do multiplicador de 8 bits
architecture hardwareM8 of multiplicador is

	signal sinalSaidaM8: std_logic_vector (15 downto 0);
	
	component multiplier         -- Multiplicador unsigned gerado pelo CoreGenarator
   port (   a                   :  in std_logic_vector(7  downto 0);
				b                   :  in std_logic_vector(7  downto 0);
				p                   : out std_logic_vector(15 downto 0));
	end component;

	begin
	 mul : multiplier port map (
				a => e0Multiplicador8,
				b => e1Multiplicador8,
				p => sinalSaidaM8);
				  
	 saidaMultiplicador8 <= sinalSaidaM8(7 downto 0); 
end hardwareM8;