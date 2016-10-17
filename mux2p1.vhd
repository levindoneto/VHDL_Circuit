--                  Seletor de 8 bits                   |
--              Posicao no circuito: [0,0]              |
---------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidade do seletor de  8 bits
entity mux2p1 is
    Port ( 
			  seletor8      : in  std_logic;
			  e0seletor8    : in  std_logic_vector (7 downto 0);   -- e0seletor8 <- saidaSomador8
			  e1seletor8    : in  std_logic_vector (7 downto 0);   -- e1seletor8 <- saidaMultiplicador8
           saidaSeletor8 : out std_logic_vector (7 downto 0));
end mux2p1;

-- Arquitetura do seletor de  8 bits
architecture hardwareSel8 of mux2p1 is
begin
	saidaSeletor8         <= e0seletor8 when seletor8='0'        -- saidaSeletor8 recebe e0seletor8 quando o sel e' 0
						          else e1seletor8;	                   -- saidaSeletor8 recebe e0seletor8 quando o sel e' 1
end hardwareSel8;