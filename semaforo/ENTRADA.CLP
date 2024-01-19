////////////////////////////////////////////////////////////////////////////////////////////////
//INICIALIZACOES
//////////////////////////////////////////////////////////////////////////////////////////////// 

//Inicializacao a frio

                aux = !realizouColdStart(programa);

                SEL     (aux)
                ENTAO_EXECUTA_BLOCO {
                 
                }

//Inicializacao a quente

                SEL     (cic1)
                ENTAO_EXECUTA_BLOCO {                
                        programa=9000;          //90000200.0
                        versao=2;               //90000000.0
                        revisao=0;              //90000200.0            
                }

//Trata alteracao de parametros na IHM

                aux = verificaAlteracaoParametros();

                SEL     (aux)
                ENTAO_EXECUTA_BLOCO {

                }

////////////////////////////////////////////////////////////////////////////////////////////////
//STATUS E POSICIONAMENTO
//////////////////////////////////////////////////////////////////////////////////////////////// 

