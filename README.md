# Victor Rinaldo — Data Analytics & Automation

Primeira versão local do portfólio, com HTML5, CSS3 e JavaScript puro. Sem frameworks, build, backend, fontes externas ou dependências. Nenhuma publicação foi realizada.

## Abrir localmente

Abra `index.html` em um navegador moderno (Chrome, Edge, Firefox ou Safari). Os caminhos relativos permitem abrir diretamente como arquivo e publicar futuramente em um subdiretório do GitHub Pages.

## Estrutura

```text
index.html                   Conteúdo, seções, navegação e metadados
assets/css/styles.css        Tokens visuais, componentes e responsividade
assets/js/app.js             Contatos, catálogo dos cases e interações
assets/images/favicon.svg    Identidade tipográfica VR.
tools/validate.ps1           Validação local em Chrome/Edge, sem dependências
artifacts/                   Capturas e relatório gerados, ignorados pelo Git
.gitignore                   Exclusão dos artefatos e perfil de validação
```

## Composição visual

Off-white, grafite e azul provisório, com bastante espaço, tipografia do sistema e sombras discretas. O hero combina o posicionamento com um diagrama vetorial de dados e processos conectados a soluções. Os projetos usam linhas editoriais amplas, com conteúdo e preview alternados no desktop e uma coluna no celular. O que eu faço apresenta Analytics, Data Preparation & ETL e Automation & Applications. As 13 tecnologias aparecem uma única vez em tags compactas, com os SVGs azuis reutilizados abaixo das descrições de cada pilar: três em Analytics, três em Data Preparation & ETL e sete em Automation & Applications. Projetos é seguido diretamente por Contato. As tags são informativas, sem ações ou animações próprias.

## Funcionalidades

- Menu fixo, links internos com scroll suave e indicação da seção ativa.
- Menu mobile com estado acessível, acionamento por teclado e fechamento por ESC, navegação ou clique externo.
- Dois cases com um modal reutilizável, fechamento por botão, ESC ou clique no backdrop, contenção de foco, retorno ao botão de origem e bloqueio de scroll ao fundo.
- Conteúdo dos cases criado com APIs de DOM e `textContent`, sem inserir HTML de dados.
- Skip link, foco visível, títulos semânticos e respeito a `prefers-reduced-motion`.
- Metadados básicos de SEO, Open Graph e Twitter Card.

## Previews

**App de Movimentações:** interface conceitual feita em HTML/CSS, com fluxo Solicitação → BP → Remuneração → Organização → HR Support → Processamento. As marcações de etapas são ilustrativas.

**Planejador de Espaço:** interface conceitual feita em HTML/CSS e pequenos elementos gerados em JavaScript. Inclui cenários, indicadores fictícios e uma planta esquemática por zonas. Os números 120 e 84 são exclusivamente demonstrativos; a disposição gráfica de lugares não representa uma planta real ou uma correspondência com esses indicadores. Os controles dentro dos previews são ilustrações estáticas.

Ambos são identificados visualmente como conceituais/demonstrativos. Não contêm dados de empresa, pessoas, e-mails ou identificadores. Os modais reaproveitam os mesmos previews até a chegada de screenshots definitivos.

## Pendências para preencher

1. Em `assets/js/app.js`, preencher `CONTACTS.linkedin`, `CONTACTS.github` e `CONTACTS.email` (e-mail sem `mailto:`). Os links pendentes não têm `href`; os avisos desaparecem conforme os contatos forem preenchidos.
2. Em `index.html`, preencher o comentário `TODO_PUBLICACAO`: canonical, URL pública, imagem Open Graph e imagem Twitter. Ao fornecer uma imagem de compartilhamento, avaliar trocar a Twitter Card para `summary_large_image`.
3. Substituir os previews conceituais por screenshots aprovados. Métricas devem ser acrescentadas somente quando comprovadas.

## Adicionar projetos futuramente

1. Duplicar uma linha `.project` no HTML e atribuir IDs de títulos únicos. Aplicar `.project-reverse` para alternar a composição.
2. Usar uma chave única em `data-project` no botão e criar seu registro em `PROJECTS` em `assets/js/app.js`.
3. Preencher título, resumo, contexto, solução, funcionamento, etapas, funcionalidades, tecnologias, resultado e seletor do preview.

O mesmo modal renderiza os novos cases. Smartworking Analytics, Portal HR Suporte e TravelHub não estão implementados nem exibidos nesta versão.

## Validação

No PowerShell, a partir desta pasta:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\validate.ps1
```

A opção de execução vale apenas para esse processo, sem alterar a política do sistema. O script usa o Chrome instalado, ou Edge como alternativa, em modo headless. Gera capturas e `artifacts/validation.json`, usando um perfil isolado em `.local-preview/`. Não instala ferramentas.

Validado em larguras de 1440, 768, 390 e 320 px: links internos, scroll, menu desktop/mobile, abertura dos dois cases, botão fechar, ESC, Tab/Shift+Tab, foco inicial e restaurado, bloqueio/liberação do scroll, ausência de overflow horizontal e de exceções JavaScript. Também verificados os placeholders, quantidade de projetos, IDs únicos, numeração das seções, consistência dos ícones, distribuição das tecnologias nos pilares, quebra de linha das tags e redução de movimento.

As capturas de desktop, tablet, mobile, menus e modais foram revisadas visualmente. Essa verificação usa Chrome desktop em larguras variadas; recomenda-se complementar com Safari/iOS e um celular físico antes de publicar.

## Próxima revisão visual

Avaliar o azul provisório, o tamanho da headline, o espaçamento entre seções, a presença dos previews e a densidade de leitura dos cases. Definir posteriormente fotos ou screenshots e os dados finais de contato.
