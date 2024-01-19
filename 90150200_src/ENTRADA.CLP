////////////////////////////////////////////////////////////////////////////////////////////////
//INICIALIZACOES
//////////////////////////////////////////////////////////////////////////////////////////////// 

//Inicializacao a frio

                aux = !realizouColdStart(programa);

                SEL     (aux)
                ENTAO_EXECUTA_BLOCO {
                    duracaoAvancoCilindro=500;  //5 segundos
                }

//Inicializacao a quente

                SEL     (cic1)
                ENTAO_EXECUTA_BLOCO {                
                    programa=9015;          
                    versao=2;               
                    revisao=0;              
                }

//Trata alteracao de parametros na IHM

                aux = verificaAlteracaoParametros();

                SEL     (aux)
                ENTAO_EXECUTA_BLOCO {                

                }

////////////////////////////////////////////////////////////////////////////////////////////////
//STATUS E POSICIONAMENTO
//////////////////////////////////////////////////////////////////////////////////////////////// 

                SEL     (entradaCilindroRecuado)
                MEMO    (cilindroRecuado)

                SEL     (entradaPoteEmbaixoDoCilindro)
                MEMO    (poteEmbaixoDoCilindro)

                SEL     (poteEmbaixoDoCilindro)
                SUBIDA
                MEMO    (poteChegouEmbaixoCilindro)

                SEL     (autoAvancaCilindro)
                MEMO    (dsp_duracaoAvancoCilindro)

                SEL     (fim_duracaoAvancoCilindro)
                MEMO    (cilindroAvancado)

