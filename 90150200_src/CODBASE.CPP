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

SINAL_DIGITAL(cic1)

void inicializa_CLP() {
        cic1=1;
}

void finaliza_CLP() {
}

void clp() {
       
        atuEnt();
        verificaTemporizadores();

        #include "ENTRADA.CLP"

        realizaLinearizacoesAutomaticas();
        realizaConversoesDeEscala();
        trataEntradasVirtuais();                                

        #include "LOGICA.CLP"

        verificaAlarmes();
        realizaLinearizacoesAutomaticas();
        realizaConversoesDeEscala();

        #include "SAIDA.CLP"

        atuSai();
        cic1=0;
}
