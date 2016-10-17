--                Registrador com 14 bits               |
--             Localizacao no circuito: [5,0]           |
--             Levindo Gabriel Taschetto Neto           |
--        Sistemas Digitais para Computacao   2016-1    |
---------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidade do registrador de 14 bits
entity registrador14 is
    port ( dadoReg14  :  in  std_logic_vector(13 downto 0);  -- Dado de entrada do registrador
           clkReg14   :  in  std_logic;                      -- Clock do registrador (Na subida do clock o dado e' passado para a saida)
           rstReg14   :  in  std_logic;                      -- Reset do registrador (Faz a saida receber 0)
           saidaReg14 : out  std_logic_vector(13 downto 0)); -- Saida do registrador (0 se reset=1, dado se clk=1)
end registrador14;

-- Arquitetura do Registrador de 14 bits
architecture hardwareR14 of registrador14 is
	signal Sreg14	: std_logic_vector(13 downto 0);           -- Sreg vai pegando a saida parcial no process
begin
	process (clkReg14, rstReg14)                              -- Processo sensivel ao clock e ao reset
	begin
			if    (rstReg14 = '1')                 then         -- Se o reset estiver ativado
						Sreg14 <= "00000000000000";                -- Entao o sinal que vai para a saida e' zerado
			elsif (rstReg14 = '0' and clkReg14'event and clkReg14='1') then        -- Quando tem evento de clock e esse e' de subida(clk=1)
						Sreg14 <= dadoReg14;
			end if;
	end process;
saidaReg14 <= Sreg14;                                        -- Passando a saida parcial do sinal para a saida do registrador de 14 bits
end hardwareR14;