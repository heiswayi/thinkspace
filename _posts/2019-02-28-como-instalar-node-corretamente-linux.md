Em distribuições Debian Based é muito comum utilizar o comando **apt install -nome do pacote-** e com o Node isso pode lhe 
trazer muitos problemas. Entretanto tenho certeza que os mais novos no linux vão preferir utilizar o comando 
**apt install -nome do pacote-** do que fazer a instalação do pacote binário e isso vai quebrar tudo, porque até o 
momento que estou escrevendo esse texto os repositórios do Debian estão desatualizados (o Debian tem o costume de 
demorar para atualizar seus repositórios).

Minha recomendação é que você **não instale o Node** pelo comando **sudo apt-get install -y nodejs** vai acontecer um conflito 
de nomes entre *node* e *nodejs*, parece besteira que uma simples nomenclatura quebre tudo, mas não é! O NPM que é o 
gerenciador de dependências vai ficar perdido e algumas funções não funcionarão.
