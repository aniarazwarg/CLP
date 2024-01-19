
/****************************************************************
 * Classe StringBC
 ****************************************************************/
class StringBC {
private:
        char *bufferString;
        int tamanhoMaximoString;
        
public:
        StringBC::StringBC(char *_idCampo, void *_endCampo, int _tamanhoMaximoString);
        StringBC::StringBC(char *_idCampo, void *_endCampo, int _tamanhoMaximoString, char _tipoEspecialString);
        void alteraString(char *_novaString);
        char * obtemString();
        int obtemTamanhoMaximoString();      //bcv03r65.2
        
};


