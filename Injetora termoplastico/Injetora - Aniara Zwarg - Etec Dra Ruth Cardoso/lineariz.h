class Linearizador10Pontos{

        int pontoX[10];
        int pontoY[10];

public:
        Linearizador10Pontos();
        void configura(int x0,int x1,int x2,int x3,int x4,int x5, int x6,int x7,int x8,int x9,int y0,int y1,int y2,int y3,int y4,int y5, int y6,int y7,int y8,int y9);
        int obtemValorLinearizado(int entrada);
};

#define LINEARIZADOR10PONTOS(nomeLinearizador) Linearizador10Pontos nomeLinearizador;

//bcv03r28.2 Inicio do bloco

class LinearizadorAutomatico10Pontos{

        int* pontoX[10];
        int* pontoY[10];
        int* entrada;
        int* saida;

public:
        LinearizadorAutomatico10Pontos(int *_entrada,int *_saida,int *x0,int *x1,int *x2,int *x3,int *x4,int *x5, int *x6,int *x7,int *x8,int *x9,int *y0,int *y1,int *y2,int *y3,int *y4,int *y5, int *y6,int *y7,int *y8,int *y9);
        void realizaLinearizacao();
};

#define LINEARIZADOR_AUTOMATICO_10PONTOS(nomeLinearizador,entrada,saida,x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,y0,y1,y2,y3,y4,y5,y6,y7,y8,y9) LinearizadorAutomatico10Pontos nomeLinearizador(&entrada,&saida,&x0,&x1,&x2,&x3,&x4,&x5,&x6,&x7,&x8,&x9,&y0,&y1,&y2,&y3,&y4,&y5,&y6,&y7,&y8,&y9);

void realizaLinearizacoesAutomaticas();

//bcv03r28.2 Fim do bloco


//bcv03r50.9 Inicio do bloco

#define NUMERO_MAXIMO_PONTOS_LINEARIZADOR_X_PONTOS 50

class LinearizadorAutomaticoXPontos{

	int qtdPontos;
        int* pontoX[NUMERO_MAXIMO_PONTOS_LINEARIZADOR_X_PONTOS];
        int* pontoY[NUMERO_MAXIMO_PONTOS_LINEARIZADOR_X_PONTOS];
        int* entrada;
        int* saida;

public:
        LinearizadorAutomaticoXPontos(int _qtdPontos, int *_entrada,int *_saida,int *x0,int *y0,int *x1,int *y1, ...);
        void realizaLinearizacao();
};


//bcv03r50.9 Fim do bloco
