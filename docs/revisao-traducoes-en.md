# Catálogo de traduções em inglês — revisão

**Status:** catálogo integrado à implementação bilíngue local; aprovação visual e publicação pendentes.

**Fontes vigentes:** `index.html`, `privacidade.html`, `assets/js/app.js` e `assets/js/analytics.js`, lidos nesta etapa. O português abaixo reproduz o conteúdo atual, com entidades HTML apresentadas como texto legível. Números, períodos, aproximações, nomes próprios, produtos, URLs e identificadores são preservados. Somente unidades textuais são traduzidas: `mês` → `month`.

O catálogo utiliza inglês profissional com convenções predominantemente americanas (por exemplo, “standardization”, “modeling” e “vacation”), sem direcionar as informações a uma jurisdição específica. A variante deve ser aprovada antes da implementação.

Cada descrição principal de projeto é usada tanto no card quanto no modal. Os previews são HTML/CSS reutilizados no modal. A tradução correspondente deve ser aplicada uma única vez a cada fonte lógica, mantendo essas apresentações sincronizadas. Este documento não altera o seletor, a navegação, a configuração de Analytics ou o conteúdo português.

## 1. Glossário e convenções

| Termo em português | English | Observação para revisão |
| --- | --- | --- |
| Movimentações de colaboradores | Employee movements | Termo amplo; confirmar o alcance antes de preferir “employee transfers” ou “internal mobility”. |
| Gestão de Smartworking | Hybrid Work Management (Smartworking) | Smartworking permanece como nome do projeto; os textos explicam o modelo híbrido. |
| Modelo de trabalho híbrido | Hybrid work model | Não reintroduzir justificativas, vigilância ou fiscalização individual. |
| Recursos Humanos / RH | Human Resources / HR | Human Resources no texto por extenso; HR nas ocorrências abreviadas. |
| Central de Indicadores de RH | HR Analytics Hub | “Hub” representa o ambiente centralizado; validar preferência pelo título. |
| Indicadores | Indicators | Não converter automaticamente todos os indicadores em “KPIs” nem acrescentar metas. |
| Indicadores gerenciais | Management indicators | Preserva a finalidade gerencial. |
| Solicitações | Requests | Não pressupõe tickets ou processos adicionais. |
| Fluxo de aprovações | Approval workflow | Mesmo processo e mesmas responsabilidades. |
| Rastreabilidade | Traceability | Registro das decisões; não equivale a uma auditoria formal. |
| Perfis de acesso | Access roles | Permissões, sem inventar um mecanismo técnico adicional. |
| Histórico | History | Preservar os tipos de informação registrados. |
| Tratamento de dados | Data processing | Não confundir com extração de dados. |
| Padronização | Standardization | Mesmo sentido de regras consistentes. |
| Consolidação | Consolidation | Preservar distinção em relação à integração. |
| Atualização de dados / fluxos | Data / flow refresh | “Update” é usado quando se trata de atualização de relatórios ou esforço por atualização. |
| Estimado / estimada | Estimated | Obrigatório nos indicadores quantitativos aprovados. |
| Economia mensal | Estimated Monthly Time Savings | Mesmo período; não extrapolar para economia anual ou financeira. |
| Banco de horas | working-hour balances | Validar compreensão internacional e eventual explicação contextual; não pressupor regras legais estrangeiras. |
| Sobreaviso | On-call duty | Validar equivalência com a situação brasileira; não acrescentar regras de remuneração. |
| Irregularidades de jornada | Working-time discrepancies | Não afirmar infrações comprovadas. |
| Admissões / desligamentos | Hires / departures | “Departures” não restringe desligamentos a demissões. |
| Afastamentos / férias | Leaves of absence / vacation | Distinguir afastamentos de férias; confirmar convenção linguística. |
| Atendimentos de segundo nível | Second-level support requests | HR Support permanece inalterado como denominação. |
| Headcount | Headcount | Já está em inglês. |
| Planejamento e Simulação de Ocupação | Space Occupancy Planning and Simulation | Refere-se a espaços de trabalho, não à ocupação de cargos. |
| Dimensionamento / capacidade | Capacity planning / capacity | Não pressupõe otimização ou ganhos quantitativos. |
| Premissas | Assumptions | Sem introduzir novas premissas. |
| Déficits | Shortfalls | Quantidade insuficiente de capacidade, sem valor numérico novo. |
| Relatórios executivos | Executive reports | Mesma finalidade de apresentação e discussão. |
| Preview conceitual | Conceptual preview | Não apresentar como screenshot real. |
| Revogar consentimento | Withdraw consent | Não significa apagar automaticamente dados já enviados. |
| Análise de tráfego | Traffic analytics | Preservar caráter opcional e condições de consentimento. |

### Elementos que permanecem inalterados

`Victor Ciola Rinaldo`, `Smartworking`, `HR Support`, `Power BI`, `Power Apps`, `Power Fx`, `Power Automate`, `Power Query`, `Power BI Dataflows`, `Power BI Service`, `Power BI Service Dataflows`, `Dataflows`, `SharePoint`, `SharePoint Lists`, `Power Platform`, `SAP`, `DAX`, `Excel`, `SQL`, `Python`, `HTML`, `CSS`, `JavaScript`, `VBA`, `Git`, `GitHub`, `LinkedIn`, `Google Analytics 4`, `Google Signals`, `GitHub Pages`, `ETL` e `BI`.

Também permanecem intactos todos os endereços e identificadores, incluindo `data-project`, IDs de seções, classes CSS, seletores de previews, nomes de ícones, eventos e parâmetros do GA4, valores `accepted`/`declined`, chaves de armazenamento e prefixo `portfolio`. “SAP (sistema de origem)” torna-se “SAP (source system)”: o produto não muda; apenas a explicação é traduzida. “Modelagem de dados”, “Lógica de negócios”, “Análise de dados” e “Simulação de cenários” são competências descritivas e recebem tradução.

Preservar símbolos, números de etapas, `01 / 03`, categorias numeradas, ponto azul, setas, separadores, `—`, porcentagens e aproximações. Os rótulos já ingleses “Data Analytics”, “Business Intelligence”, “Automation”, “Workflow” e “Headcount” não precisam de alteração.

## 2. Página principal — navegação, apresentação e seções

### 2.1 Cabeçalho e navegação (`index.html:31–37`)

| Português atual | English — proposta |
| --- | --- |
| Pular para o conteúdo | Skip to content |
| Início | Home |
| Sobre | About |
| Soluções | Solutions |
| Projetos | Projects |
| Contato | Contact |

A marca visível “Victor Ciola Rinaldo.” permanece inalterada. Os destinos das âncoras e dos contatos também permanecem iguais.

### 2.2 Apresentação inicial (`index.html:44–64`)

| Português atual | English — proposta |
| --- | --- |
| PORTFÓLIO PROFISSIONAL | PROFESSIONAL PORTFOLIO |
| Dados, automação e desenvolvimento de soluções. | Data, automation and solution development. |
| Transformo necessidades de negócio em aplicações, automações e soluções analíticas que simplificam processos e apoiam decisões. | I turn business needs into applications, automations and analytical solutions that simplify processes and support decisions. |
| Ver projetos | View projects |
| E-mail | Email |
| Dados | Data |
| Processos | Processes |
| Soluções | Solutions |
| Sobre mim | About me |

**Composição da frase com destaque visual:** o texto anterior ao `<span>` é “Data, automation and”; o trecho destacado é “solution development.”. A frase completa permanece “Data, automation and solution development.”, sem perder o destaque nem omitir “desenvolvimento”. “Data Analytics • Business Intelligence • Automation”, LinkedIn e GitHub permanecem iguais.

### 2.3 Sobre mim (`index.html:67`)

| Português atual | English — proposta |
| --- | --- |
| 01 / Sobre | 01 / About |
| Sobre mim | About me |
| Desenvolvo soluções que conectam conhecimento de negócio, análise de dados e tecnologia para simplificar processos e apoiar decisões. | I develop solutions that connect business knowledge, data analysis and technology to simplify processes and support decisions. |
| Minha experiência em processos corporativos, especialmente em Recursos Humanos, permite identificar oportunidades de melhoria e transformá-las em aplicações, automações e análises de dados. | My experience with corporate processes, particularly in Human Resources, enables me to identify opportunities for improvement and turn them into applications, automations and data analyses. |
| Atuo com ferramentas como Power BI, Power Apps, Power Automate, Power Query, Python e tecnologias web, desenvolvendo soluções aplicadas a necessidades reais do ambiente corporativo. | I work with tools such as Power BI, Power Apps, Power Automate, Power Query, Python and web technologies to develop solutions for real business needs. |

### 2.4 O que eu faço (`index.html:70–93`)

| Português atual | English — proposta |
| --- | --- |
| 02 / Soluções | 02 / Solutions |
| O que eu faço | What I do |
| Análise de Dados & BI | Data Analytics & BI |
| Desenvolvo dashboards, indicadores e análises de dados utilizando Power BI, DAX e outras ferramentas para acompanhar processos e apoiar decisões. | I develop dashboards, indicators and data analyses using Power BI, DAX and other tools to track processes and support decisions. |
| Preparação de Dados & ETL | Data Preparation & ETL |
| Realizo extração, tratamento, transformação e integração de dados utilizando Power Query, SQL e Python. | I extract, process, transform and integrate data using Power Query, SQL and Python. |
| Automação & Aplicações | Automation & Applications |
| Desenvolvo aplicações, automações e fluxos de trabalho utilizando Power Platform e tecnologias web. | I develop applications, automations and workflows using Power Platform and web technologies. |

Listas de tecnologias preservadas, na ordem atual: **01:** Power BI, DAX, Excel. **02:** Power Query, SQL, Python. **03:** Power Apps, Power Automate, SharePoint, JavaScript, HTML / CSS, VBA, Git / GitHub.

### 2.5 Projetos — rótulos compartilhados (`index.html:97–190`)

| Português atual | English — proposta |
| --- | --- |
| 03 / Projetos | 03 / Projects |
| Projetos | Projects |
| Necessidade | Business need |
| Ver detalhes | View details |
| 01 / Aplicação corporativa | 01 / Business application |
| 02 / Transformação digital | 02 / Digital transformation |
| 03 / Tratamento e integração de dados | 03 / Data processing and integration |
| 04 / Business Intelligence | 04 / Business Intelligence |
| 05 / Desenvolvimento web e simulação | 05 / Web development and simulation |

Os títulos, descrições principais e necessidades dos cinco cards estão detalhados na seção 3. Os rótulos numéricos 01 a 05 não mudam.

### 2.6 Contato e rodapé (`index.html:196–212`)

| Português atual | English — proposta |
| --- | --- |
| 04 / Contato | 04 / Contact |
| Contato | Contact |
| Vamos nos conectar | Let's connect |
| Aberto a conexões profissionais, troca de experiências e oportunidades nas áreas de dados, automação e tecnologia. | Open to professional connections, sharing experiences and opportunities in data, automation and technology. |
| E-mail | Email |
| Preferências de privacidade | Privacy preferences |
| Política de Privacidade | Privacy Policy |
| Voltar ao início | Back to top |

O título completo é **“Let's connect?”**, preservando o ponto de interrogação separado no HTML. Nome, LinkedIn, GitHub, e-mail e respectivos endereços permanecem inalterados. O GitHub continua com o estado desativado atual; a tradução não cria um link ativo.

## 3. Traduções completas dos cinco projetos

Fonte dos conteúdos do modal: `assets/js/app.js`, objeto `PROJECTS`. Fonte das necessidades dos cards: `index.html`. Cada projeto conserva quatro KPIs. Não existem novos números ou parágrafos metodológicos. Cabeçalhos comuns dos modais estão na seção 4.

### 3.1 Gestão de Movimentações de Colaboradores

Identificador preservado: `movimentacoes`. Fonte: `assets/js/app.js:14` e card correspondente em `index.html`.

| Campo | Português atual | English — proposta |
| --- | --- | --- |
| Título — card e modal | Gestão de Movimentações de Colaboradores | Employee Movement Management |
| Descrição principal — card e modal | Aplicação desenvolvida com Power Apps para digitalizar solicitações de movimentação de colaboradores, estruturando fluxos de aprovação, controles de acesso e notificações automatizadas. | Application developed with Power Apps to digitize employee movement requests, with structured approval workflows, access controls and automated notifications. |
| Necessidade — card | Centralizar solicitações, organizar aprovações e acompanhar o histórico das movimentações. | Centralize requests, organize approvals and track employee movement history. |
| Contexto / Problema | As solicitações eram registradas em um formulário SharePoint, enquanto as aprovações eram solicitadas por e-mail, sem um fluxo estruturado de aprovação. | Requests were recorded in a SharePoint form, while approvals were requested by email, without a structured approval workflow. |
| Solução | Desenvolvi uma aplicação utilizando Power Apps, Power Fx, SharePoint Lists e Power Automate para centralizar as solicitações e organizar o fluxo de aprovações entre as áreas responsáveis. | I developed an application using Power Apps, Power Fx, SharePoint Lists and Power Automate to centralize requests and organize the approval workflow across the responsible departments. |
| Como funciona | As solicitações são cadastradas e acompanhadas na aplicação. As aprovações seguem condições e etapas, com acesso conforme perfil e responsabilidade, devoluções para ajustes e notificações automatizadas. | Requests are submitted and tracked in the application. Approvals follow defined conditions and stages, with access based on role and responsibility, requests returned for adjustments and automated notifications. |
| Título da seção de resultados | Resultados e benefícios | Results and benefits |
| Texto de resultados | A solução transformou um processo de aprovações conduzido por e-mails em um fluxo estruturado, com etapas, responsáveis e regras definidas. | The solution transformed an email-based approval process into a structured workflow with defined stages, responsibilities and rules. |

**Etapas — ordem atual preservada**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Solicitações | Requests |
| 2 | Aprovações | Approvals |
| 3 | Histórico | History |
| 4 | Indicadores | Indicators |

**Principais funcionalidades**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Cadastro e acompanhamento de solicitações | Request submission and tracking |
| 2 | Aprovações condicionais por etapas | Conditional approvals by stage |
| 3 | Acesso conforme perfil e responsabilidade | Access based on role and responsibility |
| 4 | Aprovações em lote | Batch approvals |
| 5 | Devolução de solicitações para ajustes | Requests returned for adjustments |
| 6 | Notificações automáticas | Automated notifications |
| 7 | Histórico de status, responsáveis, datas e observações | History of statuses, responsible parties, dates and notes |
| 8 | Indicadores em Power BI | Indicators in Power BI |
| 9 | Extração de informações para Excel utilizando Power Query | Data extraction to Excel using Power Query |

**Tecnologias e competências — ordem atual preservada**

| Português atual | English — proposta |
| --- | --- |
| Power Apps | Power Apps |
| Power Fx | Power Fx |
| SharePoint | SharePoint |
| Power Automate | Power Automate |
| Power BI | Power BI |
| Power Query | Power Query |

**Parágrafos complementares de benefícios**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Com a centralização das solicitações e o registro das decisões, o processo ganhou maior padronização, visibilidade e rastreabilidade. | Centralizing requests and recording decisions improved process standardization, visibility and traceability. |
| 2 | Em operação desde abril de 2022, a aplicação passou a apoiar continuamente a gestão das movimentações de colaboradores. | In operation since April 2022, the application has provided ongoing support for managing employee movements. |

**Quatro KPIs — rótulos, destaques e descrições**

| Card / campo | Português atual | English — proposta |
| --- | --- | --- |
| Card 1 — rótulo | Operação contínua | Ongoing operation |
| Card 1 — destaque | Desde 2022 | Since 2022 |
| Card 1 — descrição | Solução em operação desde abril de 2022. | Solution in operation since April 2022. |
| Card 2 — rótulo | Acompanhamento | Tracking |
| Card 2 — destaque | Status por etapa | Status by stage |
| Card 2 — descrição | Visibilidade sobre o andamento das solicitações e suas etapas de aprovação. | Visibility into request progress and approval stages. |
| Card 3 — rótulo | Fluxo estruturado | Structured workflow |
| Card 3 — destaque | Aprovações organizadas | Organized approvals |
| Card 3 — descrição | Etapas, responsáveis e regras de aprovação definidos. | Defined approval stages, responsibilities and rules. |
| Card 4 — rótulo | Rastreabilidade | Traceability |
| Card 4 — destaque | Histórico centralizado | Centralized history |
| Card 4 — descrição | Registro de status, responsáveis, decisões e observações. | Record of statuses, responsible parties, decisions and notes. |

**Preservação:** abril de 2022 → April 2022; “Desde 2022” → “Since 2022”. Sem volume operacional removido nem descrição do processo anterior como planilhas.

**Preview conceitual — card e modal**

| Português atual | English — proposta |
| --- | --- |
| Movimentações | Employee movements |
| Workflow | Workflow |
| VISÃO CONCEITUAL | CONCEPTUAL VIEW |
| Solicitações e aprovações, conectadas. | Requests and approvals, connected. |
| 1 | 1 |
| Solicitações | Requests |
| Cadastro e acompanhamento | Submission and tracking |
| 2 | 2 |
| Aprovações | Approvals |
| Condições, etapas e perfis | Conditions, stages and roles |
| 3 | 3 |
| Ajustes | Adjustments |
| Devolução para correção | Returned for correction |
| 4 | 4 |
| Histórico | History |
| Status, datas e observações | Statuses, dates and notes |
| 5 | 5 |
| Indicadores | Indicators |
| Power BI e consultas em Excel | Power BI and queries in Excel |
| ◎ | ◎ |
| Perfis de acesso · Aprovações · Notificações | Access roles · Approvals · Notifications |
| Preview conceitual · sem dados reais | Conceptual preview · no real data |

### 3.2 Gestão de Smartworking

Identificador preservado: `smartworking`. Fonte: `assets/js/app.js:78` e card correspondente em `index.html`.

| Campo | Português atual | English — proposta |
| --- | --- | --- |
| Título — card e modal | Gestão de Smartworking | Hybrid Work Management (Smartworking) |
| Descrição principal — card e modal | Solução digital para gestão do modelo de trabalho híbrido, integrando informações, automatizando processos e disponibilizando indicadores gerenciais para apoiar a tomada de decisão. | Digital solution for managing the hybrid work model, integrating information, automating processes and providing management indicators to support decision-making. |
| Necessidade — card | Organizar a gestão do modelo híbrido, integrar informações e apoiar o acompanhamento gerencial. | Organize hybrid work management, integrate information and support management tracking. |
| Contexto / Problema | O acompanhamento do modelo de trabalho híbrido era realizado por meio de planilhas distribuídas manualmente entre gestores e profissionais de RH. | The hybrid work model was managed through spreadsheets distributed manually to managers and HR professionals. |
| Solução | Desenvolvi uma aplicação com Power Apps, SharePoint e Power Automate, integrada a dashboards no Power BI. | I developed an application with Power Apps, SharePoint and Power Automate, integrated with dashboards in Power BI. |
| Como funciona | A aplicação centraliza informações do modelo híbrido para consulta pelos gestores e profissionais de RH, respeitando os perfis de acesso e disponibilizando indicadores gerenciais. | The application centralizes information on the hybrid work model for managers and HR professionals to consult, respecting access roles and providing management indicators. |
| Título da seção de resultados | Resultados e benefícios | Results and benefits |
| Texto de resultados | A solução substituiu a circulação de múltiplas planilhas por um ambiente centralizado de informações e acompanhamento do modelo de trabalho híbrido. | The solution replaced the circulation of multiple spreadsheets with a centralized environment for information and hybrid work management. |

**Etapas — ordem atual preservada**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Consulta das informações | Information access |
| 2 | Indicadores | Indicators |

**Principais funcionalidades**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Consulta de informações do modelo híbrido pelos gestores | Access to hybrid work information for managers |
| 2 | Controle de acesso conforme o perfil | Role-based access control |
| 3 | Notificações automatizadas | Automated notifications |
| 4 | Indicadores gerenciais para acompanhamento do modelo de trabalho híbrido | Management indicators for tracking the hybrid work model |

**Tecnologias e competências — ordem atual preservada**

| Português atual | English — proposta |
| --- | --- |
| Power Apps | Power Apps |
| SharePoint | SharePoint |
| Power Automate | Power Automate |
| Power BI | Power BI |

**Parágrafos complementares de benefícios**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | A padronização das informações e a eliminação da consolidação manual dos arquivos reduziram o trabalho operacional mensal de preparação e consolidação de dados. | Standardizing information and eliminating manual file consolidation reduced the monthly operational work involved in data preparation and consolidation. |
| 2 | Além da economia estimada de tempo, o aplicativo trouxe maior rastreabilidade das decisões, organização do processo e disponibilidade de indicadores para acompanhamento gerencial. | In addition to the estimated time savings, the application improved decision traceability, process organization and the availability of indicators to support management. |

**Quatro KPIs — rótulos, destaques e descrições**

| Card / campo | Português atual | English — proposta |
| --- | --- | --- |
| Card 1 — rótulo | Economia mensal | Estimated Monthly Time Savings |
| Card 1 — destaque | 13–22 h | 13–22 h |
| Card 1 — descrição | Economia mensal estimada de trabalho operacional. | Estimated monthly savings in operational work. |
| Card 2 — rótulo | Redução de esforço | Effort reduction |
| Card 2 — destaque | ~85% | ~85% |
| Card 2 — descrição | Redução estimada do esforço de preparação e consolidação. | Estimated reduction in preparation and consolidation effort. |
| Card 3 — rótulo | Centralização | Centralization |
| Card 3 — destaque | Base centralizada | Centralized data |
| Card 3 — descrição | Eliminação da necessidade de reunir diferentes versões de planilhas. | No need to bring together different versions of spreadsheets. |
| Card 4 — rótulo | Rastreabilidade | Traceability |
| Card 4 — destaque | Aprovações rastreáveis | Traceable approvals |
| Card 4 — descrição | Decisões registradas diretamente na aplicação. | Decisions recorded directly in the application. |

**Preservação:** `13–22 h` continua identificado pelo rótulo mensal e pela descrição de estimativa. `~85%` permanece ligado ao esforço de preparação e consolidação. Nenhuma referência a justificativas, fiscalização ou métricas novas. As duas etapas atuais permanecem apenas duas.

**Preview conceitual — card e modal**

| Português atual | English — proposta |
| --- | --- |
| Smartworking | Smartworking |
| Híbrido | Hybrid |
| VISÃO CONCEITUAL | CONCEPTUAL VIEW |
| Um modelo híbrido, organizado. | An organized hybrid work model. |
| 1 | 1 |
| Informações | Information |
| Consulta organizada por perfil | Information access organized by role |
| 2 | 2 |
| Automação | Automation |
| Notificações automatizadas | Automated notifications |
| 3 | 3 |
| Gestão | Management |
| Informações para acompanhamento gerencial | Information to support management |
| 4 | 4 |
| Indicadores | Indicators |
| Análises do modelo híbrido | Hybrid work analyses |
| ◎ | ◎ |
| Integração · Automação · Indicadores | Integration · Automation · Indicators |
| Preview conceitual · sem dados reais | Conceptual preview · no real data |

### 3.3 Automação de ETL e Integração de Dados de RH

Identificador preservado: `etl`. Fonte: `assets/js/app.js:134` e card correspondente em `index.html`.

| Campo | Português atual | English — proposta |
| --- | --- | --- |
| Título — card e modal | Automação de ETL e Integração de Dados de RH | ETL Automation and HR Data Integration |
| Descrição principal — card e modal | Automação do tratamento, transformação, padronização, integração e consolidação de dados de Recursos Humanos com Power Query e Dataflows, para alimentar relatórios e indicadores. | Automation of HR data processing, transformation, standardization, integration and consolidation with Power Query and Dataflows to feed reports and indicators. |
| Necessidade — card | Preparar e consolidar relatórios extraídos manualmente do SAP para análises de RH. | Prepare and consolidate reports extracted manually from SAP for HR analytics. |
| Contexto / Problema | Relatórios extraídos manualmente do SAP precisavam passar por processos de preparação e consolidação para serem utilizados em análises de RH. | Reports extracted manually from SAP required preparation and consolidation before they could be used in HR analytics. |
| Solução | Desenvolvi fluxos reutilizáveis de tratamento de dados com Power BI Service Dataflows e Power Query, padronizando estruturas e consolidando informações provenientes dos relatórios disponibilizados em pastas. | I developed reusable data processing flows with Power BI Service Dataflows and Power Query, standardizing structures and consolidating information from reports made available in folders. |
| Como funciona | A extração inicial dos relatórios do SAP é manual. A partir dos arquivos disponibilizados em pastas, os fluxos tratam e consolidam os dados. Determinados fluxos têm atualização diária programada; outros são atualizados sob demanda. | The initial extraction of SAP reports is manual. Once the files are available in folders, the flows process and consolidate the data. Certain flows have scheduled daily refreshes; others are refreshed on demand. |
| Título da seção de resultados | Impacto e benefícios | Impact and benefits |
| Texto de resultados | Fluxos reutilizáveis de transformação e integração padronizaram os dados e reduziram o esforço manual nas atualizações dos relatórios de RH. | Reusable transformation and integration flows standardized the data and reduced manual effort when updating HR reports. |

**Etapas — ordem atual preservada**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Extração manual do SAP | Manual SAP extraction |
| 2 | Arquivos em pastas | Files in folders |
| 3 | Tratamento | Processing |
| 4 | Consolidação | Consolidation |
| 5 | Relatórios | Reports |

**Principais funcionalidades**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Tratamento e padronização de arquivos de origem | Processing and standardization of source files |
| 2 | Consolidação de diferentes conjuntos de dados | Consolidation of different datasets |
| 3 | Reutilização de consultas e regras de transformação | Reuse of queries and transformation rules |
| 4 | Atualizações programadas diariamente em determinados fluxos | Scheduled daily refreshes for certain flows |
| 5 | Atualizações sob demanda em outros fluxos | On-demand refreshes for other flows |
| 6 | Disponibilização de dados para dashboards e relatórios destinados ao RH | Data made available for HR dashboards and reports |
| 7 | Tratamento de temas como horas extras, banco de horas, sobreaviso e irregularidades de jornada | Processing of topics such as overtime, working-hour balances, on-call duty and working-time discrepancies |

**Tecnologias e competências — ordem atual preservada**

| Português atual | English — proposta |
| --- | --- |
| Power Query | Power Query |
| Power BI Dataflows | Power BI Dataflows |
| Power BI Service | Power BI Service |
| ETL | ETL |
| SAP (sistema de origem) | SAP (source system) |

Este projeto não possui parágrafos adicionais de benefícios abaixo dos cards; não acrescentar textos nessa posição.

**Quatro KPIs — rótulos, destaques e descrições**

| Card / campo | Português atual | English — proposta |
| --- | --- | --- |
| Card 1 — rótulo | Economia mensal | Estimated Monthly Time Savings |
| Card 1 — destaque | ~7–8 h/mês | ~7–8 h/month |
| Card 1 — descrição | Economia mensal estimada de trabalho manual. | Estimated monthly savings in manual work. |
| Card 2 — rótulo | Redução de esforço | Effort reduction |
| Card 2 — destaque | 75%–85% | 75%–85% |
| Card 2 — descrição | Redução estimada do esforço manual por atualização. | Estimated reduction in manual effort per update. |
| Card 3 — rótulo | Automação | Automation |
| Card 3 — destaque | Tratamento automatizado | Automated processing |
| Card 3 — descrição | Transformações e integrações executadas por fluxos reutilizáveis. | Transformations and integrations executed through reusable flows. |
| Card 4 — rótulo | Padronização | Standardization |
| Card 4 — destaque | Dados padronizados | Standardized data |
| Card 4 — descrição | Regras consistentes para atualização dos relatórios de RH. | Consistent rules for updating HR reports. |

**Preservação:** `~7–8 h/mês` → `~7–8 h/month`; `75%–85%` permanece exato. “Estimated” permanece nas duas descrições. Extração inicial manual do SAP explicitada; programação diária somente em determinados fluxos. Nenhuma afirmação de automação integral de ponta a ponta.

**Preview conceitual — card e modal**

| Português atual | English — proposta |
| --- | --- |
| Dados de RH | HR data |
| ETL | ETL |
| VISÃO CONCEITUAL | CONCEPTUAL VIEW |
| Arquivos preparados para análise. | Files prepared for analysis. |
| 1 | 1 |
| Relatórios SAP | SAP reports |
| Extração inicial manual | Manual initial extraction |
| 2 | 2 |
| Arquivos em pastas | Files in folders |
| Conjuntos de dados de origem | Source datasets |
| 3 | 3 |
| Power Query | Power Query |
| Tratamento e padronização | Processing and standardization |
| 4 | 4 |
| Dataflows | Dataflows |
| Consolidação e reutilização | Consolidation and reuse |
| 5 | 5 |
| Relatórios e indicadores | Reports and indicators |
| Dados disponibilizados ao RH | Data made available to HR |
| ◎ | ◎ |
| Atualizações diárias ou sob demanda | Daily or on-demand refreshes |
| Preview conceitual · sem dados reais | Conceptual preview · no real data |

### 3.4 Central de Indicadores de RH

Identificador preservado: `indicadores`. Fonte: `assets/js/app.js:193` e card correspondente em `index.html`.

| Campo | Português atual | English — proposta |
| --- | --- | --- |
| Título — card e modal | Central de Indicadores de RH | HR Analytics Hub |
| Descrição principal — card e modal | Desenvolvimento de uma solução integrada de Business Intelligence, reunindo dashboards e indicadores de diferentes processos de Recursos Humanos em um aplicativo centralizado no Power BI Service. | Development of an integrated Business Intelligence solution, bringing together dashboards and indicators from different Human Resources processes in a centralized app on Power BI Service. |
| Necessidade — card | Reunir análises operacionais e gerenciais em um ambiente único, com acesso restrito ao RH. | Bring together operational and management analyses in a single environment, with access restricted to HR. |
| Contexto / Problema | Antes da solução, não havia um ambiente permanente para consultar os indicadores de RH. As informações eram organizadas em apresentações conforme surgiam necessidades específicas. | Before the solution, there was no permanent environment for consulting HR indicators. Information was organized into presentations as specific needs arose. |
| Solução | Desenvolvi todos os dashboards e indicadores em Power BI, utilizando modelagem de dados, DAX, Power Query e visualizações interativas. Organizei e publiquei os conteúdos em um aplicativo no Power BI Service. | I developed all dashboards and indicators in Power BI using data modeling, DAX, Power Query and interactive visualizations. I organized and published the content in an app on Power BI Service. |
| Como funciona | O aplicativo organiza a navegação por temas e reúne análises operacionais e gerenciais. Seu acesso é restrito aos profissionais de Recursos Humanos. | The app organizes navigation by topic and brings together operational and management analyses. Access is restricted to Human Resources professionals. |
| Título da seção de resultados | Resultados e benefícios | Results and benefits |
| Texto de resultados | A Central de Indicadores reúne dashboards de diferentes temas de RH em um ambiente permanente de consulta, com visualizações interativas e acesso direto pelas áreas. | The HR Analytics Hub brings together dashboards covering different HR topics in a permanent environment for consultation, with interactive visualizations and direct access for HR departments. |

**Etapas — ordem atual preservada**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Modelagem de dados | Data modeling |
| 2 | Indicadores | Indicators |
| 3 | Visualizações | Visualizations |
| 4 | Aplicativo no Power BI Service | App on Power BI Service |

**Principais funcionalidades**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Dashboards de atendimentos de segundo nível do HR Support | Dashboards for second-level HR Support requests |
| 2 | Indicadores de headcount, admissões, desligamentos, afastamentos e férias | Indicators covering headcount, hires, departures, leaves of absence and vacation |
| 3 | Análises de horas extras e sobreaviso | Overtime and on-call duty analyses |
| 4 | Indicadores de movimentações de colaboradores | Employee movement indicators |
| 5 | Indicadores do modelo de trabalho híbrido | Hybrid work model indicators |

**Tecnologias e competências — ordem atual preservada**

| Português atual | English — proposta |
| --- | --- |
| Power BI | Power BI |
| DAX | DAX |
| Power Query | Power Query |
| Modelagem de dados | Data modeling |
| Power BI Service | Power BI Service |

Este projeto não possui parágrafos adicionais de benefícios abaixo dos cards; não acrescentar textos nessa posição.

**Quatro KPIs — rótulos, destaques e descrições**

| Card / campo | Português atual | English — proposta |
| --- | --- | --- |
| Card 1 — rótulo | Abrangência | Coverage |
| Card 1 — destaque | 7 dashboards | 7 dashboards |
| Card 1 — descrição | Painéis que abrangem diferentes temas e processos de RH. | Dashboards covering different HR topics and processes. |
| Card 2 — rótulo | Disponibilidade | Availability |
| Card 2 — destaque | Consulta permanente | Ongoing access |
| Card 2 — descrição | Indicadores disponíveis independentemente de apresentações pontuais. | Indicators available independently of one-off presentations. |
| Card 3 — rótulo | Experiência de análise | Analysis experience |
| Card 3 — destaque | Exploração interativa | Interactive exploration |
| Card 3 — descrição | Filtros e visualizações para consultar diferentes recortes dos dados. | Filters and visualizations for exploring different views of the data. |
| Card 4 — rótulo | Acessibilidade | Accessibility |
| Card 4 — destaque | Acesso direto | Direct access |
| Card 4 — descrição | Áreas de RH podem consultar os painéis sem solicitar relatórios específicos. | HR departments can consult the dashboards without requesting specific reports. |

**Preservação:** `7 dashboards` é quantidade informada, sem aproximador. Não acrescentar adesão regular, utilização por todas as áreas, economia de horas ou melhoria comprovada de decisões; não reintroduzir o antigo card de temas.

**Preview conceitual — card e modal**

| Português atual | English — proposta |
| --- | --- |
| Indicadores de RH | HR indicators |
| BI | BI |
| VISÃO CONCEITUAL | CONCEPTUAL VIEW |
| Indicadores organizados por tema. | Indicators organized by topic. |
| 1 | 1 |
| HR Support | HR Support |
| Atendimentos de segundo nível | Second-level support requests |
| 2 | 2 |
| Quadro de colaboradores | Workforce |
| Headcount e eventos de pessoal | Headcount and employee events |
| 3 | 3 |
| Jornada | Working time |
| Horas extras e sobreaviso | Overtime and on-call duty |
| 4 | 4 |
| Movimentações | Employee movements |
| Acompanhamento dos processos | Process tracking |
| 5 | 5 |
| Modelo híbrido | Hybrid work model |
| Gestão de Smartworking | Hybrid Work Management (Smartworking) |
| ◎ | ◎ |
| Aplicativo no Power BI Service · Acesso restrito ao RH | App on Power BI Service · Access restricted to HR |
| Preview conceitual · sem dados reais | Conceptual preview · no real data |

### 3.5 Planejamento e Simulação de Ocupação

Identificador preservado: `espaco`. Fonte: `assets/js/app.js:249` e card correspondente em `index.html`.

| Campo | Português atual | English — proposta |
| --- | --- | --- |
| Título — card e modal | Planejamento e Simulação de Ocupação | Space Occupancy Planning and Simulation |
| Descrição principal — card e modal | Ferramenta web interativa para dimensionamento de capacidade, distribuição de equipes e análise comparativa de cenários, com geração automática de indicadores e relatórios executivos. | Interactive web tool for capacity planning, team allocation and comparative scenario analysis, with automatic generation of indicators and executive reports. |
| Necessidade — card | Relacionar capacidade, equipes e premissas para comparar cenários de ocupação e apoiar o planejamento. | Bring together capacity, teams and assumptions to compare occupancy scenarios and support planning. |
| Contexto / Problema | Uma necessidade específica de planejamento exigia comparar propostas de distribuição das equipes, considerando a capacidade dos espaços e os critérios de proximidade operacional. A ferramenta foi desenvolvida para explorar essas alternativas de ocupação. | A specific planning need required comparing proposed team allocations, considering space capacity and operational proximity criteria. The tool was developed to explore these occupancy alternatives. |
| Solução | Desenvolvi uma ferramenta web em HTML, CSS e JavaScript que permite construir cenários de ocupação, distribuir equipes entre andares e zonas, ajustar parâmetros e avaliar alternativas de alocação. | I developed a web tool in HTML, CSS and JavaScript that allows users to build occupancy scenarios, allocate teams across floors and zones, adjust parameters and evaluate allocation alternatives. |
| Como funciona | Os cenários combinam capacidade, equipes e premissas de ocupação, incluindo exceções e absenteísmo. A ferramenta permite distribuir equipes de forma interativa, comparar alternativas e gerar indicadores e relatórios executivos. | Scenarios combine capacity, teams and occupancy assumptions, including exceptions and absenteeism. The tool supports interactive team allocation, comparison of alternatives and generation of indicators and executive reports. |
| Título da seção de resultados | Resultados e benefícios | Results and benefits |
| Texto de resultados | A ferramenta permite construir e comparar cenários de ocupação, avaliar a capacidade dos espaços e organizar os resultados para apoiar o planejamento. | The tool allows users to build and compare occupancy scenarios, assess space capacity and organize results to support planning. |

**Etapas — ordem atual preservada**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Premissas | Assumptions |
| 2 | Distribuição de equipes | Team allocation |
| 3 | Simulação | Simulation |
| 4 | Comparação | Comparison |
| 5 | Relatórios executivos | Executive reports |

**Principais funcionalidades**

| Ordem | Português atual | English — proposta |
| --- | --- | --- |
| 1 | Distribuição interativa de equipes | Interactive team allocation |
| 2 | Dimensionamento de capacidade | Capacity planning |
| 3 | Simulação e comparação de cenários | Scenario simulation and comparison |
| 4 | Aplicação de premissas de ocupação, exceções e absenteísmo | Application of occupancy assumptions, exceptions and absenteeism |
| 5 | Identificação de déficits e capacidade disponível | Identification of shortfalls and available capacity |
| 6 | Indicadores e relatórios automáticos | Automatic indicators and reports |
| 7 | Comparativos e análises executivas | Comparisons and executive analyses |

**Tecnologias e competências — ordem atual preservada**

| Português atual | English — proposta |
| --- | --- |
| HTML | HTML |
| CSS | CSS |
| JavaScript | JavaScript |
| Lógica de negócios | Business logic |
| Análise de dados | Data analysis |
| Simulação de cenários | Scenario simulation |

Este projeto não possui parágrafos adicionais de benefícios abaixo dos cards; não acrescentar textos nessa posição.

**Quatro KPIs — rótulos, destaques e descrições**

| Card / campo | Português atual | English — proposta |
| --- | --- | --- |
| Card 1 — rótulo | Planejamento | Planning |
| Card 1 — destaque | Múltiplos cenários | Multiple scenarios |
| Card 1 — descrição | Possibilidade de testar diferentes distribuições de equipes e espaços. | Ability to test different team and space allocations. |
| Card 2 — rótulo | Dimensionamento | Capacity planning |
| Card 2 — destaque | Déficits e capacidade | Shortfalls and capacity |
| Card 2 — descrição | Identificação de vagas disponíveis, excedentes e necessidades de alocação. | Identification of available spaces, surpluses and allocation needs. |
| Card 3 — rótulo | Avaliação | Assessment |
| Card 3 — destaque | Impacto das mudanças | Impact of changes |
| Card 3 — descrição | Recálculo dos indicadores conforme as alocações são ajustadas. | Indicators recalculated as allocations are adjusted. |
| Card 4 — rótulo | Comunicação | Communication |
| Card 4 — destaque | Visão executiva | Executive overview |
| Card 4 — descrição | Comparativos e relatórios estruturados para apresentação das propostas. | Structured comparisons and reports for presenting proposals. |

**Preservação:** quatro destaques qualitativos, sem números de capacidade, usuários, cenários ou economia. Contexto de necessidade específica, sem alegar substituição formal de Excel ou PowerPoint.

**Preview conceitual — card e modal**

| Português atual | English — proposta |
| --- | --- |
| Simulação de Ocupação | Occupancy simulation |
| Cenários | Scenarios |
| SIMULAÇÃO DE OCUPAÇÃO | OCCUPANCY SIMULATION |
| Um espaço. Novas possibilidades. | One space. New possibilities. |
| Cenário A | Scenario A |
| Cenário B | Scenario B |
| Comparação | Comparison |
| Capacidade | Capacity |
| — | — |
| lugares | spaces |
| Ocupação simulada | Simulated occupancy |
| pessoas | people |
| Zona A | Zone A |
| Zona B | Zone B |
| Zona C | Zone C |
| Circulação | Circulation |
| Ocupado | Occupied |
| Disponível | Available |
| Visão ilustrativa | Illustrative view |
| Preview conceitual · sem dados reais | Conceptual preview · no real data |

## 4. Interface compartilhada dos modais

Fonte: `assets/js/app.js:404–498` e estrutura do dialog em `index.html:213`. Aplicar aos cinco projetos sem duplicar o componente.

| Português atual | English — proposta |
| --- | --- |
| Detalhes do projeto | Project details |
| Contexto / Problema | Context / Problem |
| Solução | Solution |
| Como funciona | How it works |
| Principais funcionalidades | Key features |
| Resultados e benefícios | Results and benefits |
| Impacto e benefícios | Impact and benefits |
| Screenshots / Preview conceitual | Screenshots / Conceptual preview |
| Preview conceitual, sem dados corporativos. Screenshots definitivos ainda não foram incluídos. | Conceptual preview, with no corporate data. Final screenshots have not yet been included. |

Manter “Impact and benefits” especificamente no ETL e “Results and benefits” nos outros quatro projetos. O símbolo × e o comportamento de fechamento não mudam.

## 5. Consentimento e mensagens de privacidade compartilhadas

Fontes: `index.html:214–222`, `privacidade.html:37–45` e `assets/js/analytics.js:88–125`. As mesmas traduções devem atender às duas páginas.

| Português atual | English — proposta |
| --- | --- |
| Sua privacidade | Your privacy |
| Este site utiliza análise de tráfego opcional com Google Analytics 4. A coleta começa somente se você aceitar. Você pode recusar ou rever sua escolha no rodapé. | This site uses optional traffic analytics with Google Analytics 4. Data collection starts only if you accept. You can decline or review your choice in the footer. |
| Política de Privacidade | Privacy Policy |
| Aceitar | Accept |
| Recusar | Decline |
| Preferências de privacidade | Privacy preferences |
| Sua escolha atual: análise de tráfego aceita. | Your current choice: traffic analytics accepted. |
| Sua escolha atual: análise de tráfego recusada. | Your current choice: traffic analytics declined. |
| Análise de tráfego aceita. | Traffic analytics accepted. |
| Análise de tráfego recusada. | Traffic analytics declined. |
| O navegador não permitiu salvar a preferência. Ela vale apenas nesta página; ao atualizar, uma escolha anteriormente salva poderá ser aplicada. | Your browser did not allow the preference to be saved. It applies only to this page; when you reload, a previously saved choice may be applied. |
| Ative o JavaScript para abrir os detalhes dos projetos. O conteúdo e a navegação da página continuam disponíveis. | Enable JavaScript to open project details. Page content and navigation remain available. |
| A análise de tráfego permanece desativada sem JavaScript. O conteúdo do portfólio continua disponível. | Traffic analytics remain disabled without JavaScript. Portfolio content remains available. |

**Estados vazios:** na ausência de escolha, o texto da escolha atual continua vazio; não introduzir uma aceitação presumida. Ao concatenar a mensagem de falha de armazenamento, preservar o espaço entre as frases. `accepted`, `declined`, `page_view`, `project_view`, `contact_click`, `project_id`, `project_name` e `contact_channel` são valores técnicos e não recebem tradução neste catálogo.

## 6. Acessibilidade

Os IDs referenciados por `aria-labelledby` e `aria-describedby`, os valores de `role`, `aria-current`, `aria-expanded`, `aria-hidden`, `aria-live` e `aria-disabled` permanecem inalterados. Traduzir somente os nomes acessíveis textuais. O texto do skip link está na seção 2.1.

| Localização / uso | Português atual | English — proposta |
| --- | --- | --- |
| index.html | Victor Ciola Rinaldo — início | Victor Ciola Rinaldo — home |
| index.html | Abrir menu | Open menu |
| index.html | Navegação principal | Main navigation |
| index.html | Diagrama conceitual com dados, processos e soluções. | Conceptual diagram showing data, processes and solutions. |
| index.html | Tecnologias de Analytics | Technologies for Data Analytics & BI |
| index.html | Tecnologias de Data Preparation & ETL | Technologies for Data Preparation & ETL |
| index.html | Tecnologias de Automation & Applications | Technologies for Automation & Applications |
| index.html | Tecnologias de Gestão de Movimentações de Colaboradores | Technologies for Employee Movement Management |
| index.html | Tecnologias de Gestão de Smartworking | Technologies for Hybrid Work Management (Smartworking) |
| index.html | Tecnologias de Automação de ETL e Integração de Dados de RH | Technologies for ETL Automation and HR Data Integration |
| index.html | Tecnologias de Central de Indicadores de RH | Technologies for HR Analytics Hub |
| index.html | Tecnologias de Planejamento e Simulação de Ocupação | Technologies for Space Occupancy Planning and Simulation |
| index.html | Diagrama demonstrativo de ocupação em três zonas, com lugares ocupados e disponíveis. | Illustrative occupancy diagram with three zones showing occupied and available spaces. |
| index.html | Fechar detalhes do projeto | Close project details |
| index.html | Fechar aviso de privacidade | Close privacy notice |
| privacidade.html | Victor Ciola Rinaldo — voltar ao portfólio | Victor Ciola Rinaldo — back to portfolio |

**Nomes acessíveis gerados em JavaScript** (`app.js`):

| Português atual | English — proposta |
| --- | --- |
| Fechar menu | Close menu |
| Tecnologias do projeto | Project technologies |
| Indicadores e benefícios do projeto | Project indicators and benefits |

Os nomes acessíveis dos serviços em português ainda incluem os títulos ingleses antigos; a coluna “Português atual” preserva essa fonte e a tradução inglesa usa os títulos visíveis correspondentes. Isso não autoriza alterar o português nesta fase. As descrições do diagrama e da planta permanecem explicitamente conceituais/ilustrativas, sem afirmar que mostram um escritório real.

## 7. Metadados e texto de compartilhamento

### 7.1 Página principal

| Campo / origem | Português atual | English — proposta |
| --- | --- | --- |
| index.html — title | Victor Ciola Rinaldo \| Portfólio Profissional | Victor Ciola Rinaldo \| Professional Portfolio |
| index.html — description | Victor Ciola Rinaldo. Análise de dados, Business Intelligence, desenvolvimento de aplicações e automação de processos. | Victor Ciola Rinaldo. Data analysis, Business Intelligence, application development and process automation. |
| index.html — og:title | Victor Ciola Rinaldo \| Portfólio Profissional | Victor Ciola Rinaldo \| Professional Portfolio |
| index.html — og:description | Projetos de Victor Ciola Rinaldo em análise de dados, desenvolvimento de aplicações e automação de processos. | Projects by Victor Ciola Rinaldo in data analysis, application development and process automation. |
| index.html — og:image:alt | Victor Ciola Rinaldo — Dados, automação e desenvolvimento de soluções. | Victor Ciola Rinaldo — Data, automation and solution development. |
| index.html — twitter:title | Victor Ciola Rinaldo \| Portfólio Profissional | Victor Ciola Rinaldo \| Professional Portfolio |
| index.html — twitter:description | Análise de dados, desenvolvimento de aplicações e automação de processos. Projetos de Victor Ciola Rinaldo. | Data analysis, application development and process automation. Projects by Victor Ciola Rinaldo. |
| index.html — twitter:image:alt | Victor Ciola Rinaldo — Dados, automação e desenvolvimento de soluções. | Victor Ciola Rinaldo — Data, automation and solution development. |

### 7.2 Página de privacidade

| Campo / origem | Português atual | English — proposta |
| --- | --- | --- |
| privacidade.html — title | Política de Privacidade \| Victor Ciola Rinaldo | Privacy Policy \| Victor Ciola Rinaldo |
| privacidade.html — description | Como o portfólio de Victor Ciola Rinaldo utiliza análise de tráfego opcional e como gerenciar seu consentimento. | How Victor Ciola Rinaldo's portfolio uses optional traffic analytics and how to manage your consent. |

### 7.3 Imagem social — texto de referência para fase posterior

A imagem `assets/images/social-card.png` contém o nome e a frase em português; não é um dos cinco previews HTML. Nenhuma imagem foi gerada ou alterada nesta fase.

| Português atual | English — proposta |
| --- | --- |
| Victor Ciola Rinaldo — Dados, automação e desenvolvimento de soluções. | Victor Ciola Rinaldo — Data, automation and solution development. |

Na imagem, manter “Victor Ciola Rinaldo” e traduzir somente a frase para **“Data, automation and solution development.”**. Este catálogo apenas registra o conteúdo para revisão; uma versão inglesa da imagem requer aprovação posterior.

**Metadados técnicos:** canonical, URLs de imagens, `og:url`, `og:type=website`, `twitter:card=summary_large_image`, dimensões `1200 × 630`, formatos, viewport e cores permanecem intactos neste documento. `pt-BR` e `pt_BR` são códigos de idioma/locale, não textos para tradução literal; a futura implementação definirá o código inglês aprovado, sem substituir códigos técnicos em português nesta fase. Nenhum endereço novo, canonical ou anotação de idioma foi criado.

## 8. Página de privacidade — tradução integral

Fonte: `privacidade.html:18–34`. Traduzir a política existente, sem acrescentar bases legais, prazos de retenção ou garantias que não constam do original. Os textos abaixo não substituem revisão humana da equivalência da política.

### 8.1 Cabeçalho, títulos, navegação e controles

| Português atual | English — proposta |
| --- | --- |
| Privacidade | Privacy |
| Política de Privacidade | Privacy Policy |
| Voltar ao portfólio | Back to portfolio |
| Finalidade e ferramenta | Purpose and tool |
| Dados de navegação | Browsing data |
| Aceitar, recusar e revogar | Accepting, declining and withdrawing consent |
| Revisar preferências de privacidade | Review privacy preferences |
| Serviços de terceiros | Third-party services |
| Contato | Contact |
| Preferências de privacidade | Privacy preferences |

### 8.2 Introdução

**Português atual**

Este portfólio profissional oferece análise de tráfego opcional. Você pode navegar e consultar os projetos sem aceitar essa coleta.

**English — proposta**

This professional portfolio offers optional traffic analytics. You can browse and view projects without accepting this data collection.

### 8.3 Finalidade e ferramenta

**Português atual**

Com seu consentimento, o Google Analytics 4 é utilizado para compreender visitas, visualizações dos projetos e interesse nos canais de contato, ajudando a avaliar o uso do portfólio. Não são ativados Google Signals ou recursos de personalização publicitária pela integração do site.

**English — proposta**

With your consent, Google Analytics 4 is used to understand visits, project views and interest in contact channels, helping assess how the portfolio is used. The site's integration does not enable Google Signals or advertising personalization features.

### 8.4 Dados de navegação — informações técnicas

**Português atual**

A medição pode envolver páginas acessadas, horários e interações, informações técnicas sobre navegador, dispositivo e tela, origem do acesso e localização aproximada derivada da conexão. O Google processa dados técnicos da conexão, como o endereço IP, de acordo com suas próprias políticas. A coleta não deve ser considerada totalmente anônima.

**English — proposta**

Measurement may involve pages visited, times and interactions, technical information about the browser, device and screen, traffic sources and approximate location derived from the connection. Google processes technical connection data, such as the IP address, in accordance with its own policies. Data collection should not be considered entirely anonymous.

### 8.5 Dados de navegação — cookies, eventos e URLs

**Português atual**

Cookies próprios com prefixo “portfolio” podem identificar um navegador de forma pseudônima por até 180 dias, com renovação conforme o uso consentido. Os eventos de projetos enviam somente o identificador e o nome do projeto; os eventos de contato enviam somente o canal. O código do site não adiciona nomes de visitantes, e-mails ou outros dados pessoais aos parâmetros personalizados. As URLs enviadas pelo site excluem query strings e fragmentos.

**English — proposta**

First-party cookies with the “portfolio” prefix may identify a browser pseudonymously for up to 180 days, with renewal based on consented use. Project events send only the project identifier and name; contact events send only the channel. The site's code does not add visitor names, email addresses or other personal data to custom parameters. URLs sent by the site exclude query strings and fragments.

### 8.6 Aceitar e recusar

**Português atual**

Antes da aceitação, a tag do Google Analytics não é carregada e o site não envia eventos de análise. “Aceitar” autoriza a medição; “Recusar” mantém a navegação sem ela. Nenhuma opção é previamente selecionada.

**English — proposta**

Before acceptance, the Google Analytics tag is not loaded and the site does not send analytics events. “Accept” authorizes measurement; “Decline” allows browsing without it. Neither option is preselected.

### 8.7 Persistência e revisão da escolha

**Português atual**

A escolha é salva no armazenamento local deste navegador. Para alterá-la, utilize “Preferências de privacidade” no rodapé, em qualquer uma das páginas. Se o navegador impedir a gravação, o aviso informa essa limitação: a nova escolha vale apenas para a página atual e uma preferência anteriormente salva poderá ser aplicada ao atualizar. Se não houver uma preferência acessível, nenhuma medição é iniciada.

**English — proposta**

Your choice is saved in this browser's local storage. To change it, use “Privacy preferences” in the footer on either page. If the browser blocks saving, the notice explains this limitation: the new choice applies only to the current page, and a previously saved preference may be applied when you reload. If no preference can be accessed, measurement does not start.

### 8.8 Revogação e dados anteriores

**Português atual**

Ao recusar depois de aceitar, o site desativa a medição e remove seus cookies de análise. Quando consegue salvar a escolha, recarrega a página para retirar a tag da sessão; se a gravação estiver bloqueada, mantém a medição desativada na página atual. A revogação impede a coleta futura; não apaga automaticamente dados que já tenham sido enviados. Limpar os dados do navegador também remove a preferência salva.

**English — proposta**

When you decline after accepting, the site disables measurement and removes its analytics cookies. If it can save your choice, it reloads the page to remove the tag from the session; if saving is blocked, measurement remains disabled on the current page. Withdrawing consent prevents future collection; it does not automatically delete data that has already been sent. Clearing browser data also removes the saved preference.

### 8.9 Serviços de terceiros

**Português atual**

O processamento pelo Google está sujeito à Política de Privacidade do Google. A hospedagem no GitHub Pages pode manter registros técnicos próprios independentemente do consentimento ao Analytics; consulte a Política de Privacidade do GitHub.

**English — proposta**

Google's processing is subject to the Google Privacy Policy. GitHub Pages hosting may keep its own technical logs regardless of consent to Analytics; see the GitHub Privacy Statement.

### 8.10 Contato

**Português atual**

Para dúvidas sobre privacidade ou solicitações relacionadas aos dados, entre em contato por victorciola@gmail.com.

**English — proposta**

For privacy questions or data-related requests, please contact victorciola@gmail.com.

### 8.11 Links existentes — preservar exatamente

| Texto em português | English | URL inalterada |
| --- | --- | --- |
| Política de Privacidade do Google | Google Privacy Policy | https://policies.google.com/privacy?hl=pt-BR |
| Política de Privacidade do GitHub | GitHub Privacy Statement | https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement |
| victorciola@gmail.com | victorciola@gmail.com | mailto:victorciola@gmail.com |

Os destinos permanecem os mesmos, incluindo `hl=pt-BR` no link do Google. A localização desse destino externo seria uma decisão posterior, não uma alteração autorizada neste catálogo. Banner, mensagens dinâmicas e avisos sem JavaScript constam da seção 5; nomes acessíveis constam da seção 6.

## 9. Pontos para revisão humana antes da implementação

1. **Variante de inglês:** aprovar as convenções predominantemente americanas usadas aqui e o locale futuro, sem presumir um país de atuação ou legislação aplicável.
2. **Employee Movement Management:** confirmar se “employee movements” é suficientemente claro para recrutadores. Usar “Employee Transfer Management” ou “Internal Mobility Management” somente se o alcance real corresponder; o catálogo não presume tipos de movimentação não informados.
3. **Hybrid Work Management (Smartworking):** confirmar manutenção de Smartworking como nome. A descrição explica “hybrid work model”; nenhuma justificativa ou função removida da apresentação foi reintroduzida.
4. **HR Analytics Hub:** aprovar o título descritivo e o uso consistente de “indicators”. Não transformar indicadores genericamente em métricas com metas nem afirmar maior adoção.
5. **working-hour balances, on-call duty e working-time discrepancies:** validar equivalência contextual dos termos de jornada; não atribuir regras contratuais, remuneração ou infrações inexistentes.
6. **Second-level HR Support requests:** validar se “requests” descreve os atendimentos de segundo nível; não presumir a existência de tickets. HR Support permanece com seu nome atual.
7. **Access roles:** a tradução descreve perfis de acesso, sem afirmar a implementação de uma tecnologia específica de autorização.
8. **Spaces, occupancy e capacity planning:** confirmar o termo mais claro para os lugares do preview. Não mudar os placeholders “—” nem introduzir capacidade real ou números de cenários.
9. **Estimativas:** aprovar as formulações “Estimated monthly savings” e “Estimated reduction”. Manter `13–22 h`, `~85%`, `~7–8 h/month`, `75%–85%`, o sentido mensal e a limitação à preparação/consolidação ou ao esforço manual por atualização.
10. **Política de privacidade:** conferir equivalência de “pseudonymously”, “first-party cookies” e “withdrawing consent”; preservar 180 dias, possibilidade de falha de armazenamento e distinção entre revogação e eliminação de dados já enviados. Não acrescentar um novo prazo de retenção do GA4.
11. **Composição visual futura:** validar quebra de linha de títulos, legendas, rótulos e descrições em EN, sem alterar o texto português nem remover qualificadores para caber. Rever especialmente o cabeçalho, “Employee Movement Management” e os destaques qualitativos.
12. **Texto com elementos internos:** preservar ponto azul, setas, ícones, separadores, links e spans de destaque ao aplicar as traduções. O uso de “Let's connect?” deve manter a pontuação atual.
13. **Imagem social:** aprovar posteriormente uma versão inglesa ou neutra; o arquivo atual continua português e não foi alterado. Os previews dos projetos são HTML/CSS e usam os textos traduzidos da seção 3.
14. **Conteúdo de base:** as autorizações e a sustentação dos dados corporativos continuam as mesmas da versão portuguesa. Esta tradução não acrescenta números nem substitui essas validações.

## 10. Conferência de cobertura desta entrega

- Quatro arquivos-fonte lidos; português vigente usado como referência, sem reutilizar backups antigos.
- Cinco projetos completos, incluindo cards, modalidades de funcionamento, etapas, funcionalidades, tecnologias, resultados e todos os 20 KPIs.
- Cinco previews HTML completos, incluindo legendas, etapas, planta ilustrativa e unidades; sem imagens novas.
- Navegação, apresentação, Sobre mim, serviços, contato e rodapé.
- Cabeçalhos dos modais, nomes acessíveis e mensagens dinâmicas do menu.
- Banner de consentimento, estados de escolha, confirmações e falha de armazenamento.
- Política completa, navegação da página de privacidade e avisos sem JavaScript.
- Títulos e descrições de metadados, textos alternativos de compartilhamento e frase da imagem social.
- Catálogo integrado ao seletor PT | EN local. O português de origem, números, períodos, tecnologias e identificadores foram preservados. A imagem social não foi alterada.


## 11. Histórico de decisões editoriais aprovadas

Na implementação bilíngue foram aprovadas as seguintes substituições na proposta inglesa; o conteúdo em português permanece intacto:

| Proposta anterior | Decisão aprovada |
| --- | --- |
| Smartworking Management | Hybrid Work Management (Smartworking) |
| HR Indicators Hub | HR Analytics Hub |
| Data Analysis & BI | Data Analytics & BI |
| Monthly time savings | Estimated Monthly Time Savings |
| time banks | working-hour balances |

Mantidos Employee Movement Management, inglês americano, números e períodos e extração inicial manual do SAP. A coluna anterior é histórico, não conteúdo a utilizar no site.
