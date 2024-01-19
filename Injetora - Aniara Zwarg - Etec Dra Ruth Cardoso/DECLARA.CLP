////////////////////////////////////////////////////////////////////////////////////////////////
//Historico de revisoes
////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////
//Programa:     9028
//Versao:       03
//Revisao       01
//Data:         14/03/2023
//Autor:        
//Descricao:    Refactoring do programa da Injetora do Clube do Plastico para o
//              Curso Preparatorio Estagio Branqs
//
//90280103.0    Modificado o numero de versao e revisao no software
//90280103.1    Versão alterada por Aniara, incluído extrator automaticoe  sensor de extrator recuado.

///////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Entradas digitais
////////////////////////////////////////////////////////////////////////////////////////////////

        CAMPO_ENTRADA_DIGITAL(sensorProtetorDiantFechado)
        CAMPO_ENTRADA_DIGITAL(sensorMoldeAberto)              
        CAMPO_ENTRADA_DIGITAL(sensorAmortecimentoAbertura)    
        CAMPO_ENTRADA_DIGITAL(sensorAmortecimentoFechamento)    
        CAMPO_ENTRADA_DIGITAL(sensorMaquinaTravada)             
        CAMPO_ENTRADA_DIGITAL(sensorFimDosagem)                 
        CAMPO_ENTRADA_DIGITAL(sensorPassagemParaRecalque)       
        CAMPO_ENTRADA_DIGITAL(sensorExtratorRecuado)

////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Saidas digitais
////////////////////////////////////////////////////////////////////////////////////////////////

        CAMPO_SAIDA_DIGITAL(saidaLigaMotor)
        CAMPO_SAIDA_DIGITAL(saidaFechamentoMolde)
        CAMPO_SAIDA_DIGITAL(saidaInjecao)
        CAMPO_SAIDA_DIGITAL(PWM_VazaoProporcional)
        CAMPO_SAIDA_DIGITAL(saidaDosagem)
        CAMPO_SAIDA_DIGITAL(saidaAberturaMolde)
        CAMPO_SAIDA_DIGITAL(saidaAvancoExtrator)
        CAMPO_SAIDA_DIGITAL(saidaRecuaExtrator)
    
////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Entradas analogicas
////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Saidas analogicas
////////////////////////////////////////////////////////////////////////////////////////////////

        CAMPO_SAIDA_PWM(vazaoProporcional)

////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Entradas de temperatura
//////////////////////////////////////////////////////////////////////////////////////////////// 


////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Botoes na IHM
//////////////////////////////////////////////////////////////////////////////////////////////// 

        CAMPO_BOTAO_IHM(botaoInjecao,tecla_I)
        CAMPO_BOTAO_IHM(botaoDosagem,tecla_D)
        CAMPO_BOTAO_IHM(botaoAberturaMolde,tecla_A) 
        CAMPO_BOTAO_IHM(botaoExtrairMolde,tecla_E) //90280103.1
        CAMPO_BOTAO_IHM(botaoFechamentoMolde,tecla_F)    
        CAMPO_BOTAO_IHM(botaoSelecaoModoManut,tecla_N)
        CAMPO_BOTAO_IHM(botaoSelecaoModoManual,tecla_M)
        CAMPO_BOTAO_IHM(botaoSelecaoModoSemi,tecla_K)
        CAMPO_BOTAO_IHM(botaoSelecaoModoAuto,tecla_O)
        CAMPO_BOTAO_IHM(botaoLigaMotor,tecla_L)
        CAMPO_BOTAO_IHM(botaoStart,tecla_S)

////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Campos e variaveis organizados por funcao
////////////////////////////////////////////////////////////////////////////////////////////////

        //Gerais
        ////////

        CAMPO_INT(modoOperacao)
           
        SINAL_DIGITAL(manual)
        SINAL_DIGITAL(semiAutomatico)

        SINAL_DIGITAL(auxBotaoSelecaoModoManual)

        extern char nivelProtecaoAtivo;         
        CAMPO_INT(nivelProtecaoCorrente)        
    
        CAMPO_INT_RECEITA(durResfriamento)
        TEMPORIZADOR(durResfriamento,durResfriamento)

        SINAL_DIGITAL(resfriamentoConcluido)

        CAMPO_INT(retInicializacao)
        TEMPORIZADOR(retInicializacao,retInicializacao)

        //Sinoptico

        CAMPO_INT(sinopticoAuto)

        CAMPO_INT_RECEITA(tempoResfriamento)

        CAMPO_INT(sinopResfriamento)
        TEMPORIZADOR(sinopResfriamento,sinopResfriamento)

        //Linearizacao de vazao

        //  vazaoPropProgramada
        //          ||
        //          || linearizadorVazao
        //          \/
        //  vazaoPropLinearizada
        //          ||
        //          || convVazaoBit
        //          \/
        //  vazaoPropEmBit
        
        CAMPO_INT(vazaoPropProgramada)
        CAMPO_INT(vazaoPropLinearizada)

        CAMPO_INT_CONFINT(x0_Vazao)           
        CAMPO_INT_CONFINT(x1_Vazao)           
        CAMPO_INT_CONFINT(x2_Vazao)           
        CAMPO_INT_CONFINT(x3_Vazao)           
        CAMPO_INT_CONFINT(x4_Vazao)           
        CAMPO_INT_CONFINT(x5_Vazao)           
        CAMPO_INT_CONFINT(x6_Vazao)           
        CAMPO_INT_CONFINT(x7_Vazao)           
        CAMPO_INT_CONFINT(x8_Vazao)           
        CAMPO_INT_CONFINT(x9_Vazao)           

        CAMPO_INT_CONFINT(y0_Vazao)           
        CAMPO_INT_CONFINT(y1_Vazao)           
        CAMPO_INT_CONFINT(y2_Vazao)           
        CAMPO_INT_CONFINT(y3_Vazao)           
        CAMPO_INT_CONFINT(y4_Vazao)           
        CAMPO_INT_CONFINT(y5_Vazao)           
        CAMPO_INT_CONFINT(y6_Vazao)          
        CAMPO_INT_CONFINT(y7_Vazao)           
        CAMPO_INT_CONFINT(y8_Vazao)           
        CAMPO_INT_CONFINT(y9_Vazao)
   
        LINEARIZADOR_AUTOMATICO_10PONTOS(linearizadorVazao,vazaoPropProgramada,vazaoPropLinearizada,x0_Vazao,
                                                                                                    x1_Vazao,
                                                                                                    x2_Vazao,
                                                                                                    x3_Vazao,
                                                                                                    x4_Vazao,
                                                                                                    x5_Vazao,
                                                                                                    x6_Vazao,
                                                                                                    x7_Vazao,
                                                                                                    x8_Vazao,
                                                                                                    x9_Vazao,
                                                                                                    y0_Vazao,
                                                                                                    y1_Vazao,
                                                                                                    y2_Vazao,
                                                                                                    y3_Vazao,
                                                                                                    y4_Vazao,
                                                                                                    y5_Vazao,
                                                                                                    y6_Vazao,
                                                                                                    y7_Vazao,
                                                                                                    y8_Vazao,
                                                                                                    y9_Vazao);

        CAMPO_INT(vazaoPropEmBit)
        #define MAX_VAZ_BIT 1023
        CONVERSOR_ESCALA(convVazaoBit,vazaoPropLinearizada,vazaoPropEmBit,0,100,0,MAX_VAZ_BIT);

        //Teste de saidas analogicas

        CAMPO_SINAL_DIGITAL(habTesteSaidasAnalogicas)

        CAMPO_INT(auxVazao)
        
        SINAL_DIGITAL(resetAlarme)

        SINAL_DIGITAL(auxBotaoLigaMotor)
        SINAL_DIGITAL(solicLigaMotor)
        SINAL_DIGITAL(comandoLigaMotor)
        SINAL_DIGITAL(solicDesligaMotor)
        SINAL_DIGITAL(motorLigado)

        SINAL_DIGITAL(protetorDiantFechado)

        //Ajuste de hora

        CAMPO_INT(hora)
        CAMPO_INT(minuto)
        CAMPO_INT(segundo)

        CAMPO_INT(ultimaHora)
        CAMPO_INT(ultimoMinuto)
        CAMPO_INT(ultimoSegundo)

        //Tela de apresentacao

        CAMPO_INT(durTelaApresentacao)
        TEMPORIZADOR(durTelaApresentacao,durTelaApresentacao)

        //Ciclo
        ///////

        CAMPO_INT(durTempoCicloAnterior)
        CAMPO_INT(durTempoCicloAtual)

        CAMPO_INT_RECEITA(retReciclo)
        TEMPORIZADOR(retReciclo,retReciclo)

        CAMPO_INT_RECEITA(tempoMaximoCiclo)
        TEMPORIZADOR(tempoMaximoCiclo,tempoMaximoCiclo)

        SINAL_DIGITAL(resetContagemTempoMaximoDeCiclo)

        CAMPO_LONG_CONFINT(contadorDeCiclos)
        CAMPO_LONG_CONFINT(contadorParcialDeCiclos)
        CAMPO_CHAR(zeraContadorParcial)

        CAMPO_INT_RECEITA(ciclosProgramadosControleProducao)         
        CAMPO_CHAR_RECEITA(habControleProducao)     
        CAMPO_LONG_CONFINT(ciclosRealizadosControleProducao)

        //Sinoptico

        CAMPO_INT(tempoReciclo)
        CAMPO_INT(sinopReciclo)
        TEMPORIZADOR(sinopReciclo,sinopReciclo)

        SINAL_DIGITAL(concluiuProducao)
        SINAL_DIGITAL(reciclo)

        SINAL_DIGITAL(solicitouStartCiclo)

        //Molde
        ///////

        //Fechamento molde

        CAMPO_INT_RECEITA(vazaoFechamentoMolde)       
        CAMPO_INT_RECEITA(vazaoAmortecFechamMolde)    

        CAMPO_INT_RECEITA(retFechamentoMolde)
        TEMPORIZADOR(retFechamentoMolde,retFechamentoMolde)

        CAMPO_INT_RECEITA(tempoSupervFechamentoMolde)
        TEMPORIZADOR(tempoSupervFechamentoMolde,tempoSupervFechamentoMolde)

        SINAL_DIGITAL(solicFechamentoMolde)
        SINAL_DIGITAL(comandoFechamentoMolde)

        SINAL_DIGITAL(moldeFechado)

        SINAL_DIGITAL(amortecimentoFechamentoMolde)

        //Abertura molde
        
        CAMPO_INT_RECEITA(vazaoAberturaMolde)
        CAMPO_INT_RECEITA(vazaoAmortecAbertMolde)

        CAMPO_INT_RECEITA(retAberturaMolde)
        TEMPORIZADOR(retAberturaMolde,retAberturaMolde)

        CAMPO_INT_RECEITA(tempoSupervAberturaMolde)
        TEMPORIZADOR(tempoSupervAberturaMolde,tempoSupervAberturaMolde)

        SINAL_DIGITAL(solicAberturaMolde)
        SINAL_DIGITAL(comandoAberturaMolde)

        SINAL_DIGITAL(moldeAberto)

        SINAL_DIGITAL(amortecimentoAberturaMolde)

//Avanco Extrator do molde //90280103.1

CAMPO_INT_RECEITA(tempoSuperAvancoExtratorMolde)
        TEMPORIZADOR(tempoSuperAvancoExtratorMolde,tempoSuperAvancoExtratorMolde)

        SINAL_DIGITAL(solicAvancoExtratorMolde)
        SINAL_DIGITAL(comandoAvancoExtratorMolde)

        SINAL_DIGITAL(avancoExtratorMolde)

         SINAL_DIGITAL(solicRecuaExtratorMolde)
         SINAL_DIGITAL(comandoRecuaExtratorMolde)

        SINAL_DIGITAL(recuaExtratorMolde)
        

        

//***********************************************************
                
        //Sinoptico
        
        CAMPO_INT(tempoFechamentoMolde)
        int     sinopFechamentoMolde;
        TEMPORIZADOR(sinopFechamentoMolde,sinopFechamentoMolde)

        CAMPO_INT(tempoAberturaMolde)
        int     sinopAberturaMolde;
        TEMPORIZADOR(sinopAberturaMolde,sinopAberturaMolde)

        CAMPO_INT(tempoAvancoExtratorMolde) //90280103.1
        int     sinopAvancoExtratorMolde;
        TEMPORIZADOR(sinopAvancoExtratorMolde,sinopAvancoExtratorMolde)

        //PreAvancamento

        CAMPO_INT_RECEITA(durFechamentoPreAvancamento)
        TEMPORIZADOR(durFechamentoPreAvancamento,durFechamentoPreAvancamento)

        CAMPO_INT_RECEITA(numeroPreAvancamentosProgramados)
        CAMPO_INT(numeroPreAvancamentosRealizados)

        SINAL_DIGITAL(preAvancamentoConcluido)
        CAMPO_SINAL_DIGITAL(auxFechamentoMoldePreAvanco)
        CAMPO_SINAL_DIGITAL(auxAberturaMoldePreAvanco)

//Injecao
/////////
        //Intrusao

        CAMPO_INT_RECEITA(vazaoIntrusao)

        CAMPO_INT_RECEITA(retIntrusao)
        TEMPORIZADOR(retIntrusao,retIntrusao)
        CAMPO_INT_RECEITA(durIntrusao)
        TEMPORIZADOR(durIntrusao,durIntrusao)

        SINAL_DIGITAL(habilitaIntrusao)

        //Injecao

        CAMPO_INT_RECEITA(vazaoPreenchimento)

        CAMPO_INT_RECEITA(retPreenchimento)
        TEMPORIZADOR(retPreenchimento,retPreenchimento)
        CAMPO_INT_RECEITA(durPreenchimento)
        TEMPORIZADOR(durPreenchimento,durPreenchimento)

        CAMPO_CHAR_RECEITA(habPassagemParaRecalquePorTempo)            

        CAMPO_CHAR_RECEITA(desabilitaInjecao)           
        
        //Recalque

        CAMPO_INT_RECEITA(vazaoRecalque)

        CAMPO_INT_RECEITA(durRecalque)
        TEMPORIZADOR(durRecalque,durRecalque)

        SINAL_DIGITAL(recalqueAtingidoPorPosicao)

        SINAL_DIGITAL(recalqueConcluido)
        
        //Dosagem
        
        CAMPO_INT_RECEITA(vazaoDosagem)

        CAMPO_INT_RECEITA(retDosagem)
        TEMPORIZADOR(retDosagem,retDosagem)
        CAMPO_INT_RECEITA(tempoSupervDosagem)
        TEMPORIZADOR(tempoSupervDosagem,tempoSupervDosagem)

        //Sinoptico

        CAMPO_INT(tempoIntrusao)
        CAMPO_INT(sinopIntrusao)
        TEMPORIZADOR(sinopIntrusao,sinopIntrusao)

        CAMPO_INT(tempoPreenchimento)
        CAMPO_INT(sinopPreenchimento)
        TEMPORIZADOR(sinopPreenchimento,sinopPreenchimento)

        CAMPO_INT(tempoRecalque)
        CAMPO_INT(sinopRecalque)
        TEMPORIZADOR(sinopRecalque,sinopRecalque)

        CAMPO_INT(tempoDosagemDesc)
        CAMPO_INT(sinopDosagemDesc)
        TEMPORIZADOR(sinopDosagemDesc,sinopDosagemDesc)

        SINAL_DIGITAL(solicInjecao)
        SINAL_DIGITAL(comandoInjecao)
        SINAL_DIGITAL(solicDosagem)
        SINAL_DIGITAL(comandoDosagem)

        SINAL_DIGITAL(dosagemConcluida)
        
        SINAL_DIGITAL(preenchimentoConcluido)

        SINAL_DIGITAL(intrusaoConcluida)

//Supervisao de movimentos
//////////////////////////

        CAMPO_CHAR_CONFINT(habSupervisaoMovimentos)
 
////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Entradas digitais virtuais
////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Sequenciamento automatico
////////////////////////////////////////////////////////////////////////////////////////////////

        CAMPO_SINAL_DIGITAL(autoEsperandoInicioCiclo)
        CAMPO_SINAL_DIGITAL(autoFechamentoMolde)
        CAMPO_SINAL_DIGITAL(autoIntrusao)
        CAMPO_SINAL_DIGITAL(autoPreenchimento)
        CAMPO_SINAL_DIGITAL(autoRecalque)
        CAMPO_SINAL_DIGITAL(autoDosagem)
        CAMPO_SINAL_DIGITAL(autoResfriamento)
        CAMPO_SINAL_DIGITAL(autoAberturaMolde)
        CAMPO_SINAL_DIGITAL(autoAvancoExtratorMolde)//90280103.1
        CAMPO_SINAL_DIGITAL(autoRecuaExtratorMolde)//90280103.1
        CAMPO_SINAL_DIGITAL(autoPreAvancamento)
        CAMPO_SINAL_DIGITAL(autoFimCiclo)

////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Alarmes
////////////////////////////////////////////////////////////////////////////////////////////////

         CAMPO_ALARME(alarmeProtetorDiantAberto,"Protetor dianteiro aberto")
         CAMPO_ALARME(alarmeMoldeNaoFechado,"Molde nao fechado")
         CAMPO_ALARME(alarmeDestravouDuranteInjecao,"Destravou fechamento do molde durante injecao")
         CAMPO_ALARME(alarmeIncongruenciaFCsMolde,"Problema nos fins de curso do Molde")
         CAMPO_ALARME(alarmeFechamentoMoldeNaoCompletado,"Fechamento do Molde nao completado")
         CAMPO_ALARME(alarmeAberturaMoldeNaoCompletada,"Abertura do molde nao completada")
         CAMPO_ALARME(alarmeExtracaoNaoCompletada,"Extração do molde nao completada") //nia

         CAMPO_ALARME(alarmeDosagemNaoCompletada,"Dosagem nao completada")
         CAMPO_ALARME(alarmeTempoMaxDeCiclo,"Tempo maximo de ciclo excedido")
         CAMPO_ALARME(alarmeCompletarDosagem,"Completar curso de dosagem manualmente");
         CAMPO_ALARME(alarmeControleProducao,"Producao atingida");     
         CAMPO_ALARME(alarmeMotorDesligado,"Motor desligado")              

        //Niveis de alarme

        SINAL_DIGITAL(alarmeNivel1)         //Informativo
        SINAL_DIGITAL(alarmeNivel2)         //Impede inicio do ciclo em automatico
        SINAL_DIGITAL(alarmeNivel3)         //Interrompe todos os movimentos
        SINAL_DIGITAL(alarmeNivel4)         //Desliga motor

