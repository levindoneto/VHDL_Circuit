--                  Somador de 8 bits                   |
--              Posicao no circuito: [1,0]              |
---------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidade do somador de 8 bits
entity somador8 is
    port ( e0Somador8    :  in std_logic_vector (7 downto 0);  -- E0Somador8 <- saidaCont8 no port_map
			  e1Somador8    :  in std_logic_vector (7 downto 0);  -- E1Somador8 <- saidaReg8 no port_map
           saidaSomador8 : out std_logic_vector (7 downto 0)); -- Saida do somador (E0Somador + E1Somador)
end somador8;
		
-- Arquitetura do somador de 8 bits
architecture hardwareS8 of somador8 is
begin
		saidaSomador8 <= E0Somador8 + E1Somador8;                -- A saida do somador e' a soma de suas duas entradas
end hardwareS8;