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
    "context": "O processo de movimentações de colaboradores dependia de trocas de e-mails e controles descentralizados em planilhas, dificultando o acompanhamento das solicitações e das aprovações.",
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
    "result": "A aplicação está em produção. Centraliza as solicitações, organiza as aprovações e permite acompanhar o histórico das movimentações.",
    "preview": ".movement-preview"
  },
  "smartworking": {
    "title": "Gestão de Smartworking",
    "summary": "Solução digital para gestão do modelo de trabalho híbrido, integrando acompanhamento de presença, justificativas, aprovações e indicadores gerenciais.",
    "context": "O acompanhamento do modelo de trabalho híbrido era realizado por meio de planilhas distribuídas manualmente entre gestores e profissionais de RH.",
    "solution": "Desenvolvi uma aplicação com Power Apps, SharePoint e Power Automate, integrada a dashboards no Power BI.",
    "operation": "Os gestores consultam as informações de suas equipes. As justificativas registradas são avaliadas pelos profissionais de RH responsáveis, com aprovação ou reprovação, respeitando o perfil de acesso.",
    "stages": [
      "Consulta das equipes",
      "Justificativas",
      "Avaliação pelo RH",
      "Indicadores"
    ],
    "features": [
      "Consulta das informações das equipes pelos respectivos gestores",
      "Registro de justificativas",
      "Avaliação e aprovação ou reprovação de justificativas pelos profissionais de RH responsáveis",
      "Controle de acesso conforme o perfil",
      "Notificações automatizadas",
      "Indicadores de presença, cumprimento, ocorrências e tendências"
    ],
    "technologies": [
      "Power Apps",
      "SharePoint",
      "Power Automate",
      "Power BI"
    ],
    "result": "Organiza a gestão do modelo híbrido, reúne justificativas e avaliações e disponibiliza indicadores para apoiar o acompanhamento gerencial.",
    "preview": ".smartworking-preview"
  },
  "etl": {
    "title": "Automação de ETL e Integração de Dados de RH",
    "summary": "Automação de processos de extração, transformação e consolidação de dados de Recursos Humanos, utilizando Dataflows e Power Query para alimentar relatórios e indicadores.",
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
    "result": "Padroniza a preparação e a consolidação dos dados e permite reutilizar regras de transformação em relatórios e indicadores de RH. A extração inicial do SAP permanece manual.",
    "preview": ".etl-preview"
  },
  "indicadores": {
    "title": "Central de Indicadores de RH",
    "summary": "Desenvolvimento de uma solução integrada de Business Intelligence, reunindo dashboards e indicadores de diferentes processos de Recursos Humanos em um aplicativo centralizado no Power BI Service.",
    "context": "Diferentes processos de RH demandavam análises operacionais e gerenciais organizadas em um ambiente único.",
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
    "result": "Centraliza indicadores, padroniza as análises e organiza a navegação por temas. Oferece maior autonomia na consulta de informações e apoio ao acompanhamento de resultados, com acesso restrito ao RH.",
    "preview": ".indicators-preview"
  },
  "espaco": {
    "title": "Planejamento e Simulação de Ocupação",
    "summary": "Ferramenta web interativa para dimensionamento de capacidade, distribuição de equipes e análise comparativa de cenários, com geração automática de indicadores e relatórios executivos.",
    "context": "O planejamento da ocupação de espaços corporativos exige considerar capacidade disponível, quantidade de colaboradores, características das equipes e critérios de proximidade operacional.",
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
    "result": "A ferramenta está em uso real. Atualmente, realizo as simulações, analiso as projeções e disponibilizo os relatórios às áreas envolvidas.",
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
    toggle.setAttribute('aria-label', 'Abrir menu');
    nav.classList.remove('is-open');
  };
  toggle.addEventListener('click', () => {
    const opening = toggle.getAttribute('aria-expanded') !== 'true';
    toggle.setAttribute('aria-expanded', String(opening));
    toggle.setAttribute('aria-label', opening ? 'Fechar menu' : 'Abrir menu');
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
      history.replaceState(null, '', link.getAttribute('href'));
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
    button.closest('.project').querySelectorAll('.tags li').forEach(tag => tags.append(tag.cloneNode(true)));
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
    appendSection('Resultado e benefícios', project.result);
    const visual = appendSection('Screenshots / Preview conceitual', 'Preview conceitual, sem dados corporativos. Screenshots definitivos ainda não foram incluídos.');
    visual.classList.add('case-visual');
    visual.append(document.querySelector(project.preview).cloneNode(true));
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
