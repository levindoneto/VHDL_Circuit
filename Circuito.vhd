--                  Circuito completo                   |
--              Com mapeamento dos componentes          |
--              Levindo Gabriel Taschetto Neto          |
--        Sistemas Digitais para Computacao   2016-1    |
---------------------------------------------------------

-- Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Entidade do circuito principal
entity circuito is
port ( 
			      clkCircuito            :  in std_logic;
			      up_downCircuito        :  in std_logic;
			      resetCircuito          :  in std_logic;
			      seletorCircuito        :  in std_logic;
			      entradaCircuito        :  in std_logic_vector (7 downto 0);
			      saidaCircuito          : out std_logic_vector (13 downto 0));  -- Saida de 14 bits
end circuito;

-- Arquitetura do circuito main
architecture hardware of circuito is
	-- Declaracao dos componentes, instanciacao dos mesmos
	component contador8                -- Componente do registrador de 8 bits
		 port (  up_downCont8           :  in std_logic;                      
					clkCont8               :  in std_logic;                      
					resetCont8             :  in std_logic;                    
					saidaCont8             : out std_logic_vector(7 downto 0));  
	end component;

	component registrador8             -- Componente do registrador de 8 bits
		 port ( dadoReg8                :  in std_logic_vector (7 downto 0);
				  clkReg8                 :  in std_logic;
				  rstReg8                 :  in std_logic;
				  saidaReg8               : out std_logic_vector (7 downto 0));
	end component;

	component somador8                 -- Componente do somador de 8 bits
		 port ( e0Somador8              :  in std_logic_vector (7 downto 0);  
				  e1Somador8              :  in std_logic_vector (7 downto 0);
				  saidaSomador8           : out std_logic_vector (7 downto 0)); 
	end component;

	component multiplicador            -- Componente do multiplicador
		 port ( e0Multiplicador8        :  in  std_logic_vector (7 downto 0);
				  e1Multiplicador8        :  in  std_logic_vector (7 downto 0);
				  saidaMultiplicador8     : out  std_logic_vector (7 downto 0));
	end component;

	component mux2p1                   -- Componente do seletor, mux 2 para 1
		 port ( seletor8                : in  std_logic;
				  e0seletor8              : in  std_logic_vector (7 downto 0);
				  e1seletor8              : in  std_logic_vector (7 downto 0);
				  saidaSeletor8           : out std_logic_vector (7 downto 0));
	end component;

	component conversorNB              -- Componente do conversor Nibble-BCD
		 port ( dadoConversorNB         :  in std_logic_vector (7  downto 0); 
				  saidaConversorNB        : out std_logic_vector (13 downto 0));
	end component;

	component registrador14            -- Componente do registrador de 14 bits
		 port ( dadoReg14               :  in  std_logic_vector(13 downto 0); 
				  clkReg14                :  in  std_logic;                     
				  rstReg14                :  in  std_logic;                      
				  saidaReg14              : out  std_logic_vector(13 downto 0)); 
	end component;

   -- Sinais utilizados nas saidas parciais dos componentes
	signal sinalSaidaReg1              : std_logic_vector (7  downto 0);
	signal sinalSaidaCont              : std_logic_vector (7  downto 0);
	signal sinalSaidaSomador           : std_logic_vector (7  downto 0);
   signal sinalSaidaMult              : std_logic_vector (7  downto 0);
	signal sinalSaidaMux               : std_logic_vector (7  downto 0);
	signal sinalSaidaReg2              : std_logic_vector (7  downto 0);
	signal sinalSaidaConversor         : std_logic_vector (13 downto 0);

begin
	-- Fazendo os apontamento dos componentes
	-- nomes: CompNomeDoComponente
	-- varComponente => varCircuito
	-- Do lado dos port map's e' dado a posicao do componente 
	--     no circuito da seguinte forma[coluna, linha]
	CompContador: contador8    port map  ( -- [0,0]
					  up_downCont8        => up_downCircuito,
					  clkCont8            => clkCircuito,
					  resetCont8          => resetCircuito,
					  saidaCont8          => sinalSaidaCont);

	CompRegist1:  registrador8 port map  ( -- [0,1]
					  dadoReg8            => entradaCircuito,
					  clkReg8             => clkCircuito,
					  rstReg8             => resetCircuito,
					  saidaReg8           => sinalSaidaReg1);

	CompSomador:  somador8     port map  ( -- [1,0]
					  e0Somador8          => sinalSaidaCont,
					  e1Somador8          => sinalSaidaReg1,
					  saidaSomador8       => sinalSaidaSomador);

	CompMultip:   multiplicador port map ( -- [1,1]
					  e0Multiplicador8    => sinalSaidaCont,
					  e1Multiplicador8    => sinalSaidaReg1,
					  saidaMultiplicador8 => sinalSaidaMult);

	CompMux2p1:   mux2p1        port map ( -- [2,0]
					  seletor8            => seletorCircuito,
					  e0seletor8          => sinalSaidaSomador,
					  e1seletor8          => sinalSaidaMult,
					  saidaSeletor8       => sinalSaidaMux);
					  
	CompRegist2:  registrador8  port map ( -- [3,0]
					  dadoReg8            => sinalSaidaMux,
					  clkReg8             => clkCircuito,
					  rstReg8             => resetCircuito,
					  saidaReg8           => sinalSaidaReg2);			  

	CompConv:     conversorNB   port map ( -- [4,0]
					  dadoConversorNB     => sinalSaidaReg2,
					  saidaConversorNB    => sinalSaidaConversor);

	CompRegist3:  registrador14  port map ( -- [5,0]
					  dadoReg14           => sinalSaidaConversor, 
					  clkReg14            => clkCircuito,                    
					  rstReg14            => resetCircuito,               
					  saidaReg14          => saidaCircuito); 
end hardware;