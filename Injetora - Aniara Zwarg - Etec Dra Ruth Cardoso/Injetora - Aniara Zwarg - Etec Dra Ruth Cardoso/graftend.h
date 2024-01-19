//bcv03r22.2 - Todo este arquivo

/****************************************************************
 * Grafico de tendencia                                         *
 ****************************************************************/

#define NUMERO_MAXIMO_PONTOS_GRAFICO_TENDENCIA 500

class GraficoDeTendencia {

        int valoresDasAmostras[NUMERO_MAXIMO_PONTOS_GRAFICO_TENDENCIA];
        int numeroDeAmostrasInseridas;
        char flagAlterouAmostras;
        int maiorValorAmostra;

public:
        GraficoDeTendencia(char *idCampo, void *endCampo);
        void insereAmostra(int valorAmostra);
//        void modificaAmostra(int numeroDaAmostra,int novoValorAmostra); nao tem sentido existir isto.
        void apagaAmostras();
        int obtemValorAmostra(int numeroDaAmostra);
        int obtemNumeroDeAmostrasInseridas();
        char verificaAlterouAmostras();
        void resetAlterouAmostras();
        //resolvi que nao vai gravar as amostras em arquivo. Ficaria muito grande alem de existir o shift natural quando estoura o numero maximo de amostras
        int obterMaiorValorAmostra();
        
};

