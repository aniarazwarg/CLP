////////////////////////////////////////////////////////////////////////////////////////////////
//MODO DE OPERACAO
//////////////////////////////////////////////////////////////////////////////////////////////// 

                SEL     (botaoSelecaoModoManual)
                OU      (cic1)
                OU      (manual)
                EN      (botaoSelecaoModoSemi)
                EN      (botaoSelecaoModoAuto)
                MEMO    (manual)
                
                SEL     (botaoSelecaoModoSemi)
                OU      (semiAutomatico)
                EN      (botaoSelecaoModoManual)
                EN      (botaoSelecaoModoAuto)
                MEMO    (semiAutomatico)

                SEL     (botaoSelecaoModoAuto)
                OU      (automatico)
                EN      (botaoSelecaoModoManual)
                OU      (semiAutomatico)
                MEMO    (automatico)

                SEL     (manual)
                ENTAO_EXECUTA_BLOCO {
                        modoOperacao=0;
                }

                SEL     (semiAutomatico)
                ENTAO_EXECUTA_BLOCO {
                        modoOperacao=1;
                }

                SEL     (automatico)
                EN      (semiAutomatico)
                ENTAO_EXECUTA_BLOCO {
                        modoOperacao=2;
                }

////////////////////////////////////////////////////////////////////////////////////////////////
//SEQUENCIADOR AUTOMATICO
//////////////////////////////////////////////////////////////////////////////////////////////// 


                SEL     (automatico)
                EN      (autoFechamentoMolde)
                EN      (autoIntrusao)
                EN      (autoPreenchimento)
                EN      (autoRecalque)
                EN      (autoDosagem)
                EN      (autoResfriamento)
                EN      (autoAberturaMolde)
                EN      (autoAvancoExtratorMolde) //90280103.1
                EN      (autoRecuaExtratorMolde) //90280103.1
                EN      (autoPreAvancamento)
                MEMO    (autoEsperandoInicioCiclo)  

                SEL     (autoEsperandoInicioCiclo)
                E       (solicitouStartCiclo)
                OU      (reciclo)
                EN      (alarmeNivel2)
                EN      (alarmeNivel3)
                OU      (autoFechamentoMolde)
                E       (automatico)
                EN      (autoIntrusao)          
                MEMO    (autoFechamentoMolde)                
               
                SEL     (autoFechamentoMolde)
                E       (moldeFechado)
                EN      (alarmeNivel3)
                OU      (autoIntrusao)
                E       (automatico)
                EN      (autoPreenchimento)
                MEMO    (autoIntrusao)
    
                SEL     (autoIntrusao)
                E       (intrusaoConcluida)
                EN      (alarmeNivel3)
                OU      (autoPreenchimento)
                E       (automatico)
                EN      (autoRecalque)
                MEMO    (autoPreenchimento)

                SEL     (autoPreenchimento)
                E       (preenchimentoConcluido)
                EN      (alarmeNivel3)
                OU      (autoRecalque)
                E       (automatico)
                EN      (autoDosagem)       
                MEMO    (autoRecalque)

                SEL     (autoRecalque)
                E       (recalqueConcluido)
                EN      (alarmeNivel3)
                OU      (autoDosagem)
                E       (automatico)
                EN      (autoResfriamento)
                MEMO    (autoDosagem)

                SEL     (autoDosagem)
                E       (dosagemConcluida)
                EN      (alarmeNivel3)
                OU      (autoResfriamento)
                E       (automatico)
                EN      (autoAberturaMolde)
                MEMO    (autoResfriamento)

                SEL     (autoResfriamento)
                E       (resfriamentoConcluido)
                EN      (alarmeNivel3)
                OU      (autoAberturaMolde)
                E       (automatico)
                EN      (autoPreAvancamento)
                MEMO    (autoAberturaMolde)

                SEL     (autoAberturaMolde)
                E       (moldeAberto)
                EN      (alarmeNivel3)
                OU      (autoPreAvancamento)
                E       (automatico)
                EN      (autoAvancoExtratorMolde)
                MEMO    (autoPreAvancamento)

                SEL     (autoPreAvancamento)
                E       (moldeAberto)
                EN      (alarmeNivel3)
                OU      (autoAvancoExtratorMolde)
                E       (automatico)
                EN      (autoRecuaExtratorMolde)
                MEMO    (autoAvancoExtratorMolde)

                SEL     (autoAvancoExtratorMolde)
                E       (moldeAberto)
                EN      (alarmeNivel3)
                OU      (autoRecuaExtratorMolde)
                E       (automatico)
                EN      (preAvancamentoConcluido)
                MEMO    (autoRecuaExtratorMolde)


                SEL     (autoRecuaExtratorMolde)
                E       (moldeAberto)
                EN      (alarmeNivel3)
                OU      (preAvancamentoConcluido)
                E       (automatico)
                EN      (autoFimCiclo)
                EN      (preAvancamentoConcluido)


                SEL     (autoPreAvancamento)        
                E       (preAvancamentoConcluido)
                MEMO    (autoFimCiclo)                               


////////////////////////////////////////////////////////////////////////////////////////////////
//Solicitacoes
//////////////////////////////////////////////////////////////////////////////////////////////// 

                //Convencoes:
                //Logica de Selo deve ser realizado somente no COMANDO
                //Sinais de habilitacao de funcoes devem ser usados no SOLIC porem eh necessario atencao a possiveis selos no COMANDO
                //Priorizacao de movimentos opostos devem ser feitas no COMANDO utilizando sinais opostos do SOLIC
                //Retardos de acionamento devem ser tratados no SOLIC

                //*********************************

                SEL     (moldeAberto)
                OU      (auxFechamentoMoldePreAvanco)
                EN      (fim_durFechamentoPreAvancamento)
                E       (autoPreAvancamento)
                MEMO    (auxFechamentoMoldePreAvanco)

                SEL     (auxFechamentoMoldePreAvanco)
                EN      (moldeAberto)
                MEMO    (dsp_durFechamentoPreAvancamento)

                SEL     (fim_durFechamentoPreAvancamento)
                OU      (auxAberturaMoldePreAvanco)
                EN      (moldeAberto)
                MEMO    (auxAberturaMoldePreAvanco)

                //*********************************

                SEL     (autoFechamentoMolde)
                MEMO    (dsp_retFechamentoMolde)

                SEL     (manual)
                E       (botaoFechamentoMolde)
                OU      (fim_retFechamentoMolde)
                OU      (auxFechamentoMoldePreAvanco)       
                MEMO    (solicFechamentoMolde)

                //*********************************

                SEL     (autoAberturaMolde)
                MEMO    (dsp_retAberturaMolde)

                SEL     (manual)
                E       (botaoAberturaMolde)
                EN      (moldeAberto)
                OU      (fim_retAberturaMolde)
                OU      (auxAberturaMoldePreAvanco)
                MEMO    (solicAberturaMolde)

                //*********************************//90280103.1

                SEL     (autoAvancoExtratorMolde)
                MEMO    (dsp_tempoAvancoExtratorMolde)

                SEL     (manual)
                E       (botaoExtrairMolde)
                EN      (moldeFechado)
                OU      (fim_tempoAvancoExtratorMolde)
                OU      (auxAberturaMoldePreAvanco)
                
                MEMO    (solicAvancoExtratorMolde)

               

                SEL     (autoRecuaExtratorMolde)
                OU       (fim_avancoExtratorMolde)
                OU      (auxAberturaMoldePreAvanco)
                EN      (moldeFechado)
                MEMO    (solicRecuaExtratorMolde)

              




                //*********************************


                SEL     (autoPreenchimento)
                MEMO    (dsp_retPreenchimento)

                SEL     (manual)
                E       (botaoInjecao)
                OU      (fim_retPreenchimento)
                OU      (autoRecalque)
                MEMO    (solicInjecao)

                SEL     (fim_retPreenchimento)
                MEMO    (dsp_durPreenchimento)

                SEL     (autoRecalque)
                MEMO    (dsp_durRecalque)

                //*********************************

                SEL     (autoDosagem)
                OU      (autoResfriamento)   
                MEMO    (dsp_durResfriamento)

                //*********************************

                SEL     (autoIntrusao)
                E       (habilitaIntrusao)            
                MEMO    (dsp_retIntrusao)

                SEL     (autoDosagem)
                MEMO    (dsp_retDosagem)

                SEL     (manual)
                E       (botaoDosagem)
                OU      (fim_retDosagem)
                OU      (fim_retIntrusao)
                MEMO    (solicDosagem)

                SEL     (fim_retIntrusao)
                MEMO    (dsp_durIntrusao)

                //*********************************

                SEL     (botaoLigaMotor)
                MEMO    (auxBotaoLigaMotor)

                SEL     (auxBotaoLigaMotor)
                SUBIDA                     
                EN      (comandoLigaMotor) 
                MEMO    (solicLigaMotor)

                SEL     (auxBotaoLigaMotor)
                SUBIDA                    
                E       (comandoLigaMotor)
                MEMO    (solicDesligaMotor)
                
                
////////////////////////////////////////////////////////////////////////////////////////////////
//Alarmes
//////////////////////////////////////////////////////////////////////////////////////////////// 

                SEL     (auxBotaoSelecaoModoManual)
                SUBIDA
                MEMO    (resetAlarme)

                //*********************************
                
                SEL     (solicFechamentoMolde)
                OU      (solicAberturaMolde)
                OU      (solicAvancoExtratorMolde) //90280103.1
                OU      (solicInjecao)
                OU      (solicDosagem)
                OU      (autoPreenchimento)
                OU      (autoRecalque)
                EN      (protetorDiantFechado)
                MEMO    (aux)

                SEL     (alarmeProtetorDiantAberto)
                E       (automatico)
                OU      (aux)
                MEMO    (alarmeProtetorDiantAberto)

                //*********************************

                SEL     (solicInjecao)
                EN      (moldeFechado)
                MEMO    (aux)

                SEL     (alarmeMoldeNaoFechado)
                E       (automatico)
                OU      (aux)
                MEMO    (alarmeMoldeNaoFechado)

                //*********************************

                SEL     (autoPreenchimento)                 
                OU      (autoRecalque)                      
                EN      (moldeFechado)                      
                MEMO    (aux)                               

                SEL     (alarmeDestravouDuranteInjecao)     
                E       (automatico)                        
                OU      (aux)                               
                MEMO    (alarmeDestravouDuranteInjecao)     

                //*********************************

                SEL     (moldeAberto)      
                E       (moldeFechado)
                MEMO    (aux)

                SEL     (alarmeIncongruenciaFCsMolde)
                E       (automatico)
                OU      (aux)
                MEMO    (alarmeIncongruenciaFCsMolde)

                //*********************************
                //Supervisao de movimentos

                SEL     (comandoFechamentoMolde)
                EN      (moldeFechado)
                MEMO    (dsp_tempoSupervFechamentoMolde)

                SEL     (fim_tempoSupervFechamentoMolde)
                OU      (alarmeFechamentoMoldeNaoCompletado)
                EN      (resetAlarme)
                E       (habSupervisaoMovimentos)
                MEMO    (alarmeFechamentoMoldeNaoCompletado)

                SEL     (comandoAberturaMolde)
                EN      (moldeAberto)
                MEMO    (dsp_tempoSupervAberturaMolde)

                SEL     (fim_tempoSupervAberturaMolde)
                OU      (alarmeAberturaMoldeNaoCompletada)
                EN      (resetAlarme)
                E       (habSupervisaoMovimentos)
                MEMO    (alarmeAberturaMoldeNaoCompletada)

                //******************************//90280103.1
                SEL     (comandoAvancoExtratorMolde)
                EN      (moldeFechado)
                MEMO    (dsp_tempoSuperAvancoExtratorMolde)

                SEL     (fim_tempoSuperAvancoExtratorMolde)
                OU      (alarmeExtracaoNaoCompletada)
                EN      (resetAlarme)
                E       (habSupervisaoMovimentos)
                MEMO    (alarmeExtracaoNaoCompletada)
                //******************************             
               
                SEL     (comandoDosagem)
                EN      (dosagemConcluida)
                MEMO    (dsp_tempoSupervDosagem)

                SEL     (fim_tempoSupervDosagem)    
                OU      (alarmeDosagemNaoCompletada)
                EN      (resetAlarme)
                E       (habSupervisaoMovimentos)
                MEMO    (alarmeDosagemNaoCompletada)

                //*********************************

                SEL     (autoFechamentoMolde)
                EN      (dosagemConcluida)
                MEMO    (aux)

                SEL     (alarmeCompletarDosagem)
                E       (automatico)
                OU      (aux)
                MEMO    (alarmeCompletarDosagem)

                //*********************************

                SEL     (autoPreenchimento)         
                SUBIDA                              
                E       (habControleProducao)
                ENTAO_EXECUTA_BLOCO {
                        ciclosRealizadosControleProducao++;   
                }

                SEL     (alarmeControleProducao)
                DESCIDA    
                ENTAO_EXECUTA_BLOCO {                               
                        ciclosRealizadosControleProducao=0;   
                }                                   

                SEL     (ciclosRealizadosControleProducao >= ciclosProgramadosControleProducao)
                MEMO    (concluiuProducao)

                SEL     (habControleProducao)           
                E       (concluiuProducao)         
                OU      (alarmeControleProducao)        
                EN      (resetAlarme)                   
                MEMO    (alarmeControleProducao)

                //**********************************

                LDF     (motorLigado)                       
                MEMO    (alarmeMotorDesligado)              

                //**********************************

                SEL     (autoFechamentoMolde)
                SUBIDA
                MEMO    (resetContagemTempoMaximoDeCiclo)

                SEL     (autoFechamentoMolde)
                OU      (dsp_tempoMaximoCiclo)
                EN      (manual)
                EN      (resetContagemTempoMaximoDeCiclo)
                MEMO    (dsp_tempoMaximoCiclo)

                SEL     (fim_tempoMaximoCiclo)
                MEMO    (alarmeTempoMaxDeCiclo)
                

////////////////////////////////////////////////////////////////////////////////////////////////
//Niveis de alarmes
//////////////////////////////////////////////////////////////////////////////////////////////// 

                SEL     (alarmeControleProducao)
                MEMO    (alarmeNivel2)

                SEL     (alarmeNivel4)
                OU      (alarmeDestravouDuranteInjecao)
                OU      (alarmeCompletarDosagem)
                OU      (alarmeProtetorDiantAberto)                     
                OU      (alarmeMotorDesligado)
                MEMO    (alarmeNivel3)

                SEL     (alarmeIncongruenciaFCsMolde)
                OU      (alarmeFechamentoMoldeNaoCompletado)
                OU      (alarmeAberturaMoldeNaoCompletada)
                OU      (alarmeExtracaoNaoCompletada) //90280103.1
                OU      (alarmeDosagemNaoCompletada)
                MEMO    (alarmeNivel4)


////////////////////////////////////////////////////////////////////////////////////////////////
//Comando
//////////////////////////////////////////////////////////////////////////////////////////////// 

                SEL     (comandoFechamentoMolde)
                E       (moldeFechado)
                OU      (solicFechamentoMolde)
                EN      (alarmeNivel3)
                EN      (solicAberturaMolde)
                MEMO    (comandoFechamentoMolde)
                
                //*********************************

                SEL     (solicAberturaMolde)
                EN      (alarmeNivel3)
                MEMO    (comandoAberturaMolde)

                //*********************************//90280103.1

                SEL     (solicAvancoExtratorMolde)
                EN      (alarmeNivel3)
                MEMO    (comandoAvancoExtratorMolde)

                //*********************************

                SEL     (solicInjecao)
                EN      (alarmeMoldeNaoFechado)
                EN      (alarmeNivel3)
                MEMO    (comandoInjecao)

                //*********************************

                SEL     (solicDosagem)
                EN      (alarmeNivel3)
                MEMO    (comandoDosagem)

                //*********************************

                SEL     (solicLigaMotor)                        
                OU      (comandoLigaMotor)                      
                EN      (solicDesligaMotor)                     
                EN      (alarmeNivel4)       
                MEMO    (comandoLigaMotor)                      

////////////////////////////////////////////////////////////////////////////////////////////////
//SINOPTICO
//////////////////////////////////////////////////////////////////////////////////////////////// 

                sinopticoAuto=0;

                SEL     (autoEsperandoInicioCiclo)
                ENTAO_EXECUTA_BLOCO {
                    sinopticoAuto=1;
                }

                SEL     (autoFechamentoMolde)
                MEMO    (dsp_sinopFechamentoMolde)
                ENTAO_EXECUTA_BLOCO {
                    sinopticoAuto=7;
                    tempoFechamentoMolde=timer_sinopFechamentoMolde.tempoDecorrido();
                }

                SEL     (autoIntrusao)
                MEMO    (dsp_sinopIntrusao)
                ENTAO_EXECUTA_BLOCO {
                    sinopticoAuto=9;
                    tempoIntrusao=timer_sinopIntrusao.tempoDecorrido();
                }

                SEL     (autoPreenchimento)
                MEMO    (dsp_sinopPreenchimento)
                ENTAO_EXECUTA_BLOCO {
                    tempoPreenchimento=timer_sinopPreenchimento.tempoDecorrido();
                    sinopticoAuto=10;
                }

                SEL     (autoRecalque)
                MEMO    (dsp_sinopRecalque)
                ENTAO_EXECUTA_BLOCO {
                    tempoRecalque=timer_sinopRecalque.tempoDecorrido();
                    sinopticoAuto=11;
                }

                SEL     (autoDosagem)
                MEMO    (dsp_sinopDosagemDesc)
                ENTAO_EXECUTA_BLOCO {
                    tempoDosagemDesc=timer_sinopDosagemDesc.tempoDecorrido();
                    sinopticoAuto=14;
                }

                SEL     (autoResfriamento)
                MEMO    (dsp_sinopResfriamento)
                IF1     ENTAO_EXECUTA_BLOCO {
                    tempoResfriamento=timer_sinopResfriamento.tempoDecorrido();
                    sinopticoAuto=17;
                }
                
                SEL     (autoAberturaMolde)
                MEMO    (dsp_sinopAberturaMolde)
                IF1     ENTAO_EXECUTA_BLOCO {
                    tempoAberturaMolde=timer_sinopAberturaMolde.tempoDecorrido();
                    sinopticoAuto=18;
                }

                SEL     (autoAvancoExtratorMolde) //nia
                MEMO    (dsp_sinopAvancoExtratorMolde)
                IF1     ENTAO_EXECUTA_BLOCO {
                    tempoAvancoExtratorMolde=timer_sinopAberturaMolde.tempoDecorrido();
                    sinopticoAuto=19;
                }

                SEL     (autoFimCiclo)
                IF1     ENTAO_EXECUTA_BLOCO {
                    sinopticoAuto=20;
                }

                SEL     (dsp_retReciclo)
                EN      (fim_retReciclo)
                MEMO    (dsp_sinopReciclo)
                ENTAO_EXECUTA_BLOCO {
                    tempoReciclo=timer_sinopReciclo.tempoDecorrido();
                    sinopticoAuto=21;
                }

                SEL     (autoPreAvancamento)    
                IF1     ENTAO_EXECUTA_BLOCO {
                    sinopticoAuto=22;
                }

                SEL     (dsp_tempoMaximoCiclo)
                ENTAO_EXECUTA_BLOCO {
                    durTempoCicloAtual=timer_tempoMaximoCiclo.tempoDecorrido();
                }
                
                SEL     (dsp_tempoMaximoCiclo)
                DESCIDA
                ENTAO_EXECUTA_BLOCO {
                    durTempoCicloAnterior=timer_tempoMaximoCiclo.tempoDecorrido();
                }

////////////////////////////////////////////////////////////////////////////////////////////////
//GERAIS
//////////////////////////////////////////////////////////////////////////////////////////////// 

                //RECICLO

                SEL     (autoFimCiclo)
                EN      (semiAutomatico)
                MEMO    (dsp_retReciclo)

                SEL     (fim_retReciclo)
                MEMO    (reciclo)


                //Contador de ciclos

                SEL     (autoPreenchimento)
                SUBIDA
                ENTAO_EXECUTA_BLOCO {
                        contadorDeCiclos++;
                        contadorParcialDeCiclos++;
                }

                SEL     (zeraContadorParcial)
                ENTAO_EXECUTA_BLOCO {
                        zeraContadorParcial=0;
                        contadorParcialDeCiclos=0;
                }

                //Ajuste de hora

                if (cic1)
                    obterHorarioRTC(&hora,&minuto,&segundo);


                if (hora!=ultimaHora || minuto!=ultimoMinuto || segundo!=ultimoSegundo) {
                    atualizarHorarioRTC(hora,minuto,segundo);
                }

                obterHorarioRTC(&hora,&minuto,&segundo);
                ultimaHora=hora;
                ultimoMinuto=minuto;
                ultimoSegundo=segundo;

                //Tela de apresentacao

                SEL     (cic1)
                SUBIDA
                OU      (dsp_durTelaApresentacao)
                EN      (fim_durTelaApresentacao)
                MEMO    (dsp_durTelaApresentacao)

                SEL     (fim_durTelaApresentacao)
                SUBIDA
                IF1     {
                    acionaAtalho(315);
                }

