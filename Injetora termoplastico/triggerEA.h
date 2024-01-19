class TriggerEA {

public:
    int valorBrutoEA;
    char statusTriggerEA;
    char novoStatusTriggerEA;
    char habilitaTriggerEA;
//bcv03r81.6_t4    unsigned char bufferTrigger[80];
//bcv03r81.7_t4    unsigned char bufferTrigger[64];        //bcv03r81.6_t4
    unsigned int bufferTrigger[64];        //bcv03r81.6_t4    //bcv03r81.7_t4
    char contadorLeituraBlocosBufferTrigger;
    unsigned char nivelTrigger;             //bcv03r81.4_t2
    unsigned char novoNivelTrigger;         //bcv03r81.4_t2
    unsigned int periodoAmostra;            //bcv03r81.4_t2
    unsigned int novoPeriodoAmostra;        //bcv03r81.4_t2
    unsigned char numeroAmostrasDelay;      //bcv03r81.5_t3
    unsigned char novoNumeroAmostrasDelay;  //bcv03r81.5_t3
    unsigned char ganho1oAmplificador;      //bcv03r84.2_t1
    unsigned char novoGanho1oAmplificador;  //bcv03r84.2_t1
    unsigned char offSet2oAmplificador;     //bcv03r84.2_t1
    unsigned char novoOffSet2oAmplificador; //bcv03r84.2_t1
    unsigned char ganho2oAmplificador;      //bcv03r84.2_t1
    unsigned char novoGanho2oAmplificador;  //bcv03r84.2_t1

    TriggerEA::TriggerEA(char *_idCampo);
    void TriggerEA::configuraStatusTrigger(char novoStatus);
    void TriggerEA::leBufferTriggerDoModulo();
//bcv03r81.7_t4    unsigned char TriggerEA::obtemAmostraDoBufferTrigger(unsigned char _indiceAmostra);
    unsigned int TriggerEA::obtemAmostraDoBufferTrigger(unsigned char _indiceAmostra);      //bcv03r81.7_t4
//bcv03r81.5_t3    void TriggerEA::configuraParametrosTrigger(unsigned char _novoNivelTrigger, unsigned int _novoPeriodoAmostra);        //bcv03r81.4_t2
    void TriggerEA::configuraParametrosTrigger(unsigned char _novoNivelTrigger, unsigned int _novoPeriodoAmostra, unsigned char _novoNumeroAmostrasDelay);        //bcv03r81.5_t3//bcv03r81.4_t2
    void TriggerEA::configuraTrimpotsDigitais(unsigned char ganho1oAmplificador, unsigned char offSet2oAmplificador, unsigned char ganho2oAmplificador); //bcv03r84.2_t1

    
};
