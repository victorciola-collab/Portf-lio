'use strict';

// TODO_CONTATOS: preencher somente com URLs e e-mail confirmados.
const CONTACTS = Object.freeze({ linkedin: '', github: '', email: '' });

// Para expandir: incluir um case aqui e uma linha editorial com data-project no HTML.
const PROJECTS = Object.freeze({
  movimentacoes: {
    title: 'App de Movimentações',
    summary: 'Aplicação desenvolvida em Power Apps para centralizar solicitações de movimentação de colaboradores, controlar etapas de aprovação e automatizar notificações.',
    context: 'As solicitações de movimentação passam por diferentes áreas, com regras de edição, perfis de acesso e prazos. O processo precisa de controle das aprovações e acompanhamento das etapas.',
    solution: 'Desenvolvi a aplicação em Power Apps, com integração ao SharePoint e fluxos no Power Automate para aprovações e notificações.',
    operation: 'A solicitação percorre as áreas responsáveis. Cada perfil atua conforme suas permissões, com opções de aprovação, reprovação ou devolução para ajuste e acompanhamento visual das etapas.',
    stages: ['BP', 'Remuneração', 'Organização', 'HR Support', 'Processamento'],
    features: ['Workflow de aprovação', 'Diferentes perfis de acesso', 'Aprovações individuais e em massa', 'Reprovação e devolução para ajuste', 'Regras de edição', 'Controle de prazos', 'Notificações automáticas', 'Acompanhamento visual das etapas', 'Integração com SharePoint'],
    technologies: ['Power Apps', 'Power Automate', 'SharePoint'],
    result: 'A aplicação centraliza as solicitações e permite controlar aprovações e acompanhar etapas. Não há métricas de resultado publicadas.',
    preview: '.movement-preview'
  },
  espaco: {
    title: 'Planejador de Espaço',
    summary: 'Aplicação web desenvolvida para simular cenários de ocupação, distribuir equipes entre espaços disponíveis e analisar capacidade e necessidades de alocação.',
    context: 'O planejamento de ocupação considera colaboradores, capacidade, andares, zonas e áreas, além de absenteísmo e exceções. É necessário identificar espaços disponíveis e déficits de capacidade.',
    solution: 'Desenvolvi a aplicação em HTML, CSS e JavaScript para organizar informações de ocupação e criar e comparar cenários de planejamento.',
    operation: 'Os cenários combinam informações de colaboradores e capacidade com as premissas de ocupação. A comparação permite observar a distribuição, a capacidade disponível e eventuais déficits.',
    stages: ['Informações', 'Premissas', 'Simulação', 'Comparação', 'Visão executiva'],
    features: ['Planejamento por andares e zonas', 'Quantidade de colaboradores e capacidade', 'Consideração de absenteísmo e exceções', 'Visão por áreas', 'Capacidade disponível e déficit', 'Criação e comparação de cenários', 'Indicadores e visões executivas'],
    technologies: ['HTML', 'CSS', 'JavaScript', 'Data Analytics'],
    result: 'A aplicação permite comparar cenários e identificar capacidade disponível e déficits. Os números dos previews são demonstrativos e não representam resultados reais.',
    preview: '.planner-preview'
  }
});

function configureContacts() {
  document.querySelectorAll('[data-contact]').forEach(link => {
    const key = link.dataset.contact;
    const value = CONTACTS[key];
    if (!value) return;
    if (key === 'email') link.href = `mailto:${value}`;
    else {
      try { if (new URL(value).protocol !== 'https:') return; } catch { return; }
      link.href = value;
      link.target = '_blank';
      link.rel = 'noopener noreferrer';
    }
    link.removeAttribute('aria-disabled');
  });
  if (CONTACTS.linkedin && CONTACTS.github) document.querySelector('.contact-pending').hidden = true;
  if (Object.values(CONTACTS).every(Boolean)) document.querySelector('.contact-links small').hidden = true;
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
    project.technologies.forEach(tech => tags.append(createTextElement('li', tech)));
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
