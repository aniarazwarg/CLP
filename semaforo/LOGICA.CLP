////////////////////////////////////////////////////////////////////////////////////////////////
//MODO DE OPERACAO
//////////////////////////////////////////////////////////////////////////////////////////////// 


////////////////////////////////////////////////////////////////////////////////////////////////
//SEQUENCIADOR AUTOMATICO
//////////////////////////////////////////////////////////////////////////////////////////////// 


////////////////////////////////////////////////////////////////////////////////////////////////
//Solicitacoes
//////////////////////////////////////////////////////////////////////////////////////////////// 

                
////////////////////////////////////////////////////////////////////////////////////////////////
//Alarmes
//////////////////////////////////////////////////////////////////////////////////////////////// 


////////////////////////////////////////////////////////////////////////////////////////////////
//Comando
//////////////////////////////////////////////////////////////////////////////////////////////// 
 SEL(entradaSensorPresenca) //se sensor ligado
    DESCIDA
    MEMO(auxDisparaTemporizador) //liga temporizador total

    SEL(auxDisparaTemporizador)
    OU  (dsp_temporizadorLampada)
    EN(entradaSensorPresenca)
    EN (fim_temporizadorLampada)
    MEMO(dsp_temporizadorLampada)

    SEL(dsp_temporizadorLampada1)
    OU(entradaSensorPresenca)
    MEMO(saidaLampada1)

////////////////////////////////////////////////////////////////////////////////////////////////
//SINOPTICO
//////////////////////////////////////////////////////////////////////////////////////////////// 


