class ControladorVulcanizacao {

        long uca;
        int ucp;
        int ucpa;
        int taeauc;
        int sant;
        int cs;
        int porcentagemVulcanizacao;

public:
        ControladorVulcanizacao();
        int obtemPorcentagemVulcanizacao();
        void reiniciaVulcanizacao();
        void registraTemperatura(int temperatura);

};
