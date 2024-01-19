///////////////////////////////////////////////////////////////////////////////////////////////
//Arquivo:      CODBASE.CPP
//Descricao:    Definicao da estrutura base do software CLP
//
//Observacoes:  Este arquivo e´ fornecido como parte da biblioteca do Framework CLP branqs
//              Cuidado, pois alteracoes neste codigo sao sobrepostas ao realizar a
//              atualizacao da biblioteca.
//
//Origem:       bcv03r28.5
///////////////////////////////////////////////////////////////////////////////////////////////

#include "clp.h"
#include "DECLARA.CLP"

//bcv03r34.3 CAMPO_INT(programa)
//bcv03r34.3 CAMPO_INT(versao)
//bcv03r34.3 CAMPO_INT(revisao)

CAMPO_INT_CONFINT(programa)     //bcv03r34.3
CAMPO_INT_CONFINT(versao)       //bcv03r34.3
CAMPO_INT_CONFINT(revisao)      //bcv03r34.3

SINAL_DIGITAL(aux)              
SINAL_DIGITAL(cic1)

void inicializa_CLP() {
        cic1=1;
}

void finaliza_CLP() {
}

void clp() {
       
        atuEnt();
        //bcv03r39.4 verificaTemporizadores();

        #include "ENTRADA.CLP"

        realizaLinearizacoesAutomaticas();
        realizaConversoesDeEscala();
        realizaConversoesDeEscalaLONG();            //bcv03r61.7
        trataEntradasVirtuais();                                

        #include "LOGICA.CLP"

        verificaAlarmes();
        realizaLinearizacoesAutomaticas();
        realizaConversoesDeEscala();
        realizaConversoesDeEscalaLONG();            //bcv03r61.7
//bcv03r60.5        atualizaParametrosEscrita_MOVSEWBRANQS();           //bcv03r60.4
//bcv03r68.E_t4        atualizaParametros_MOVSEWBRANQS();           //bcv03r60.4   //bcv03r60.5

        #include "SAIDA.CLP"

        atuSai();
        cic1=0;
}
