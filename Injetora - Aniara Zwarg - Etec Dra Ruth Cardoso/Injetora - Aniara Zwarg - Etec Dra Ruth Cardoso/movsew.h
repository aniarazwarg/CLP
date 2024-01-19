#include <bios.h>

//bcv03r60.5 void atualizaParametrosEscrita_MOVSEWBRANQS(); //bcv03r60.4
void atualizaParametros_MOVSEWBRANQS(); //bcv03r60.4   //bcv03r60.5
int inicializa_MOVSEWBRANQS(int _portaSerial,int _numeroBits,int _paridade,int _numeroStopBits,int _baudRate,int _timeout); //bcv03r60.4
//bcv03r61.7 int registraParametroEscrita_MOVSEWBRANQS(int * imagemVariavelCLP,int *_variavelCLP,int _enderecoServo,int _idTabelaSEW); //bcv03r60.4
int registraParametroEscrita_MOVSEWBRANQS(long long * _imagemVariavelCLP,long long * _variavelCLP,int _enderecoServo,int _idTabelaSEW); //bcv03r60.4 //bcv03r61.7
//bcv03r61.7 char registraParametroLeitura_MOVSEWBRANQS(int * _variavelCLPposicao, int * _variavelCLPtorque,int _enderecoServo); //bcv03r60.5
char registraParametroLeitura_MOVSEWBRANQS(long long * _variavelCLPposicao, long long * _variavelCLPtorque,int _enderecoServo); //bcv03r60.5 //bcv03r61.7
void forcaEnvioDeTodosParametrosDeEscritaParaServo(); //bcv03r60.A


