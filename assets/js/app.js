'use strict';

// Endereços profissionais confirmados para os links do Hero e de Contato.
const CONTACTS = Object.freeze({
  linkedin: 'https://www.linkedin.com/in/victorciolarinaldo',
  github: null,
  email: 'victorciola@gmail.com'
});

// Para expandir: incluir um case aqui e uma linha editorial com data-project no HTML.
// Os seletores de preview apontam para os placeholders locais no HTML.
// Para substituir por imagens anonimizadas, mantenha a classe de cada figure.
const PROJECTS = Object.freeze({
  "movimentacoes": {
    "title": "Gestão de Movimentações de Colaboradores",
    "summary": "Aplicação desenvolvida com Power Apps para digitalizar solicitações de movimentação de colaboradores, estruturando fluxos de aprovação, controles de acesso e notificações automatizadas.",
    "context": "As solicitações eram registradas em um formulário SharePoint, enquanto as aprovações eram solicitadas por e-mail, sem um fluxo estruturado de aprovação.",
    "solution": "Desenvolvi uma aplicação utilizando Power Apps, Power Fx, SharePoint Lists e Power Automate para centralizar as solicitações e organizar o fluxo de aprovações entre as áreas responsáveis.",
    "operation": "As solicitações são cadastradas e acompanhadas na aplicação. As aprovações seguem condições e etapas, com acesso conforme perfil e responsabilidade, devoluções para ajustes e notificações automatizadas.",
    "stages": [
      "Solicitações",
      "Aprovações",
      "Histórico",
      "Indicadores"
    ],
    "features": [
      "Cadastro e acompanhamento de solicitações",
      "Aprovações condicionais por etapas",
      "Acesso conforme perfil e responsabilidade",
      "Aprovações em lote",
      "Devolução de solicitações para ajustes",
      "Notificações automáticas",
      "Histórico de status, responsáveis, datas e observações",
      "Indicadores em Power BI",
      "Extração de informações para Excel utilizando Power Query"
    ],
    "technologies": [
      "Power Apps",
      "Power Fx",
      "SharePoint",
      "Power Automate",
      "Power BI",
      "Power Query"
    ],
    "result": "A solução transformou um processo de aprovações conduzido por e-mails em um fluxo estruturado, com etapas, responsáveis e regras definidas.",
    "benefits": [
      "Com a centralização das solicitações e o registro das decisões, o processo ganhou maior padronização, visibilidade e rastreabilidade.",
      "Em operação desde abril de 2022, a aplicação passou a apoiar continuamente a gestão das movimentações de colaboradores."
    ],
    "kpis": [
      {
        "title": "Operação contínua",
        "value": "Desde 2022",
        "description": "Solução em operação desde abril de 2022.",
        "icon": "calendar"
      },
      {
        "title": "Acompanhamento",
        "value": "Status por etapa",
        "description": "Visibilidade sobre o andamento das solicitações e suas etapas de aprovação.",
        "icon": "tracking"
      },
      {
        "title": "Fluxo estruturado",
        "value": "Aprovações organizadas",
        "description": "Etapas, responsáveis e regras de aprovação definidos.",
        "icon": "workflow"
      },
      {
        "title": "Rastreabilidade",
        "value": "Histórico centralizado",
        "description": "Registro de status, responsáveis, decisões e observações.",
        "icon": "history"
      }
    ],
    "preview": ".movement-preview"
  },
  "smartworking": {
    "title": "Gestão de Smartworking",
    "summary": "Solução digital para gestão do modelo de trabalho híbrido, integrando informações, automatizando processos e disponibilizando indicadores gerenciais para apoiar a tomada de decisão.",
    "context": "O acompanhamento do modelo de trabalho híbrido era realizado por meio de planilhas distribuídas manualmente entre gestores e profissionais de RH.",
    "solution": "Desenvolvi uma aplicação com Power Apps, SharePoint e Power Automate, integrada a dashboards no Power BI.",
    "operation": "A aplicação centraliza informações do modelo híbrido para consulta pelos gestores e profissionais de RH, respeitando os perfis de acesso e disponibilizando indicadores gerenciais.",
    "stages": [
      "Consulta das informações",
      "Indicadores"
    ],
    "features": [
      "Consulta de informações do modelo híbrido pelos gestores",
      "Controle de acesso conforme o perfil",
      "Notificações automatizadas",
      "Indicadores gerenciais para acompanhamento do modelo de trabalho híbrido"
    ],
    "technologies": [
      "Power Apps",
      "SharePoint",
      "Power Automate",
      "Power BI"
    ],
    "result": "A solução substituiu a circulação de múltiplas planilhas por um ambiente centralizado de informações e acompanhamento do modelo de trabalho híbrido.",
    "benefits": [
      "A padronização das informações e a eliminação da consolidação manual dos arquivos reduziram o trabalho operacional mensal de preparação e consolidação de dados.",
      "Além da economia estimada de tempo, o aplicativo trouxe maior rastreabilidade das decisões, organização do processo e disponibilidade de indicadores para acompanhamento gerencial."
    ],
    // Estimativas retrospectivas informadas pelo responsável, sem medição formal.
    "kpis": [
      {
        "title": "Economia mensal",
        "value": "13–22 h",
        "description": "Economia mensal estimada de trabalho operacional.",
        "icon": "clock"
      },
      {
        "title": "Redução de esforço",
        "value": "~85%",
        "description": "Redução estimada do esforço de preparação e consolidação.",
        "icon": "trend-down"
      },
      {
        "title": "Centralização",
        "value": "Base centralizada",
        "description": "Eliminação da necessidade de reunir diferentes versões de planilhas.",
        "icon": "database"
      },
      {
        "title": "Rastreabilidade",
        "value": "Aprovações rastreáveis",
        "description": "Decisões registradas diretamente na aplicação.",
        "icon": "history"
      }
    ],
    "preview": ".smartworking-preview"
  },
  "etl": {
    "title": "Automação de ETL e Integração de Dados de RH",
    "summary": "Automação do tratamento, transformação, padronização, integração e consolidação de dados de Recursos Humanos com Power Query e Dataflows, para alimentar relatórios e indicadores.",
    "context": "Relatórios extraídos manualmente do SAP precisavam passar por processos de preparação e consolidação para serem utilizados em análises de RH.",
    "solution": "Desenvolvi fluxos reutilizáveis de tratamento de dados com Power BI Service Dataflows e Power Query, padronizando estruturas e consolidando informações provenientes dos relatórios disponibilizados em pastas.",
    "operation": "A extração inicial dos relatórios do SAP é manual. A partir dos arquivos disponibilizados em pastas, os fluxos tratam e consolidam os dados. Determinados fluxos têm atualização diária programada; outros são atualizados sob demanda.",
    "stages": [
      "Extração manual do SAP",
      "Arquivos em pastas",
      "Tratamento",
      "Consolidação",
      "Relatórios"
    ],
    "features": [
      "Tratamento e padronização de arquivos de origem",
      "Consolidação de diferentes conjuntos de dados",
      "Reutilização de consultas e regras de transformação",
      "Atualizações programadas diariamente em determinados fluxos",
      "Atualizações sob demanda em outros fluxos",
      "Disponibilização de dados para dashboards e relatórios destinados ao RH",
      "Tratamento de temas como horas extras, banco de horas, sobreaviso e irregularidades de jornada"
    ],
    "technologies": [
      "Power Query",
      "Power BI Dataflows",
      "Power BI Service",
      "ETL",
      "SAP (sistema de origem)"
    ],
    "resultHeading": "Impacto e benefícios",
    "result": "Fluxos reutilizáveis de transformação e integração padronizaram os dados e reduziram o esforço manual nas atualizações dos relatórios de RH.",
    "kpis": [
      {
        "title": "Economia mensal",
        "value": "~7–8 h/mês",
        "description": "Economia mensal estimada de trabalho manual.",
        "icon": "clock"
      },
      {
        "title": "Redução de esforço",
        "value": "75%–85%",
        "description": "Redução estimada do esforço manual por atualização.",
        "icon": "trend-down"
      },
      {
        "title": "Automação",
        "value": "Tratamento automatizado",
        "description": "Transformações e integrações executadas por fluxos reutilizáveis.",
        "icon": "workflow"
      },
      {
        "title": "Padronização",
        "value": "Dados padronizados",
        "description": "Regras consistentes para atualização dos relatórios de RH.",
        "icon": "database"
      }
    ],
    "preview": ".etl-preview"
  },
  "indicadores": {
    "title": "Central de Indicadores de RH",
    "summary": "Desenvolvimento de uma solução integrada de Business Intelligence, reunindo dashboards e indicadores de diferentes processos de Recursos Humanos em um aplicativo centralizado no Power BI Service.",
    "context": "Antes da solução, não havia um ambiente permanente para consultar os indicadores de RH. As informações eram organizadas em apresentações conforme surgiam necessidades específicas.",
    "solution": "Desenvolvi todos os dashboards e indicadores em Power BI, utilizando modelagem de dados, DAX, Power Query e visualizações interativas. Organizei e publiquei os conteúdos em um aplicativo no Power BI Service.",
    "operation": "O aplicativo organiza a navegação por temas e reúne análises operacionais e gerenciais. Seu acesso é restrito aos profissionais de Recursos Humanos.",
    "stages": [
      "Modelagem de dados",
      "Indicadores",
      "Visualizações",
      "Aplicativo no Power BI Service"
    ],
    "features": [
      "Dashboards de atendimentos de segundo nível do HR Support",
      "Indicadores de headcount, admissões, desligamentos, afastamentos e férias",
      "Análises de horas extras e sobreaviso",
      "Indicadores de movimentações de colaboradores",
      "Indicadores do modelo de trabalho híbrido"
    ],
    "technologies": [
      "Power BI",
      "DAX",
      "Power Query",
      "Modelagem de dados",
      "Power BI Service"
    ],
    "resultHeading": "Resultados e benefícios",
    "result": "A Central de Indicadores reúne dashboards de diferentes temas de RH em um ambiente permanente de consulta, com visualizações interativas e acesso direto pelas áreas.",
    "kpis": [
      {
        "title": "Abrangência",
        "value": "7 dashboards",
        "description": "Painéis que abrangem diferentes temas e processos de RH.",
        "icon": "dashboard"
      },
      {
        "title": "Disponibilidade",
        "value": "Consulta permanente",
        "description": "Indicadores disponíveis independentemente de apresentações pontuais.",
        "icon": "calendar"
      },
      {
        "title": "Experiência de análise",
        "value": "Exploração interativa",
        "description": "Filtros e visualizações para consultar diferentes recortes dos dados.",
        "icon": "chart"
      },
      {
        "title": "Acessibilidade",
        "value": "Acesso direto",
        "description": "Áreas de RH podem consultar os painéis sem solicitar relatórios específicos.",
        "icon": "access"
      }
    ],
    "preview": ".indicators-preview"
  },
  "espaco": {
    "title": "Planejamento e Simulação de Ocupação",
    "summary": "Ferramenta web interativa para dimensionamento de capacidade, distribuição de equipes e análise comparativa de cenários, com geração automática de indicadores e relatórios executivos.",
    "context": "Uma necessidade específica de planejamento exigia comparar propostas de distribuição das equipes, considerando a capacidade dos espaços e os critérios de proximidade operacional. A ferramenta foi desenvolvida para explorar essas alternativas de ocupação.",
    "solution": "Desenvolvi uma ferramenta web em HTML, CSS e JavaScript que permite construir cenários de ocupação, distribuir equipes entre andares e zonas, ajustar parâmetros e avaliar alternativas de alocação.",
    "operation": "Os cenários combinam capacidade, equipes e premissas de ocupação, incluindo exceções e absenteísmo. A ferramenta permite distribuir equipes de forma interativa, comparar alternativas e gerar indicadores e relatórios executivos.",
    "stages": [
      "Premissas",
      "Distribuição de equipes",
      "Simulação",
      "Comparação",
      "Relatórios executivos"
    ],
    "features": [
      "Distribuição interativa de equipes",
      "Dimensionamento de capacidade",
      "Simulação e comparação de cenários",
      "Aplicação de premissas de ocupação, exceções e absenteísmo",
      "Identificação de déficits e capacidade disponível",
      "Indicadores e relatórios automáticos",
      "Comparativos e análises executivas"
    ],
    "technologies": [
      "HTML",
      "CSS",
      "JavaScript",
      "Lógica de negócios",
      "Análise de dados",
      "Simulação de cenários"
    ],
    "resultHeading": "Resultados e benefícios",
    "result": "A ferramenta permite construir e comparar cenários de ocupação, avaliar a capacidade dos espaços e organizar os resultados para apoiar o planejamento.",
    "kpis": [
      {
        "title": "Planejamento",
        "value": "Múltiplos cenários",
        "description": "Possibilidade de testar diferentes distribuições de equipes e espaços.",
        "icon": "layers"
      },
      {
        "title": "Dimensionamento",
        "value": "Déficits e capacidade",
        "description": "Identificação de vagas disponíveis, excedentes e necessidades de alocação.",
        "icon": "building"
      },
      {
        "title": "Avaliação",
        "value": "Impacto das mudanças",
        "description": "Recálculo dos indicadores conforme as alocações são ajustadas.",
        "icon": "comparison"
      },
      {
        "title": "Comunicação",
        "value": "Visão executiva",
        "description": "Comparativos e relatórios estruturados para apresentação das propostas.",
        "icon": "presentation"
      }
    ],
    "preview": ".planner-preview"
  }
});

function configureContacts() {
  document.querySelectorAll('[data-contact]').forEach(link => {
    const key = link.dataset.contact;
    const value = CONTACTS[key];
    if (!value) {
      link.removeAttribute('href');
      link.removeAttribute('target');
      link.removeAttribute('rel');
      link.setAttribute('aria-disabled', 'true');
      return;
    }
    if (key === 'email') link.href = `mailto:${value}`;
    else {
      try { if (new URL(value).protocol !== 'https:') return; } catch { return; }
      link.href = value;
      link.target = '_blank';
      link.rel = 'noopener noreferrer';
    }
    link.removeAttribute('aria-disabled');
  });
}

function setupNavigation() {
  const toggle = document.querySelector('.menu-toggle');
  const nav = document.querySelector('.main-nav');
  const links = [...nav.querySelectorAll('a')];
  const close = () => {
    toggle.setAttribute('aria-expanded', 'false');
    toggle.setAttribute('aria-label', window.PortfolioI18n?.t('Abrir menu') || 'Abrir menu');
    nav.classList.remove('is-open');
  };
  toggle.addEventListener('click', () => {
    const opening = toggle.getAttribute('aria-expanded') !== 'true';
    toggle.setAttribute('aria-expanded', String(opening));
    toggle.setAttribute('aria-label', window.PortfolioI18n?.t(opening ? 'Fechar menu' : 'Abrir menu') || (opening ? 'Fechar menu' : 'Abrir menu'));
    nav.classList.toggle('is-open', opening);
  });
  links.forEach(link => link.addEventListener('click', close));
  document.querySelectorAll('a[href^="#"]').forEach(link => {
    link.addEventListener('click', event => {
      const target = document.querySelector(link.getAttribute('href'));
      if (!target) return;
      event.preventDefault();
      target.scrollIntoView({ behavior: matchMedia('(prefers-reduced-motion: reduce)').matches ? 'instant' : 'smooth', block: 'start' });
      target.setAttribute('tabindex', '-1');
      target.focus({ preventScroll: true });
      const url = new URL(location.href);
      url.hash = link.getAttribute('href');
      history.replaceState(null, '', url);
    });
  });
  document.addEventListener('keydown', event => {
    if (event.key === 'Escape' && toggle.getAttribute('aria-expanded') === 'true') {
      close();
      toggle.focus();
    }
  });
  document.addEventListener('click', event => {
    if (!event.target.closest('.site-header')) close();
  });
  nav.addEventListener('focusout', () => {
    setTimeout(() => {
      if (!document.querySelector('.site-header').contains(document.activeElement)) close();
    }, 0);
  });
  matchMedia('(min-width: 801px)').addEventListener('change', close);
  const sections = links.map(link => document.querySelector(link.getAttribute('href')));
  let scheduled = false;
  function updateActive() {
    const offset = document.querySelector('.site-header').offsetHeight + 100;
    let active = sections[0];
    sections.forEach(section => {
      if (section.getBoundingClientRect().top <= offset) active = section;
    });
    if (window.innerHeight + window.scrollY >= document.documentElement.scrollHeight - 4) {
      // Links próximos ao rodapé podem atingir o limite de scroll antes de alinhar ao topo.
      const focusedSection = sections.find(section => {
        const top = section.getBoundingClientRect().top;
        return section === document.activeElement && top >= 0 && top < window.innerHeight;
      });
      active = focusedSection || sections.at(-1);
    }
    links.forEach(link => {
      if (link.hash === `#${active.id}`) link.setAttribute('aria-current', 'location');
      else link.removeAttribute('aria-current');
    });
    scheduled = false;
  }
  window.addEventListener('scroll', () => {
    if (!scheduled) { scheduled = true; requestAnimationFrame(updateActive); }
  }, { passive: true });
  window.addEventListener('resize', updateActive);
  updateActive();
}

function createTextElement(tag, content, className) {
  const element = document.createElement(tag);
  element.textContent = content;
  if (className) element.className = className;
  return element;
}

function setupProjectDialog() {
  const dialog = document.querySelector('#project-dialog');
  const content = document.querySelector('#dialog-content');
  let trigger = null;
  const appendSection = (heading, text) => {
    const section = document.createElement('section');
    section.className = 'case-block';
    section.append(createTextElement('h3', heading), createTextElement('p', text));
    content.append(section);
    return section;
  };
  function openProject(button) {
    const project = PROJECTS[button.dataset.project];
    if (!project || dialog.open) return;
    trigger = button;
    content.replaceChildren();
    const title = createTextElement('h2', project.title);
    title.id = 'dialog-title';
    const summary = createTextElement('p', project.summary, 'dialog-summary');
    summary.id = 'dialog-summary';
    const tags = document.createElement('ul');
    tags.className = 'tags';
    tags.setAttribute('aria-label', 'Tecnologias do projeto');
    button.closest('.project').querySelectorAll('.tags li').forEach(tag => tags.append(window.PortfolioI18n ? window.PortfolioI18n.clone(tag) : tag.cloneNode(true)));
    content.append(title, summary, tags);
    appendSection('Contexto / Problema', project.context);
    appendSection('Solução', project.solution);
    const operation = appendSection('Como funciona', project.operation);
    const flow = document.createElement('div');
    flow.className = 'case-flow';
    project.stages.forEach(stage => flow.append(createTextElement('span', stage)));
    operation.append(flow);
    const features = document.createElement('section');
    features.className = 'case-block';
    features.append(createTextElement('h3', 'Principais funcionalidades'));
    const list = document.createElement('ul');
    project.features.forEach(feature => list.append(createTextElement('li', feature)));
    features.append(list);
    content.append(features);
    const results = appendSection(project.resultHeading || 'Resultados e benefícios', project.result);
    if (project.kpis) {
      results.classList.add('case-results');
      const icons = {
        calendar: '<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M16 3v4M8 3v4M3 11h18M8 15h2M14 15h2"/>',
        tracking: '<circle cx="5" cy="5" r="2"/><circle cx="5" cy="12" r="2"/><circle cx="5" cy="19" r="2"/><path d="M5 7v3M5 14v3M10 5h11M10 12h11M10 19h11"/>',
        database: '<ellipse cx="12" cy="5" rx="9" ry="3"/><path d="M3 5v14c0 1.7 4 3 9 3s9-1.3 9-3V5M3 12c0 1.7 4 3 9 3s9-1.3 9-3"/>',
        workflow: '<rect x="9" y="3" width="6" height="6" rx="1.5"/><rect x="3" y="15" width="6" height="6" rx="1.5"/><rect x="15" y="15" width="6" height="6" rx="1.5"/><path d="M12 9v3M6 15v-3h12v3"/>',
        history: '<path d="M3 11a9 9 0 1 1 2.6 7.4M3 4v7h7M12 7v5l3 2"/>',
        clock: '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
        'trend-down': '<path d="m3 6 6 6 4-4 8 10M15 18h6v-6"/>',
        refresh: '<path d="M20 7a9 9 0 0 0-15-2L3 7M3 3v4h4M4 17a9 9 0 0 0 15 2l2-2M21 21v-4h-4"/>',
        layers: '<path d="m12 3 10 5-10 5L2 8l10-5ZM2 12l10 5 10-5M2 16l10 5 10-5"/>',
        dashboard: '<rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/>',
        chart: '<path d="M4 3v17h17M8 16v-5M13 16V6M18 16V9"/>',
        access: '<path d="M14 4h5a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2h-5M3 12h12M10 7l5 5-5 5"/>',
        building: '<rect x="5" y="3" width="14" height="18" rx="1.5"/><path d="M9 7h1M14 7h1M9 11h1M14 11h1M10 21v-6h4v6"/>',
        controls: '<path d="M3 6h8M15 6h6M3 12h2M9 12h12M3 18h12M19 18h2"/><circle cx="13" cy="6" r="2"/><circle cx="7" cy="12" r="2"/><circle cx="17" cy="18" r="2"/>',
        comparison: '<path d="M3 7h18M17 3l4 4-4 4M21 17H3M7 13l-4 4 4 4"/>',
        presentation: '<rect x="3" y="4" width="18" height="12" rx="1.5"/><path d="M12 16v5M7 21h10M7 12V9M12 12V7M17 12v-2"/>'
      };
      const kpis = document.createElement('dl');
      kpis.className = 'case-kpis';
      kpis.setAttribute('aria-label', 'Indicadores e benefícios do projeto');
      project.kpis.filter(kpi => kpi.enabled !== false).forEach(kpi => {
        const item = document.createElement('div');
        item.className = 'case-kpi';
        const label = createTextElement('dt', kpi.title, 'case-kpi-title');
        const icon = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        icon.setAttribute('viewBox', '0 0 24 24');
        icon.setAttribute('aria-hidden', 'true');
        icon.setAttribute('focusable', 'false');
        icon.innerHTML = icons[kpi.icon]; // SVGs locais e fixos, sem conteúdo externo.
        label.prepend(icon);
        item.append(label, createTextElement('dd', kpi.value, 'case-kpi-value'), createTextElement('dd', kpi.description, 'case-kpi-description'));
        kpis.append(item);
      });
      results.append(kpis);
    }
    if (project.resultsNote) results.append(createTextElement('p', project.resultsNote, 'case-results-note'));
    project.benefits?.forEach(benefit => results.append(createTextElement('p', benefit)));
    if (['movimentacoes', 'smartworking', 'etl', 'indicadores', 'espaco'].includes(button.dataset.project)) tags.after(results);
    const visual = appendSection('Screenshots / Preview conceitual', 'Preview conceitual, sem dados corporativos. Screenshots definitivos ainda não foram incluídos.');
    visual.classList.add('case-visual');
    const preview = document.querySelector(project.preview);
    visual.append(window.PortfolioI18n ? window.PortfolioI18n.clone(preview) : preview.cloneNode(true));
    window.PortfolioI18n?.update(content);
    document.body.classList.add('modal-open');
    dialog.showModal(); // O dialog nativo torna o restante da página inerte.
    document.dispatchEvent(new CustomEvent('portfolio:project-view', { detail: { project_id: button.dataset.project, project_name: project.title } }));
    dialog.scrollTop = 0;
    dialog.querySelector('.dialog-close').focus({ preventScroll: true });
  }
  document.querySelectorAll('[data-project]').forEach(button => button.addEventListener('click', () => openProject(button)));
  dialog.querySelector('.dialog-close').addEventListener('click', () => dialog.close());
  dialog.addEventListener('keydown', event => {
    if (event.key !== 'Tab') return;
    const focusable = [...dialog.querySelectorAll('button, a[href], input, select, textarea, [tabindex="0"]')]
      .filter(element => !element.disabled && element.getClientRects().length);
    const first = focusable[0];
    const last = focusable.at(-1);
    if ((event.shiftKey && document.activeElement === first) || (!event.shiftKey && document.activeElement === last)) {
      event.preventDefault();
      (event.shiftKey ? last : first).focus();
    }
  });
  dialog.addEventListener('click', event => {
    if (event.target !== dialog) return;
    const rect = dialog.getBoundingClientRect();
    if (event.clientX < rect.left || event.clientX > rect.right || event.clientY < rect.top || event.clientY > rect.bottom) dialog.close();
  });
  dialog.addEventListener('close', () => {
    document.body.classList.remove('modal-open');
    trigger?.focus({ preventScroll: true });
  });
  // ESC e contenção de foco usam o comportamento nativo do dialog.
}

function setupPreviews() {
  // Ocupação ilustrativa; não corresponde a uma planta real ou aos indicadores do mockup.
  document.querySelectorAll('.desks').forEach((zone, index) => {
    for (let i = 0; i < 8; i++) {
      const desk = document.createElement('i');
      desk.className = `desk${(i + index) % 4 !== 0 ? ' filled' : ''}`;
      zone.append(desk);
    }
  });
}

function setupReveals() {
  const motion = matchMedia('(prefers-reduced-motion: reduce)');
  if (motion.matches || !('IntersectionObserver' in window)) return;
  const elements = document.querySelectorAll('.solution, .project');
  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (!entry.isIntersecting) return;
      entry.target.classList.add('is-visible');
      observer.unobserve(entry.target);
    });
  }, { threshold: 0.08 });
  elements.forEach(element => { element.classList.add('reveal-ready'); observer.observe(element); });
  motion.addEventListener('change', event => {
    if (event.matches) { elements.forEach(element => element.classList.add('is-visible')); observer.disconnect(); }
  });
}

configureContacts();
setupNavigation();
setupPreviews();
setupProjectDialog();
setupReveals();
