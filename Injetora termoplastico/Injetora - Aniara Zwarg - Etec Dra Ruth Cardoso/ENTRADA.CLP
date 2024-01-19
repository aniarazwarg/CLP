////////////////////////////////////////////////////////////////////////////////////////////////
//INICIALIZACOES
//////////////////////////////////////////////////////////////////////////////////////////////// 

                //Inicializacao a frio

                SEL     (!realizouColdStart(programa))
                ENTAO_EXECUTA_BLOCO {

                        x0_Vazao=0;             
                        x1_Vazao=10;            
                        x2_Vazao=20;            
                        x3_Vazao=30;            
                        x4_Vazao=40;            
                        x5_Vazao=50;            
                        x6_Vazao=60;           
                        x7_Vazao=70;           
                        x8_Vazao=80;           
                        x9_Vazao=100;           

                        y0_Vazao=0;             
                        y1_Vazao=10;            
                        y2_Vazao=20;            
                        y3_Vazao=30;            
                        y4_Vazao=40;            
                        y5_Vazao=50;            
                        y6_Vazao=60;           
                        y7_Vazao=70;           
                        y8_Vazao=80;           
                        y9_Vazao=100;           

                        habSupervisaoMovimentos=0;
                
                }

                //Inicializacao a quente

                SEL     (cic1)
                ENTAO_EXECUTA_BLOCO {                
                        programa=9028;          
                        versao=3;               
                        revisao=1;              

                        retInicializacao=200;               
                        durTelaApresentacao=200;
                }

                //Trata alteracao de parametros na IHM

                SEL     (verificaAlteracaoParametros())
                ENTAO_EXECUTA_BLOCO {

                        nivelProtecaoCorrente=nivelProtecaoAtivo;


                }

////////////////////////////////////////////////////////////////////////////////////////////////
//STATUS E POSICIONAMENTO
//////////////////////////////////////////////////////////////////////////////////////////////// 

                SEL     (sensorMaquinaTravada)              
                MEMO    (moldeFechado)

                SEL     (sensorAmortecimentoFechamento)     
                MEMO    (amortecimentoFechamentoMolde)      

                SEL     (sensorMoldeAberto)
                MEMO    (moldeAberto)
                        
                SEL     (sensorAmortecimentoAbertura)       
                MEMO    (amortecimentoAberturaMolde)        

                SEL     (comandoLigaMotor)
                MEMO    (motorLigado)

                SEL     (botaoSelecaoModoManual)
                MEMO    (auxBotaoSelecaoModoManual)

                SEL     (sensorFimDosagem)      
                OU      (desabilitaInjecao)     
                MEMO    (dosagemConcluida)

                //Intrusao
                
                SEL     (durIntrusao!=0)
                MEMO    (habilitaIntrusao)
                
                SEL     (fim_durIntrusao)
                OUN     (habilitaIntrusao)
                OU      (desabilitaInjecao)
                MEMO    (intrusaoConcluida)

                //Recalque

                SEL     (sensorPassagemParaRecalque)
                EN      (habPassagemParaRecalquePorTempo)
                MEMO    (recalqueAtingidoPorPosicao)

                SEL     (fim_durPreenchimento)      
                E       (habPassagemParaRecalquePorTempo)   
                OU      (recalqueAtingidoPorPosicao)              
                OU      (desabilitaInjecao)
                MEMO    (preenchimentoConcluido)

                //Protetor dianteiro

                SEL     (sensorProtetorDiantFechado)
                MEMO    (protetorDiantFechado)


                //Motor


                //Injecao
             

                //PreAvancamento

                SEL     (autoPreAvancamento)
                E       (fim_durFechamentoPreAvancamento)                               
                ENTAO_EXECUTA_BLOCO {                                                               
                        numeroPreAvancamentosRealizados++;                                       
                }                                                                       

                SEL     (autoFechamentoMolde)                                       
                ENTAO_EXECUTA_BLOCO {                                                               
                        numeroPreAvancamentosRealizados=0;                   
                }                                                                       

                SEL     (numeroPreAvancamentosRealizados >= numeroPreAvancamentosProgramados)
                E       (moldeAberto)
                MEMO    (preAvancamentoConcluido)

                //Recalque

                SEL     (fim_durRecalque)       
                OU      (desabilitaInjecao)
                MEMO    (recalqueConcluido)

                //Resfriamento

                SEL     (fim_durResfriamento)
                OU      (desabilitaInjecao)
                MEMO    (resfriamentoConcluido)


                //Start ciclo

                SEL     (protetorDiantFechado)
                SUBIDA
                OU      (botaoStart)
                MEMO    (solicitouStartCiclo)

