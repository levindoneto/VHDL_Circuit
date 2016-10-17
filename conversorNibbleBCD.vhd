--                  Conversor Nibble-BCD                |
--             Localizacao no circuito: [5,0]           |
--             Levindo Gabriel Taschetto Neto           |
--        Sistemas Digitais para Computacao   2016-1    |
---------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidade do conversor Nibble-BCD
entity conversorNB is
	port(
		   dadoConversorNB        :  in std_logic_vector (7  downto 0);   -- Dado de entrada, a ser convertido
		   saidaConversorNB       : out std_logic_vector (13 downto 0));  -- Dado de saida convertido
end conversorNB;

-- Arquitetura do conversor Nibble-BCD
architecture hardwareC8 of conversorNB is
	signal sinalConv_out1        :   std_logic_vector(6  downto 0);      -- Segmentos de saida (1-7) , Display 1
	signal sinalConv_out2        :   std_logic_vector(6  downto 0);      -- Segmentos de saida (4-7) , Display 1 
begin
	-- Segmento ligado   (0)
	-- Segmento desligdo (1)
		with dadoConversorNB(3 downto 0)  select                          -- Com os 4 bits menos significativos selecionados
			sinalConv_out1				<= "0000001" when "0000",              -- '0'
												"1001111" when "0001",              -- '1'
												"0010010" when "0010",              -- '2'
												"0000110" when "0011",              -- '3'
												"1001100" when "0100",              -- '4'
												"0100100" when "0101",              -- '5'
												"0100000" when "0110",              -- '6'
												"0001111" when "0111",              -- '7'
												"0000000" when "1000",              -- '8'
												"0000100" when "1001",              -- '9'
												"0001000" when "1010",              -- 'A'
												"1100000" when "1011",              -- 'B'
												"0110001" when "1100",              -- 'C'
												"1000010" when "1101",              -- 'D'
												"0110000" when "1110",              -- 'E'
												"0111000" when "1111",              -- 'F'
												"1111111" when others;
		with dadoConversorNB(7 downto 4) select                           -- Com os 4 bits mais significativos selecionados
			sinalConv_out2	         <= "0000001" when "0000",              -- '0'
												"1001111" when "0001",              -- '1'
												"0010010" when "0010",              -- '2'
												"0000110" when "0011",              -- '3'
												"1001100" when "0100",              -- '4'
												"0100100" when "0101",              -- '5'
												"0100000" when "0110",              -- '6'
												"0001111" when "0111",              -- '7'
												"0000000" when "1000",              -- '8'
												"0000100" when "1001",              -- '9'
												"0001000" when "1010",              -- 'A'
												"1100000" when "1011",              -- 'B'
												"0110001" when "1100",              -- 'C'
												"1000010" when "1101",              -- 'D'
												"0110000" when "1110",              -- 'E'
												"0111000" when "1111",              -- 'F'
												"1111111" when others;
		saidaConversorNB(6 downto 0)  <=  sinalConv_out1;                 -- Passando os 7 segmentos referentes aos 4 bits menos significativos do dado de entrada
		saidaConversorNB(13 downto 7) <=  sinalConv_out2;	               -- Passando os 7 segmentos referentes aos 4 bits mais  significativos do dado de entrada
end hardwareC8;