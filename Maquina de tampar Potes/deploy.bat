REM ***************************************************************************
REM Programa:   Deploy
REM Versao:     02
REM Revisao     00
REM Data:       14/09/2013
REM Autor:      Fernando Branquinho
REM Descricao:  Versao Original
REM		Este arquivo (deploy.bat) deve ser inserido dentro da 
REM		pasta do c�digo fonte do software
REM		Os arquivos AUTOEXEC.BAT e EXECPROG.BAT nao devem mais ficar
REM		na pasta do c�digo fonte. Estes arquivos agora sao obtidos
REM		a partir da pasta "ProgramFiles\branqs\deploy_vXXrZZ\smartUpload"
REM		onde XX e ZZ sao respectivamente a versao e revisao do deploy
REM 
REM ***************************************************************************

IF "%ProgramFiles(x86)%" =="" ("%ProgramFiles%\branqs\deploy_v02r00\deploy_v02r00") ELSE ("%ProgramFiles(x86)%\branqs\deploy_v02r00\deploy_v02r00")
