               
////////////////////////////////////////////////////////////////////////////////////////////////
//MODO DE OPERACAO
//////////////////////////////////////////////////////////////////////////////////////////////// 

                SEL     (automatico)
                EN      (teclaSelecaoModoManual)
                OU      (teclaSelecaoModoAutomatico)
                MEMO    (automatico)

                SED     (automatico)
                MEMO    (manual)

                modoOperacao=0;                     //0=Manual, 1=Automatico

                SEL     (automatico)
                ENTAO_EXECUTA_BLOCO {
                    modoOperacao=1;
                }


////////////////////////////////////////////////////////////////////////////////////////////////
//SEQUENCIADOR AUTOMATICO
//////////////////////////////////////////////////////////////////////////////////////////////// 


////////////////////////////////////////////////////////////////////////////////////////////////
//Solicitacoes
//////////////////////////////////////////////////////////////////////////////////////////////// 


//Recuo do cilindro

                SEL     (teclaRecuaCilindro)
                E       (manual)
                MEMO    (solicRecuaCilindro)


//Avanco do cilindro

                SEL     (teclaAvancaCilindro)
                E       (manual)
                MEMO    (solicAvancaCilindro)


//Liga motor da esteira
                
                SEL     (teclaLigaMotorEsteira)
                E       (manual)
                MEMO    (solicLigaMotorEsteira)


//Desliga motor da esteira

                SEL     (teclaDesligaMotorEsteira)
                MEMO    (solicDesligaMotorEsteira)

                
////////////////////////////////////////////////////////////////////////////////////////////////
//Alarmes
//////////////////////////////////////////////////////////////////////////////////////////////// 

//Alarme cilindro recuado

                SEL     (solicRecuaCilindro)
                E       (cilindroRecuado)
                E       (manual)
                MEMO    (alarmeCilindroRecuado)

//Alarme cilindro nao recuado

                SEL     (solicLigaMotorEsteira)
                EN      (cilindroRecuado)
                MEMO    (alarmeCilindroNaoRecuado)

//Tentativa de operacao manual em automatico
            
                SEL     (teclaRecuaCilindro)
                OU      (teclaAvancaCilindro)
                OU      (teclaLigaMotorEsteira)
                E       (automatico)
                MEMO    (alarmeTentativaOperacaoManualEmAutomatico)

//Niveis de alarmes

                SEL     (alarmeCilindroRecuado)
                OU      (alarmeCilindroNaoRecuado)
                OU      (alarmeTentativaOperacaoManualEmAutomatico)
                MEMO    (alarmeNivel1)                                  //Somente informativo

                SEL     (0)
                MEMO    (alarmeNivel2)                                  //Impede o inicio de um novo ciclo automatico

                SEL     (0)
                MEMO    (alarmeNivel3)                                  //Desliga o motor

                SEL     (0)
                OU      (alarmeNivel3)
                MEMO    (alarmeNivel4)                                  //Impede realizacao de todas as funcoes

////////////////////////////////////////////////////////////////////////////////////////////////
//Comando
//////////////////////////////////////////////////////////////////////////////////////////////// 

//Recuo do cilindro

                SEL     (solicRecuaCilindro)
                EN      (alarmeCilindroRecuado)
                EN      (alarmeNivel4)
                MEMO    (comandoRecuaCilindro)

//Avanco do cilindro

                SEL     (solicAvancaCilindro)
                EN      (alarmeNivel4)
                MEMO    (comandoAvancaCilindro)

//Motor esteira

                SEL     (solicLigaMotorEsteira)
                OU      (comandoLigaMotorEsteira)
                EN      (alarmeCilindroNaoRecuado)
                EN      (solicDesligaMotorEsteira)
                EN      (alarmeNivel4)
                MEMO    (comandoLigaMotorEsteira)

////////////////////////////////////////////////////////////////////////////////////////////////
//SINOPTICO
//////////////////////////////////////////////////////////////////////////////////////////////// 

                sinoptico=0;

                SEL     (autoEsperandoStart)
                ENTAO_EXECUTA_BLOCO {
                     sinoptico=1;
                }
                
                SEL     (autoRecuaCilindro)
                ENTAO_EXECUTA_BLOCO {
                    sinoptico=2;
                }

                SEL     (autoLigaMotorEsteira)
                ENTAO_EXECUTA_BLOCO {
                    sinoptico=3;
                }

                SEL     (autoAvancaCilindro)
                ENTAO_EXECUTA_BLOCO {
                    sinoptico=4;
                }

                SEL     (autoFimCiclo)
                ENTAO_EXECUTA_BLOCO {
                    sinoptico=5;
                }

