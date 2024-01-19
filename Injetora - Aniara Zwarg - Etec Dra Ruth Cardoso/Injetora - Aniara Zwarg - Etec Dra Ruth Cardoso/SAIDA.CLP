////////////////////////////////////////////////////////////////////////////////////////////////
//SAIDAS ANALOGICAS
//////////////////////////////////////////////////////////////////////////////////////////////// 

                auxVazao=0;
                
                //Abertura do molde

                LDT     (comandoAberturaMolde)
                ENTAO_EXECUTA_BLOCO     {
                        auxVazao=vazaoAberturaMolde;
                }

                LDT     (comandoAberturaMolde)              
                E       (amortecimentoAberturaMolde)        
                ENTAO_EXECUTA_BLOCO     {                                   
                        auxVazao=vazaoAmortecAbertMolde;
                }                                           

                //Fechamento do molde

                LDT     (comandoFechamentoMolde)                
                ENTAO_EXECUTA_BLOCO     {                                       
                        auxVazao=vazaoFechamentoMolde;      
                }                                               

                LDT     (comandoFechamentoMolde)                
                E       (amortecimentoFechamentoMolde)          
                ENTAO_EXECUTA_BLOCO     {                                       
                        auxVazao=vazaoAmortecFechamMolde;   
                }                                               

            
                //Intrusao

                LDT     (autoIntrusao)
                E       (fim_retIntrusao)
                EN      (alarmeNivel3) 
                ENTAO_EXECUTA_BLOCO     {
                        auxVazao=vazaoIntrusao;
                }

                //Injecao

                LDT     (comandoInjecao)
                ENTAO_EXECUTA_BLOCO     {
                        auxVazao=vazaoPreenchimento;
                }

                LDT     (comandoInjecao)
                E       (preenchimentoConcluido)    
                ENTAO_EXECUTA_BLOCO     {
                        auxVazao=vazaoRecalque;
                }


                //Dosagem

                LDT     (comandoDosagem)
                EN      (autoIntrusao)  
                ENTAO_EXECUTA_BLOCO     {
                        auxVazao=vazaoDosagem;
                }

                vazaoPropProgramada=auxVazao;


                //Teste de Saidas analogicas

                LDF     (habTesteSaidasAnalogicas)                                         
                OU      (motorLigado)                                                      
                OU      (botaoSelecaoModoManut)                                            
                OU      (botaoSelecaoModoManual)                                           
                OU      (botaoSelecaoModoSemi)                                             
                OU      (botaoSelecaoModoAuto)                                             
                OU      (botaoLigaMotor)                                                   
                OU      (botaoStart)                                                       
                ENTAO_EXECUTA_BLOCO {                                                                  
                    vazaoProporcional=vazaoPropEmBit;                                
                    habTesteSaidasAnalogicas=0;                                            
                }                                                                          

////////////////////////////////////////////////////////////////////////////////////////////////
//SAIDAS DIGITAIS
////////////////////////////////////////////////////////////////////////////////////////////////


                LDT     (comandoAberturaMolde)
                MEMO    (saidaAberturaMolde)

                LDT     (comandoInjecao)
                MEMO    (saidaInjecao)

                LDT     (comandoDosagem)
                MEMO    (saidaDosagem)

                LDT     (comandoLigaMotor)
                MEMO    (saidaLigaMotor)

                LDT     (comandoFechamentoMolde)
                MEMO    (saidaFechamentoMolde)

