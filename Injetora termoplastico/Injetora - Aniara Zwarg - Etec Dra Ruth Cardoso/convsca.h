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

//bcv03r61.7 Inicio do bloco

class ConversorEscalaLONG {
public:
        long double coeficienteAngular;
        long double constanteLinear;
        long long* entradaOriginal;
        long long* saidaConvertida;

        ConversorEscalaLONG(long long* entrada,long long* saida,long long minimoEntrada, long long maximoEntrada, long long minimoSaida, long long maximoSaida);
        void reconfiguraConversor(long long minimoEntrada, long long maximoEntrada, long long minimoSaida, long long maximoSaida);
        void converteEscala();
};


//bcv03r61.7 Fim do bloco

