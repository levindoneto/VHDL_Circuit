--                  Registrador com 8 bits                  |
--           Localizacao no circuito: [0,1] e [3,0]         |
-------------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

-- Entidade do registrador de 8 bits
entity registrador8 is
    port ( dadoReg8  :  in  std_logic_vector(7 downto 0);  -- Dado de entrada do registrador
           clkReg8   :  in  std_logic;                     -- Clock do registrador (Na subida do clock o dado e' passado para a saida)
           rstReg8   :  in  std_logic;                     -- Reset do registrador (Faz a saida receber 0)
           saidaReg8 : out  std_logic_vector(7 downto 0)); -- Saida do registrador (0 se reset=1, dado se clk=1)
end registrador8;

-- Arquitetura do Registrador de 8 bits
architecture hardwareR8 of registrador8 is
	signal Sreg	: std_logic_vector(7 downto 0);             -- Sreg vai pegando a saida no process
begin
	process (clkReg8, rstReg8)                              -- Processo sensivel ao clock e ao reset
	begin
			   if (rstReg8 = '1') then                        -- Se o reset estiver ativado
						Sreg <= "00000000";                      -- Entao o sinal que vai para a saida e' zerado
			elsif (rstReg8 = '0' and clkReg8'event and clkReg8='1') then        -- Quando tem evento de clock e esse e' de subida(clk=1)
						Sreg <= dadoReg8;
			end if;
	end process;
	saidaReg8 <= Sreg;                                      -- Passando a saida parcial do sinal para a saida do registrador de 8 bits
end hardwareR8;