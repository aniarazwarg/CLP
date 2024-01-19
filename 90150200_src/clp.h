#include "stdio.h"
#include "lineariz.h"
#include "graftend.h"   //bcv03r22.2
#include "camel.h"  //bcv03r22.3

//Prototipos
int registraCampo(char *ds, void *end,char tipoCampo);
int registraSaidaDigital(char *nomeSaidaDigital,char *enderecoSaidaDigital);
int registraSaidaDigitalEstendida(char *nomeSaidaDigital,char *enderecoSaidaDigital); //bcv03r24.2
int registraEntradaDigital(char *nomeEntradaDigital,char *enderecoEntradaDigital);
int registraEntradaDigitalBC4SA(char *nomeEntradaDigitalBC4SA,char *enderecoEntradaDigitalBC4SA); //bcv03r06.2
int registraEntradaAnalogica(char *nomeEntradaAnalogica,int *enderecoEntradaAnalogica);
int registraSaidaAnalogica(char *nomeSaidaAnalogica,int *enderecoSaidaAnalogica);
int registraSaidaPWM(char *nomeSaidaPWM,int *enderecoSaidaPWM);
int registraEntradaTemperatura(char *nomeEntradaTemperatura,int *enderecoEntradaTemperatura,char _tipoTermoparCanalBC4TP);
int registraEntradaVirtual(char *nomeEntradaVirtual,char *endEntradaVirtual,int *endSetPoint,int *endValorReferencia,int isterese);
//bcv03r00.9 int registraEntradaPeriodo(char *nomeEntradaPeriodo,long *enderecoEntradaPeriodo);
//bcv03r00.9 int registraEntradaEncoder(char *nomeEntradaEncoder,int *enderecoEntradaEncoder); //bcv02r08.1
int registraEntradaEspecial(char *nomeEntradaEspecial, void *enderecoEntradaEspecial,int tipoEntradaEspecial); //bcv03r00.9
//bcv03r00.B int registraBotaoVirtual(char scanCode,char *endBotaoVirtual);
int registraEntradaContador(char *nomeEntradaContador,int *enderecoEntradaContador);
int registraBotaoIHM(char *nomeBotaoIHM,char *enderecoBotaoIHM,char scanCode); //bcv03r00.B
char obtemEstadoSaidaDigital(int placa,int posicao);                  //bcv03r14.3
void registraLog(char *arquivo, char *evento);
char registraAlarme(char *enderecoAlarme,char *stringAlarme);
void finalizaEntradasTemperatura();
void atuEnt();
void atuSai();
void verificaTemporizadores();
void realizaConversoesDeEscala();
void trataEntradasVirtuais();                   //bcv02r07.1
unsigned char verificaProtecaoSoftware(char *preFeed, long senhaConfigurada); //bcv03r16.2
void incrementaNumeroOcorrenciasProtecaoSoftware(); //bcv03r16.2
void acionaAtalho(int numeroAtalho);            //bcv03r18.4

//bcv03r08.3 char realizouColdStart();
char realizouColdStart(int numeroSoftware); //bcv03r08.3 

void solicitaGravacaoParametros();
void print(int c,int l,char *string,int cor);
void verificaAlarmes();
char verificaAlteracaoParametros();

void obterHorarioRTC(int *hora,int *minuto,int *segundo);
void obterDataRTC(int *dia,int *mes,int *ano);
void atualizarHorarioRTC(int hora,int minuto,int segundo);
void atualizarDataRTC(int dia,int mes,int ano);
void obterStrHorarioRTC(char *horario);
void obterStrDataRTC(char *data);

void registraAlarmeNoLog(int idMaq,char *enderecoAlarme,char *evento);

void habilitaPagina(char *nomePagina);                    //bcv03r02.2
void desabilitaPagina(char *nomePagina);                  //bcv03r02.2

void bloqueiaIHM();         //bcv03r20.4
void desbloqueiaIHM();      //bcv03r20.4

//bcv03r08.2 Inicio do bloco

/****************************************************************
 * Temporizadores
 ****************************************************************/

class TemporizadorPai {
    public:
        virtual void verificaTemporizador();
};

/****************************************************************
 * Temporizador
 ****************************************************************/

class Temporizador : public TemporizadorPai {
public:
        char *dsp;
        char *fim;
        int *prog;
        int contagem;

        Temporizador(char *endDisparo,char *endTermino,int *endTempoProg);
        void verificaTemporizador();
        int tempoDecorrido();
};

/****************************************************************
 * Temporizador de minuto
 ****************************************************************/

class TemporizadorDeMinuto : public TemporizadorPai {
public:
        //Atributos
        char *dsp;
        char *fim;
        int *prog;
        int contagem;

        int umMinuto;
        char dspUmMinuto;
        char fimUmMinuto;
        Temporizador *timerUmMinuto;

        //Metodos
        TemporizadorDeMinuto(char *endDisparo,char *endTermino,int *endTempoProg);
        void verificaTemporizador();
        int TemporizadorDeMinuto::tempoDecorrido();
};

//bcv03r08.2 Fim do bloco

//bcv03r08.2 class Temporizador {
//bcv03r08.2 public:
//bcv03r08.2         char *dsp;
//bcv03r08.2         char *fim;
//bcv03r08.2         int *prog;
//bcv03r08.2         int contagem;
//bcv03r08.2 
//bcv03r08.2         Temporizador(char *endDisparo,char *endTermino,int *endTempoProg);
//bcv03r08.2         void verificaTemporizador();
//bcv03r08.2         int tempoDecorrido();
//bcv03r08.2 };

class PID {

        double kp;
        double ki;
        double kd;
        double timeSample;

        double erroPercentualAcumulado;
        double erroPercentualAnterior;

        char primeiroCiclo;
public:
        PID(double _kp,double _ki,double _kd,double _timeSample);
        double calculaPID(double _erroPercentual);
        void reprogramaPID(double _kp,double _ki,double _kd,double _timeSample);
};

class ConversorEscala {
public:
        float coeficienteAngular;
        float constanteLinear;
        int* entradaOriginal;
        int* saidaConvertida;

        ConversorEscala(int* entrada,int* saida,int minimoEntrada, int maximoEntrada, int minimoSaida, int maximoSaida);
        void reconfiguraConversor(int minimoEntrada, int maximoEntrada, int minimoSaida, int maximoSaida);
        void converteEscala();
};

/****************************************************************
 * Programador de parison                                       *
 ****************************************************************/

#define NUMEROPONTOSPROGRAMADOR 75

class ProgramadorDeParison {

        int pontos[NUMEROPONTOSPROGRAMADOR]; //Array de valores entre 0 e 100.0%
        char pontosMaster[NUMEROPONTOSPROGRAMADOR];
        char programaAlterado;
        int peso;
        int escala;
        int *campoPontoProgramador; //Campo de programacao do ponto do programador rev00.6
        int *campoValorPonto; //rev00.6
        int pontoProgramadoNaSaida;     //bcv03r03.2 Representa o ponto sendo aplicado ao programador de parison
        int posicaoReal;                //bcv03r03.2 Representa a posicao real do parison obtido pela entrada
        int posicoesReais[NUMEROPONTOSPROGRAMADOR]; //bcv03r03.2
//bcv03r19.3        char tipoMalhaDoControle;       //bcv03r03.2  0=aberta 1=fechada
//        int tensaoAplicadaNaSaida;      //bcv03r19.2
        int tensoesAplicadasNaSaida[NUMEROPONTOSPROGRAMADOR]; //bcv03r19.2
        char flagPlotagemCurvaTensaoAplicadaNaSaida; //bcv03r19.2
        char flagPlotagemCurvaPosicaoReal; //bcv03r19.3   

public:
        ProgramadorDeParison(char *idCampo,void *endCampo,int *endCampoPontoProgramador,int *endCampoValorPonto); //rev00.6
        int obterValorEmPonto(int ponto);
        int obterSaidaEmPonto(int ponto);
        char obterStatusPontoMaster(int ponto);
        void alteraValorPonto(int ponto, int novoValor);
        void alteraPontoMaster(int ponto,char novoEstado);
        void alteraPeso(int novoPeso);
        void alteraEscala(int novaEscala);
        int obterSaidaPorTempo(int tempoDecorrido,int cadenciometro);
        void realizaInterpolacao();
        char alterouPrograma();
        void gravaPontosArquivo(char *,FILE *);
//bcv03r19.7        void lePontosArquivo(FILE *);
        int lePontosArquivo(FILE *); //bcv03r19.7
        void ProgramadorDeParison::alteraCampoPontoProgramador(int novoPonto); //rev00.6
        void ProgramadorDeParison::alteraCampoValorProgramador(int novoValor); //rev00.6
        int ProgramadorDeParison::obtemConteudoCampoPontoProgramador(); //rev00.6
        int ProgramadorDeParison::obtemPontoProgramadoNaSaida();       //bcv03r03.2
        void ProgramadorDeParison::registraPosicaoReal(int posicaoRealParison);              //bcv03r03
        int ProgramadorDeParison::obtemPosicaoReal(); //bcv03r03.2
        int ProgramadorDeParison::obtemPosicaoRealArmazenada(int ponto); //bcv03r03.2
//bcv03r19.3        void defineTipoMalhaControle(char tipoMalhaControle); //bcv03r03.2
//bcv03r19.3        char obtemTipoMalhaControle(); //bcv03r03.2

        void ProgramadorDeParison::registraTensaoAplicadaNaSaida(int tensaoAplicadaNaSaida); //bcv03r19.2
//        int ProgramadorDeParison::obtemTensaoAplicadaNaSaida(); //bcv03r19.2
        int ProgramadorDeParison::obtemTensaoAplicadaNaSaida(int ponto); //bcv03r19.2
        char ProgramadorDeParison::plotagemCurvaTensaoAplicadaNaSaidaHabilitada(); //bcv03r19.2
        void ProgramadorDeParison::habilitaPlotagemCurvaTensaoAplicadaNaSaida(); //bcv03r19.2
        void ProgramadorDeParison::desabilitaPlotagemCurvaTensaoAplicadaNaSaida(); //bcv03r19.2
        
        void ProgramadorDeParison::habilitaPlotagemCurvaPosicaoReal(); //bcv03r19.3
        void ProgramadorDeParison::desabilitaPlotagemCurvaPosicaoReal(); //bcv03r19.3
        char ProgramadorDeParison::plotagemCurvaPosicaoRealHabilitada(); //bcv03r19.3 


};

/****************************************************************
 * AgendamentoSemanal //bcv03r04.2
 ****************************************************************/

class AgendamentoSemanal {

        int horasProgramadas[7];
        int minutosProgramados[7];
        char habilitacoes[7];

public:
        AgendamentoSemanal();

        void programaAgenda(    char habDomingo,int horaDomingo,int minutoDomingo,
                                char habSegunda,int horaSegunda,int minutoSegunda,
                                char habTerca,int horaTerca,int minutoTerca,
                                char habQuarta,int horaQuarta,int minutoQuarta,
                                char habQuinta,int horaQuinta,int minutoQuinta,
                                char habSexta,int horaSexta,int minutoSexta,
                                char habSabado,int horaSabado,int minutoSabado);

        char verificaAtivacao();
        unsigned char AgendamentoSemanal::obterDiaDaSemana();

};


/****************************************************************
 * Gerenciador de prioridades //bcv03r20.2
 ****************************************************************/

enum prioridades {PRIORIDADE_ABAIXO_NORMAL,PRIORIDADE_NORMAL,PRIORIDADE_ACIMA_NORMAL};

#define NUMERO_MAXIMO_SINAIS 224
// 224 corresponde a 16x8S 16x8E 64xTP 64xEA 64xSA

class GerenciadorDePrioridades {

        void *sinaisRegistrados[NUMERO_MAXIMO_SINAIS];
        char flagExecutouNoCicloAtual[NUMERO_MAXIMO_SINAIS];
        int prioridadeSinais[NUMERO_MAXIMO_SINAIS];
        int qtdSinaisRegistrados;
        char executouAlgumSinalPrioridadeNormal;
        char executouAlgumSinalPrioridadeAbaixoNormal;

public:

        GerenciadorDePrioridades();
        void registraSinal(void *endereco);
        int encontraIndiceSinal(void *end);
        void definePrioridade(void *end,int novaPrioridade);
        char existeSinalComPrioridadeAcimaNormal();
        char existeSinalComPrioridadeAbaixoNormal();
        char execucaoPermitida(void *end);
        void limpaFlagsExecucaoNormalNoCicloAtual();
        void limpaFlagsExecucaoAbaixoNormalNoCicloAtual();
        void fimDoScan();
        int GerenciadorDePrioridades::obtemQuantidadeSinaisRegistrados();
};



//bcv03r15.3 enum tipoCampo {SAIDA,ENTRADA,CHAR,INT,LONG,ALARME,ENTRADA_ANALOGICA,SAIDA_ANALOGICA,SAIDA_PWM,ENTRADA_PERIODO,PARISON,ENTRADA_ENCODER};
//bcv03r22.2 enum tipoCampo {SAIDA,ENTRADA,CHAR,INT,LONG,ALARME,ENTRADA_ANALOGICA,SAIDA_ANALOGICA,SAIDA_PWM,ENTRADA_PERIODO,PARISON,ENTRADA_ENCODER,CHAR_RECEITA,CHAR_CONFINT,INT_RECEITA,INT_CONFINT,LONG_RECEITA,LONG_CONFINT}; //bcv03r15.3
//bcv03r27.2 enum tipoCampo {SAIDA,ENTRADA,CHAR,INT,LONG,ALARME,ENTRADA_ANALOGICA,SAIDA_ANALOGICA,SAIDA_PWM,ENTRADA_PERIODO,PARISON,ENTRADA_ENCODER,CHAR_RECEITA,CHAR_CONFINT,INT_RECEITA,INT_CONFINT,LONG_RECEITA,LONG_CONFINT,GRAFTEND}; //bcv03r22.2
enum tipoCampo {SAIDA,ENTRADA,CHAR,INT,LONG,ALARME,ENTRADA_ANALOGICA,SAIDA_ANALOGICA,SAIDA_PWM,ENTRADA_PERIODO,PARISON,ENTRADA_ENCODER,CHAR_RECEITA,CHAR_CONFINT,INT_RECEITA,INT_CONFINT,LONG_RECEITA,LONG_CONFINT,GRAFTEND,ENTRADA_CONTADOR}; //bcv03r27.2


enum tipoTermoparZona {TERMOPAR_J,TERMOPAR_K};

extern unsigned char logAquecimento;
extern unsigned char aquecimentoLigado;
char ELC;                               //Estado logico corrente
extern char     rodouIHM;               //Espera ler parametros antes de rodar o CLP
extern char     automatico;             //Indica que a maquina esta trabalhando em ciclo automatico

/****************************************************************
 * Mapeamento de memoria dos sinais do CLP
 ****************************************************************/

#define COR_BARRA 0x71
#define CAMPO_ENTRADA_DIGITAL(x) char x=registraEntradaDigital(#x,&x);
#define CAMPO_SAIDA_DIGITAL(x) char x=registraSaidaDigital(#x,&x);
#define CAMPO_SAIDA_DIGITAL_ESTENDIDA(x) char x=registraSaidaDigitalEstendida(#x,&x); //bcv03r24.2
#define CAMPO_ENTRADA_TEMPERATURA(x,y) int x=registraEntradaTemperatura(#x,&x,y);
#define CAMPO_ENTRADA_ANALOGICA(x) int x=registraEntradaAnalogica(#x,&x);

//bcv03r00.9 #define CAMPO_ENTRADA_PERIODO(x) long x=registraEntradaPeriodo(#x,&x);
//bcv03r00.9 #define CAMPO_ENTRADA_ENCODER(x) int x=registraEntradaEncoder(#x,&x); //bcv02r08.1
#define CAMPO_ENTRADA_PERIODO(x) long x=registraEntradaEspecial(#x,&x,ENTRADA_PERIODO);      //bcv03r00.9
#define CAMPO_ENTRADA_ENCODER(x) int x=registraEntradaEspecial(#x,&x,ENTRADA_ENCODER);       //bcv03r00.9
#define CAMPO_ENTRADA_CONTADOR(x) int x=registraEntradaContador(#x,&x); //bcv03r27.2

#define CAMPO_SAIDA_ANALOGICA(x) int x=registraSaidaAnalogica(#x,&x);
#define CAMPO_SAIDA_PWM(x) int x=registraSaidaPWM(#x,&x);
#define CAMPO_INT(x) int x=registraCampo(#x,&x,INT);
#define CAMPO_INT_RECEITA(x) int x=registraCampo(#x,&x,INT_RECEITA); //bcv03r15.3
#define CAMPO_INT_CONFINT(x) int x=registraCampo(#x,&x,INT_CONFINT); //bcv03r15.3
#define CAMPO_CHAR(x) char x=(char)registraCampo(#x,&x,CHAR);
#define CAMPO_CHAR_RECEITA(x) char x=(char)registraCampo(#x,&x,CHAR_RECEITA); //bcv03r15.3
#define CAMPO_CHAR_CONFINT(x) char x=(char)registraCampo(#x,&x,CHAR_CONFINT); //bcv03r15.3
#define CAMPO_LONG(x) long x=(long)registraCampo(#x,&x,LONG);
#define CAMPO_LONG_RECEITA(x) long x=(long)registraCampo(#x,&x,LONG_RECEITA); //bcv03r15.3
#define CAMPO_LONG_CONFINT(x) long x=(long)registraCampo(#x,&x,LONG_CONFINT); //bcv03r15.3
#define TEMPORIZADOR(x,y) char dsp_##x;char fim_##x;Temporizador timer_##x(&dsp_##x,&fim_##x,&y);
#define TEMPORIZADOR_DE_MINUTO(x,y) char dsp_##x;char fim_##x;TemporizadorDeMinuto timer_##x(&dsp_##x,&fim_##x,&y); //bcv03r08.2 
#define CAMPO_ALARME(x,y) char x=registraAlarme(&x,y);
#define ENTRADA_VIRTUAL(x,y,z,w) char x=registraEntradaVirtual(#x,&x,&y,&z,w);
#define CONVERSOR_ESCALA(nomeConv,entrada,saida,x0,x,y0,y) ConversorEscala nomeConv(&entrada,&saida,x0,x,y0,y);
#define CAMPO_BOTAO_IHM(x,y) char x=(char)registraBotaoIHM(#x,&x,y);                        //bcv03r00.B
#define CAMPO_ENTRADA_DIGITAL_BC4SA(x) char x=registraEntradaDigitalBC4SA(#x,&x); //bcv03r06.2
#define SINAL_DIGITAL(x) char x;    //bcv03r28.3


//bcv03r15.3 As linhas abaixo foram modificadas na macro
//        CAMPO_INT(peso_##x)                     
//        CAMPO_INT(escala_##x)                   

//rev00.6 Macro abaixo
#define CAMPO_PROGRAMADOR(x)                    \
                                                \
        CAMPO_INT(tempoDecorrido_##x)           \
        CAMPO_INT(espessura_##x)                \
                                                \
        CAMPO_INT(ponto_##x)                    \
        CAMPO_INT(valor_##x)                    \
        CAMPO_CHAR(master_##x)                  \
        CAMPO_INT_RECEITA(peso_##x)             \
        CAMPO_INT_RECEITA(escala_##x)           \
                                                \
        int     auxAlterouPonto_##x;            \
        int     auxAlterouValor_##x;            \
        char    auxAlterouMaster_##x;           \
        int     auxAlterouPeso_##x;             \
        int     auxAlterouEscala_##x;           \
                                                \
        ProgramadorDeParison x(#x,&x,&ponto_##x,&valor_##x);          

//bcv03r22.2 Macro abaixo
#define CAMPO_GRAFICO_TENDENCIA(x)              \
                                                \
        GraficoDeTendencia x(#x,&x);



#define LDT(x)  ELC=x;
#define LDF(x)  ELC=~x;
#define SEL(x)  ELC=x;      //bcv03r12.3
#define SED(x)  ELC=~x;     //bcv03r12.3
#define E(x)    ELC&=x;
#define EN(x)   ELC&=~x;
#define OU(x)   ELC|=x;
#define OUN(x)  ELC|=~x;
#define SUBIDA  ELC=(ELC&3)==1?1:0;
#define DESCIDA ELC=(ELC&3)==2?1:0;
#define MEMO(x) x=x<<1|(ELC&1);
#define NAO     ELC=~ELC;
#define IF1     if (ELC&1)
#define ENTAO_EXECUTA_BLOCO if (ELC&1)      //bcv03r28.3
#define SET(x)  if (ELC&1) x=x<<1|(ELC&1);
#define RESET(x)if (ELC&1) x=x<<1;


//bcv03r15.3        CAMPO_INT(bandaAlarmeAquecimento)
//bcv03r15.3        CAMPO_INT(bandaDesvioTemperatura)
        CAMPO_INT_RECEITA(bandaAlarmeAquecimento)   //bcv03r15.3
        CAMPO_INT_RECEITA(bandaDesvioTemperatura)   //bcv03r15.3

        CAMPO_INT(timeSamplePID)
        TEMPORIZADOR(timeSamplePID,timeSamplePID)

//bcv03r01.2 A linha abaixo foi modificada na macro
//        CAMPO_INT(rangeMaxTemp##x)

//bcv03r15.3 As linhas abaixo foram modificadas na macro
//        CAMPO_INT(setPoint##x) 
//        CAMPO_LONG(kpProg##x) 
//        CAMPO_LONG(kiProg##x) 
//        CAMPO_LONG(kdProg##x) 
//        CAMPO_CHAR(habilita##x) 
//        CAMPO_CHAR(habCtrlPercent##x) 


#define CONTROLADOR_PID(x) \
        CAMPO_INT_RECEITA(setPoint##x) \
        CAMPO_LONG_CONFINT(kpProg##x) \
        CAMPO_LONG_CONFINT(kiProg##x) \
        CAMPO_LONG_CONFINT(kdProg##x) \
        CAMPO_INT(valorPID##x) \
        CAMPO_LONG(erroPercentual##x) \
        PID pid##x(0,0,0,0); \
        CAMPO_CHAR_CONFINT(habilita##x) \
        CAMPO_CHAR_CONFINT(habCtrlPercent##x) \
        char cargaZero##x; \
        char cargaMax##x; \
        char solicAquec##x; \
        CAMPO_INT(PWM##x) \
        TEMPORIZADOR(PWM##x,PWM##x) \
        char x##SuperAquecida; \
        char x##Fria; \
        char x##AcimaBandaDesvio; \
        char x##AbaixoBandaDesvio; 

//bcv03r01.2 As linhas abaixo foram modificadas na macro
//  erro##x=(((double)(setPoint##x-temperatura##x))/(double)rangeMaxTemp##x)*100;
//        if(rangeMaxTemp##x != 0) 
//        else 
//                erro##x=0; 

#define CONTROLA_PID(x) \
        LDF     (fim_timeSamplePID) \
        MEMO    (dsp_timeSamplePID) \
        LDF     (fim_timeSamplePID) \
        MEMO    (dsp_PWM##x) \
        double erro##x; \
        erro##x=(((double)(setPoint##x-temperatura##x))); \
        erroPercentual##x=(long)((erro##x)*1000); \
        LDT     (fim_timeSamplePID) \
        E       (habilita##x) \
        E       (aquecimentoLigado) \
        IF1     { \
                pid##x.reprogramaPID(((double)kpProg##x)/1000,((double)kiProg##x)/1000,((double)kdProg##x)/1000,((double)timeSamplePID)/6000); \
                if (habCtrlPercent##x & 1) \
                        valorPID##x=setPoint##x; \
                else \
                        valorPID##x=(int)pid##x.calculaPID(erro##x); \
                if (valorPID##x > 100) \
                        valorPID##x=100; \
                if (valorPID##x < 0) \
                        valorPID##x=0; \
                PWM##x=timeSamplePID*(int)valorPID##x/100; \
                if (logAquecimento) { \
                        char textoLog[80]; \
                        sprintf(textoLog,"%03u %03u\n",temperatura##x,valorPID##x); \
                        registraLog(#x,textoLog); \
                } \
        } \
        if      (valorPID##x==0) \
                cargaZero##x=1;   \
        else                \
                cargaZero##x=0;    \
                                \
        if      (valorPID##x==100) \
                cargaMax##x=1;    \
        else                      \
                cargaMax##x=0;    \
                            \
        LDT     (dsp_PWM##x)  \
        EN      (fim_PWM##x) \
                             \
        EN      (cargaZero##x) \
        OU      (cargaMax##x) \
        E       (habilita##x) \
        E       (aquecimentoLigado) \
        MEMO    (solicAquec##x) \
                                \
        if (temperatura##x > (setPoint##x+bandaAlarmeAquecimento) && habilita##x && !habCtrlPercent##x)       \
                LDT     (1)                                     \
        else                                                    \
                LDT     (0)                                     \
                                                                \
                MEMO    (x##SuperAquecida)                      \
                                                                \
        if (temperatura##x < (setPoint##x-bandaAlarmeAquecimento) && habilita##x && !habCtrlPercent##x)       \
                LDT     (1)                                     \
        else                                                    \
                LDT     (0)                                     \
                                                                \
                MEMO    (x##Fria)                               \
                                                                \
        if (temperatura##x > (setPoint##x+bandaDesvioTemperatura) && habilita##x && !habCtrlPercent##x)       \
                LDT     (1)                                     \
        else                                                    \
                LDT     (0)                                     \
                                                                \
                MEMO    (x##AcimaBandaDesvio)                           \
                                                                \
        if (temperatura##x < (setPoint##x-bandaDesvioTemperatura) && habilita##x && !habCtrlPercent##x)       \
                LDT     (1)                                     \
        else                                                    \
                LDT     (0)                                     \
                                                                \
                MEMO    (x##AbaixoBandaDesvio)

//Botoes virtuais

#define tecla_F12       88
#define tecla_F1        59      //bcv03r11.2
#define tecla_F2        60      //bcv03r11.2
#define tecla_F3        61      //bcv03r06.3

#define tecla_Q         16
#define tecla_W         17
#define tecla_E         18
#define tecla_R         19
#define tecla_T         20
#define tecla_Y         21
#define tecla_U         22
#define tecla_I         23
#define tecla_O         24
#define tecla_P         25
//Nao usar por causa do CTRL P #define p_RAW            25
#define tecla_A         30
#define tecla_S         31
#define tecla_D         32
#define tecla_F         33
#define tecla_G         34
#define tecla_H         35
#define tecla_J         36
#define tecla_K         37
#define tecla_Z         44
#define tecla_X         45
#define tecla_C         46
//Nao usar por causa do CTRL C #define c_RAW            46
#define tecla_V         47
#define tecla_B         48
#define tecla_N         49
#define tecla_M         50

//bcv03r26.4 Inicio do bloco

#define tecla_L             38
#define tecla_VIRGULA       51
#define tecla_PONTO         52
#define tecla_PONTOVIRGULA  53
#define tecla_CEDILHA       39
#define tecla_AGUDO         26
#define tecla_INS           82
#define tecla_END           79
#define tecla_ABRECOLCHETE  27
#define tecla_FECHACOLCHETE 43
#define tecla_TIO           40
#define tecla_DEL           83
#define tecla_HIFEN         12
#define tecla_IGUAL         13
#define tecla_PGDN          81
#define tecla_PGUP          73
#define tecla_ESPACO        57

//bcv03r26.4 Fim do bloco

