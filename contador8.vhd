--                 Contador de 8 bits                   |
--              Posicao no circuito: [0,0]              |
---------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidade do contador de 8 bits
entity contador8 is
	port(
		up_downCont8 :  in std_logic;                      -- (0:Contador crescente, 1:Contador decrescente)
		clkCont8     :  in std_logic;                      -- Nas passagens de clock, vai passando os dados para a saida do contador
		resetCont8   :  in std_logic;                      -- Reset=1 -> Dado=0
		saidaCont8   : out std_logic_vector(7 downto 0));  -- Saida que recebera os valores do contador a medida que ocorrem os eventos de clock
end contador8;

-- Arquitetura do contador de 8 bits
architecture hardwareC8 of contador8 is
	signal count    : std_logic_vector (7 downto 0);      -- Sinal utilizado em processo, sera' passado para saidaCont8 no final
begin
	process(clkCont8, resetCont8)                         -- Processo sensivel ao clock e ao reset
	begin
		if (resetCont8 = '1') then 
	  		 count <= "00000000";
      elsif (clkCont8'event and clkCont8='1') then       -- Se ha' evento de subida de clock e esse e' de subida
			    if (up_downCont8 = '0') then                -- (up_downCont8 == 0) -> Contador crescente
					 count <= count + 1;                      -- Incrementa o count que vai para a saidaCont8
				 else                                        -- (up_downCont8 == 1) -> Contador decrescente
					 count <= count - 1;                      -- Decrementa o coutn que vai para a saidaCont8
				 end if;
		end if;
	end process;
	saidaCont8 <= count;                                  -- Passa o valor do sinal do process para a saida do contador
end hardwareC8;