# Victor Ciola Rinaldo — Portfólio Profissional

https://victorciola-collab.github.io/Portf-lio/

Portfólio desenvolvido em HTML, CSS e JavaScript puro, sem frameworks, build, backend, fontes externas ou dependências de terceiros. Identidade minimalista e editorial, com fundo claro, grafite e detalhes em azul.

## Executar localmente

Abra `index.html` em um navegador moderno ou sirva a pasta por HTTP. CSS, JavaScript, favicon e imagem social usam caminhos relativos compatíveis com um site de projeto no GitHub Pages.

## Estrutura

```text
index.html                      Seções, conteúdo e metadados
assets/css/styles.css           Tokens visuais, componentes e responsividade
assets/js/app.js                 Contatos, catálogo dos cinco projetos e interações
assets/images/favicon.svg       Monograma VC.
assets/images/social-card.png   Imagem social PNG de 1200 × 630 px
tools/validate.ps1               Validação local em Chrome/Edge
artifacts/                      Capturas e relatórios locais, ignorados pelo Git
.local-preview/                 Perfil isolado do navegador, ignorado pelo Git
.gitignore                      Exclusão dos arquivos gerados
.gitattributes                  Normalização dos arquivos de texto
```

## Conteúdo e tecnologias

O site reúne Início, Sobre mim, O que eu faço, Projetos e Contato. A seção de soluções apresenta Analytics, Data Preparation & ETL e Automation & Applications.

São apresentados cinco projetos:

1. **Gestão de Movimentações de Colaboradores:** Power Apps, Power Fx, SharePoint, Power Automate, Power BI e Power Query.
2. **Gestão de Smartworking:** Power Apps, SharePoint, Power Automate e Power BI.
3. **Automação de ETL e Integração de Dados de RH:** Power Query, Power BI Dataflows, Power BI Service, ETL e SAP como sistema de origem.
4. **Central de Indicadores de RH:** Power BI, DAX, Power Query, Modelagem de dados e Power BI Service.
5. **Planejamento e Simulação de Ocupação:** HTML, CSS, JavaScript, Lógica de negócios, Análise de dados e Simulação de cenários.

O catálogo também menciona Excel, SQL, Python, VBA e Git/GitHub na seção de soluções. Essas tecnologias são conteúdo do portfólio; a implementação deste site utiliza somente HTML, CSS, JavaScript e SVG.

## Previews conceituais

Os cinco previews são composições locais de HTML/CSS e SVG. Os quatro primeiros ilustram fluxos de trabalho; o quinto apresenta cenários e uma planta esquemática, com lugares ilustrativos gerados em JavaScript.

Não são sistemas operacionais, screenshots corporativos ou plantas reais. Não contêm registros pessoais, métricas corporativas reais ou resultados quantitativos. Os controles desenhados nos previews são estáticos. Todos são identificados como conceituais e sem dados reais.

Os modais reutilizam os previews e as tags dos cards. Textos e dados dos projetos ficam no catálogo `PROJECTS`; as tecnologias também estão no HTML. Ao manter o catálogo, preserve a correspondência entre essas duas representações.

## Navegação e acessibilidade

- Menu fixo, âncoras com scroll suave e indicação da seção atual.
- Menu responsivo até 800 px, operável por teclado e fechado por Escape, navegação ou clique externo.
- Layout alternado dos projetos no desktop e uma coluna até 800 px.
- Cinco projetos com um dialog nativo reutilizável.
- Fechamento por botão, Escape ou clique externo; foco contido e restaurado ao botão de origem.
- Bloqueio da rolagem ao fundo enquanto o modal está aberto.
- Skip link, foco visível, títulos semânticos e respeito a movimento reduzido.
- Ícones decorativos ocultos da tecnologia assistiva, tags de 12 px e SVGs azuis de 18 px.
- Conteúdo principal disponível sem JavaScript; detalhes em modal requerem JavaScript.

## Contatos

LinkedIn e e-mail estão implementados. LinkedIn abre em nova aba com `rel="noopener noreferrer"`; o e-mail utiliza `mailto:`.

GitHub permanece visível como texto e ícone, sem direcionamento ou foco pelo teclado. `CONTACTS.github` está definido como `null`. Não reativar esse contato sem uma decisão explícita.

## GitHub Pages e compartilhamento

Repositório previsto: `victorciola-collab/Portf-lio`.

URL configurada:

```text
https://victorciola-collab.github.io/Portf-lio/
```

O HTML define canonical, Open Graph e Twitter Card. A imagem social tem 1200 × 630 px e URL absoluta dentro de `/Portf-lio/assets/images/`. Não é carregada no corpo da página.

O site não exige build. Na publicação, configure a origem apropriada no GitHub Pages e preserve `index.html` e `assets/`. O fluxo de publicação não deve copiar perfis de navegador, capturas, relatórios ou arquivos de sessão. As pastas `artifacts/` e `.local-preview/` permanecem ignoradas pelo Git.

A configuração dos metadados e caminhos não publica o site nem altera a privacidade de repositórios. Confirme a autorização de divulgação das descrições corporativas antes de publicar.

## Validação

No PowerShell, a partir da raiz do projeto:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

O script usa Chrome instalado, com Edge como alternativa. Não instala dependências. A política de execução indicada vale somente para o processo iniciado. Capturas e relatório são gravados em `artifacts/`, e o navegador usa o perfil isolado `.local-preview/`.

A cobertura inclui 320, 390, 768, 1024, 1440 e 1920 px, cinco projetos e modais, teclado, restauração de foco, fechamento externo, menu móvel, âncoras, contatos, tecnologias, ausência de overflow, redução de movimento, contraste dos microtextos e metadados. Também verifica as dimensões da imagem social.

Para validar uma instância servida localmente sob o subdiretório de publicação, inicie seu servidor local e informe sua URL:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1 -PageUrl "http://127.0.0.1:8768/Portf-lio/"
```

O validador não inicia um servidor HTTP, não testa a disponibilidade dos perfis externos e não publica arquivos. Complementar a conferência em Safari/Firefox, dispositivo físico, leitor de tela e no preview real do LinkedIn após uma publicação autorizada.
