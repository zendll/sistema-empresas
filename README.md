# Sistema de Empresas para SA-MP

  Um sistema de empresas desenvolvido em Pawn para servidores de SA-MP, que permite criar, carregar e salvar informações sobre empresas no jogo. Este sistema utiliza MySQL para armazenar dados persistentes e oferece uma estrutura simples para gerenciar empresas com funcionalidades de criação.

# Funcionalidades
  Criação de Empresas: Comando /criaremp permite que administradores criem novas empresas no local do jogador, incluindo o dono, saldo inicial, e nome.
  Persistência de Dados: Dados das empresas são salvos e carregados automaticamente no início e fim do modo de jogo, garantindo que as informações sejam mantidas entre reinicializações.
  Visualização no Jogo: Cria etiquetas de texto e pickups para identificar a entrada de cada empresa, mostrando nome, dono e saldo.
  Limite de Empresas: Suporta até 35 empresas por padrão, configurável na constante MAX_EMP.
  
# Dependências

  YSI para hooks.
  EasyDialog para diálogos simplificados.
  sscanf2 para processamento de comandos.
  
** Como Usar

  Clone ou faça download deste repositório.
  Configure a conexão com MySQL para salvar e carregar as informações das empresas.
  Compile e carregue o sistema no servidor SA-MP.
  Use o comando /criaremp no jogo para criar uma nova empresa.
  Comandos
  /criaremp [id/nome do dono] [nome] [saldo inicial]: Cria uma empresa na posição atual do jogador com as informações especificadas.
  Contribuições
  Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorias ou correções.

# Contato
  Para suporte ou dúvidas, junte-se ao nosso servidor Discord <https://discord.gg/gh3GStXzHf>.

