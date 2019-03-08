[Recentemente os domínios **.dev** foram liberados ao público pelo Google](https://canaltech.com.br/internet/google-libera-dominio-dev-para-todos-duas-semanas-apos-lancamento-134053). Imaginei que essa seria uma boa oportunidade para criar finalmente o meu cantinho na internet.

Quando fui comparar os valores de hospedagem para o meu site lembrei que o [Github Pages](https://pages.github.com/) juntamente com o [Jeklly](https://jekyllrb.com) são uma boa opção para quem está começando, então com a plataforma de blog e hospedagem escolhidas fui em busca de pensar em um domínio.

Escolhi [malaquias.dev](https://malaquias.dev) para fazer menção a um ID que já utilizo nas minhas redes sociais, pois bem nome de domínio pensado e aprovado é chegada agora dos finalmente e comprar. Inicialmente iria comprar na [Godaddy porque vi uma promoção de R$ 52,00 no primeiro ano](https://br.godaddy.com/tlds/dev-domain), mas um amigo me avisou que o [Google vende domínios e que lá estava mais barato](https://domains.google/tld/dev/).

Optei então pela plataforma do Google e a treta começou, domínio comprado, mas como fazer as configurações? Tive que ler apenas uma documentação do Github Pages. O resultado dessa experiência além de obviamente está usando com sucesso o meu domínio no meu blog é esse artigo simplificando o processo para vocês.

Aqui vou supor que você já possui um repositório criado, está usando o [Github Pages](https://pages.github.com/) e comprou um domino no [Google Domains](https://domains.google/tld/dev/).

## Configurando o DNS no Google Domains

![Google Domains painel](https://malaquias.dev/images/posts/182A76B9-279F-4921-98A3-0BD8B7A5DCDF.jpeg)

Vá ate o seu painel no [Google Domains](https://domains.google.com/m/registrar/?hl=en) e clique em **MANAGE**, clique em **DNS** e depois vá direto para a sessão **Custom resource records**.

Agora vamos começar a brincar...

Atualmente você precisa adicionar quatro itens do tipo A (adreess)

185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153

Caso esse artigo tenha ficado datado recomendo que você acesse a pagina **[Setting up an apex domain do Github](https://help.github.com/en/articles/setting-up-an-apex-domain#configuring-a-records-with-your-dns-provider)** para verificar os valores de DNS.

Adicionados os quatro IPs agora podemos adicionar um novo recurso do tipo CNAME e o seu valor vai apontar para a URL que o Github Pages te forneceu quando você configurou o seu repositório, no meu caso o foi malaquaisdev.github.io

![DNS na parte de Custom resource records](https://malaquias.dev/images/posts/91D15578-26B7-4541-839E-0609AFF81D82.jpeg)

## Configurando seu CNAME no Github

Existem duas maneiras de se configurar um CNAME, podemos cirar o arquivo na mão ou ir nas configurações do repositório e deixar que o Github faça isso por nós.

Vamos fazer da maneira mais simples e delegar essa responsabilidade para o Github, então vá até a pagina settings do seu repositório.

![Pagina inicial do meu repositorio sinalizando onde esta a sessao settings](https://malaquias.dev/images/posts/D0F09D70-C483-4DB2-9453-CACE41E87F37.jpeg)


Feito isso, desça até sessão do Github Pages e adicione um custom domain que é o dominio comprado e configurado por você e salve.

### Aproveite para ativar o HTTPS

HTTS é um recurso muito importante de se ter hoje em dia para que os navegadores reconheçam aquela requisição como segura. O massa é que o Github Pages nos oferta isso de graça, basta que a gente marque a opção **Enforce HTTPS**, ela pode não esta habilitada logo de cara então espere alguns minutes e tente novamente se for o caso.

![Sessao do Github Pages](https://malaquias.dev/images/posts/E5C7FA75-90AC-4ECA-A942-0A683D815371.jpeg)

Por último não esqueça de alterar a URL do seu site no arquivo de configurações do Jeklly para que essas configurações funcionem.

## Conclusão

Essas configurações podem levar até um dia para serem validadas, mas uma vez que forem efitivadas tudo vai funcionar lindamente S2.
