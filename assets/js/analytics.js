'use strict';

// Consentimento básico: a tag oficial só é solicitada depois da aceitação.
(() => {
  const MEASUREMENT_ID = 'G-TPV93SY9ZY';
  const STORAGE_KEY = 'portfolio.analytics-consent.v1';
  const disableKey = `ga-disable-${MEASUREMENT_ID}`;
  const ownScript = document.currentScript;
  const cookiePath = new URL('../../', ownScript.src).pathname;
  const panel = document.querySelector('#analytics-consent');
  const current = document.querySelector('[data-consent-current]');
  const feedback = document.querySelector('[data-consent-feedback]');
  let choice = readChoice();
  let initialized = false;
  let returnFocus = null;

  function readChoice() {
    try {
      const value = localStorage.getItem(STORAGE_KEY);
      return value === 'accepted' || value === 'declined' ? value : null;
    } catch { return null; }
  }

  function remember(value) {
    try { localStorage.setItem(STORAGE_KEY, value); return true; }
    catch { return false; }
  }

  // Não inclui query string ou fragmentos que possam conter dados pessoais.
  function cleanURL(value) {
    try { const url = new URL(value); return /^https?:$/.test(url.protocol) ? url.origin + url.pathname : ''; }
    catch { return ''; }
  }

  function track(name, parameters = {}) {
    if (choice !== 'accepted' || !initialized || window[disableKey]) return;
    window.gtag('event', name, {
      ...parameters,
      send_to: MEASUREMENT_ID,
      page_location: cleanURL(location.href),
      page_referrer: cleanURL(document.referrer)
    });
  }

  function startAnalytics() {
    if (choice !== 'accepted' || initialized || !/^https?:$/.test(location.protocol)) return;
    initialized = true;
    window[disableKey] = false;
    window.dataLayer = window.dataLayer || [];
    window.gtag = function () { window.dataLayer.push(arguments); };
    window.gtag('consent', 'default', {
      analytics_storage: 'denied',
      ad_storage: 'denied',
      ad_user_data: 'denied',
      ad_personalization: 'denied'
    });
    window.gtag('consent', 'update', { analytics_storage: 'granted' });
    window.gtag('js', new Date());
    window.gtag('config', MEASUREMENT_ID, {
      send_page_view: false,
      allow_google_signals: false,
      allow_ad_personalization_signals: false,
      cookie_domain: 'none',
      cookie_prefix: 'portfolio',
      cookie_path: cookiePath,
      cookie_expires: 180 * 24 * 60 * 60,
      page_location: cleanURL(location.href),
      page_referrer: cleanURL(document.referrer)
    });
    // Uma visualização por documento; as âncoras não geram page_view manual.
    track('page_view', { page_title: document.title });
    const script = document.createElement('script');
    script.id = 'ga4-tag';
    script.async = true;
    script.src = `https://www.googletagmanager.com/gtag/js?id=${MEASUREMENT_ID}`;
    document.head.append(script);
  }

  function clearAnalyticsCookies() {
    // Prefixo e caminho exclusivos evitam apagar cookies de outros sites de projeto.
    document.cookie.split(';').forEach(part => {
      const name = part.split('=')[0].trim();
      if (!/^portfolio_ga(?:_|$)/.test(name)) return;
      document.cookie = `${name}=; Max-Age=0; path=${cookiePath}; SameSite=Lax`;
    });
  }

  function showPanel(moveFocus = false) {
    current.textContent = choice === 'accepted' ? 'Sua escolha atual: análise de tráfego aceita.' :
      choice === 'declined' ? 'Sua escolha atual: análise de tráfego recusada.' : '';
    panel.hidden = false;
    if (moveFocus) {
      returnFocus = document.activeElement;
      panel.focus({ preventScroll: true });
    }
  }

  function hidePanel() {
    panel.hidden = true;
    returnFocus?.focus({ preventScroll: true });
    returnFocus = null;
  }

  function applyChoice(value, persist = true) {
    choice = value;
    // Desativar primeiro: uma tag já carregada não deve medir a revogação.
    window[disableKey] = value !== 'accepted';
    const saved = !persist || remember(value);
    feedback.textContent = value === 'accepted' ? 'Análise de tráfego aceita.' : 'Análise de tráfego recusada.';
    if (value === 'accepted') startAnalytics();
    else {
      clearAnalyticsCookies();
      if (initialized && saved) {
        // Remove também comandos ainda aguardando o carregamento da tag.
        window.dataLayer.length = 0;
        document.querySelector('#ga4-tag')?.remove();
        // Sem atualização "denied" na tag carregada: evita pings sem cookies.
        location.reload();
        return;
      }
    }
    if (saved) hidePanel();
    else {
      showPanel();
      current.textContent += ' O navegador não permitiu salvar a preferência. Ela vale apenas nesta página; ao atualizar, uma escolha anteriormente salva poderá ser aplicada.';
    }
  }

  window[disableKey] = choice !== 'accepted';
  document.querySelectorAll('[data-consent-review]').forEach(button => {
    button.addEventListener('click', () => showPanel(true));
  });
  document.querySelectorAll('[data-consent-choice]').forEach(button => {
    button.addEventListener('click', () => applyChoice(button.dataset.consentChoice));
  });
  document.querySelector('[data-consent-close]').addEventListener('click', hidePanel);
  panel.addEventListener('keydown', event => {
    if (event.key === 'Escape') { event.stopPropagation(); hidePanel(); }
  });
  window.addEventListener('storage', event => {
    if (event.key !== STORAGE_KEY && event.key !== null) return;
    const value = readChoice();
    if (value === 'accepted') applyChoice(value, false);
    else if (initialized) applyChoice('declined', false);
    else {
      choice = value;
      window[disableKey] = true;
      clearAnalyticsCookies();
      if (choice) hidePanel(); else showPanel();
    }
  });
  document.addEventListener('portfolio:project-view', event => {
    const { project_id, project_name } = event.detail;
    track('project_view', { project_id, project_name });
  });
  document.querySelectorAll('a[data-contact][href]').forEach(link => {
    link.addEventListener('click', () => {
      // Não envia href, endereço de e-mail ou nome de visitante.
      track('contact_click', { contact_channel: link.dataset.contact });
    });
  });
  if (choice === 'accepted') startAnalytics();
  else {
    clearAnalyticsCookies();
    if (!choice) showPanel();
  }
})();
