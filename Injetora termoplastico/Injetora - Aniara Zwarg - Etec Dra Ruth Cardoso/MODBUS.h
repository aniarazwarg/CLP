#include <bios.h>
int inicializa_SlaveMODBUS_RTU(unsigned int _portaSerial, unsigned _numeroDeBits, unsigned _paridade, unsigned _numeroStopBits, unsigned _baudRate, unsigned _timeout, unsigned _enderecoSlave);
void trataSlaveMODBUS();
void habilitaLogSlaveMODBUS(); //bcv03r68.4_t2
void desabilitaLogSlaveMODBUS(); //bcv03r68.4_t2

unsigned char verificaChegadaMensagemSlaveMODBUS();   //hoje
