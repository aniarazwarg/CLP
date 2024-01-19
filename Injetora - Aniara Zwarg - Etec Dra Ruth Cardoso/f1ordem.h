/****************************************************************
 * Filtro de 1a Ordem //bcv03r31.4                              *
 ****************************************************************/

class Filtro1aOrdem {

        int *a;
        int *b;
        int *c;
        int amostras[3];

public:
        Filtro1aOrdem(int *_a, int *_b, int *_c, int valorInicial);
        double calcula(int _entrada);
        
};
