'use strict';

// O HTML e PROJECTS continuam sendo a fonte portuguesa; só os textos são localizados.
(() => {
  const STORAGE_KEY = 'portfolio.language.v1';
  const valid = value => value === 'pt' || value === 'en';
  const catalog = Object.assign({}, ...Object.values(window.PORTFOLIO_EN || {}));
  const originals = new WeakMap();
  const attributes = new WeakMap();
  const nodes = new Set();
  const elements = new Set();
  const pageLinks = new Map();
  const currentURL = new URL(location.href);
  let saved = null;
  try { saved = localStorage.getItem(STORAGE_KEY); } catch {}
  const explicit = currentURL.searchParams.get('lang');
  let language = valid(explicit) ? explicit : valid(saved) ? saved : 'pt';
  const t = value => language === 'en' ? (catalog[value] || value) : value;
  const render = value => Array.isArray(value) ? value.map(t).join('') : t(value);
  const skipped = node => node.parentElement?.closest('script,style,noscript,svg');

  function capture(root) {
    const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT);
    let node;
    while ((node = walker.nextNode())) {
      if (skipped(node) || !node.nodeValue.trim() || originals.has(node)) continue;
      originals.set(node, node.nodeValue);
      nodes.add(node);
    }
    const list = root.nodeType === Node.ELEMENT_NODE ? [root, ...root.querySelectorAll('*')] : [...root.querySelectorAll('*')];
    list.forEach(element => {
      if (element.closest('script,style,svg') || attributes.has(element)) return;
      const values = {};
      ['aria-label', 'title', 'alt'].forEach(name => {
        if (element.hasAttribute(name)) values[name] = element.getAttribute(name);
      });
      if (element.tagName === 'META' && /^(description|og:title|og:description|og:image:alt|twitter:title|twitter:description|twitter:image:alt)$/.test(element.getAttribute('name') || element.getAttribute('property') || '')) values.content = element.content;
      attributes.set(element, values);
      elements.add(element);
    });
  }

  function update(root = document) {
    capture(root);
    nodes.forEach(node => {
      if (!node.isConnected) { nodes.delete(node); return; }
      const original = originals.get(node);
      if (Array.isArray(original)) node.nodeValue = render(original);
      else {
        const trimmed = original.trim();
        node.nodeValue = original.replace(trimmed, t(trimmed));
      }
    });
    elements.forEach(element => {
      if (!element.isConnected) { elements.delete(element); return; }
      Object.entries(attributes.get(element)).forEach(([name, value]) => element.setAttribute(name, t(value)));
    });
    document.documentElement.lang = language === 'en' ? 'en' : 'pt-BR';
    const locale = document.querySelector('meta[property="og:locale"]');
    if (locale) locale.content = language === 'en' ? 'en_US' : 'pt_BR';
    document.querySelectorAll('[data-language]').forEach(button => button.setAttribute('aria-pressed', String(button.dataset.language === language)));
    const menu = document.querySelector('.menu-toggle');
    if (menu) menu.setAttribute('aria-label', t(menu.getAttribute('aria-expanded') === 'true' ? 'Fechar menu' : 'Abrir menu'));
    pageLinks.forEach((href, link) => {
      const url = new URL(location.protocol === 'file:' && href === './' ? 'index.html' : href, location.href);
      if (language === 'en' || new URL(location.href).searchParams.has('lang')) url.searchParams.set('lang', language);
      else url.searchParams.delete('lang');
      link.setAttribute('href', url.pathname + url.search + url.hash);
      if (location.protocol === 'file:') link.setAttribute('href', url.href);
    });
  }

  function text(element, value) {
    element.replaceChildren(document.createTextNode(render(value)));
    const node = element.firstChild;
    originals.set(node, value);
    nodes.add(node);
  }

  // Clones recuperam a fonte PT, mesmo quando o preview de origem está em EN.
  function clone(element) {
    const copy = element.cloneNode(true);
    function restore(source, target) {
      if (source.nodeType === Node.TEXT_NODE && originals.has(source)) {
        const original = originals.get(source);
        target.nodeValue = Array.isArray(original) ? original.join('') : original;
      }
      if (source.nodeType === Node.ELEMENT_NODE && attributes.has(source)) {
        Object.entries(attributes.get(source)).forEach(([name, value]) => target.setAttribute(name, value));
      }
      [...source.childNodes].forEach((child, index) => restore(child, target.childNodes[index]));
    }
    restore(element, copy);
    return copy;
  }

  function setLanguage(value, persist = true) {
    if (!valid(value)) return;
    language = value;
    if (persist) { try { localStorage.setItem(STORAGE_KEY, value); } catch {} }
    const url = new URL(location.href);
    url.searchParams.set('lang', value);
    history.replaceState(history.state, '', url);
    update();
    document.dispatchEvent(new CustomEvent('portfolio:language-change', { detail: { language } }));
  }

  document.querySelectorAll('a[href]').forEach(link => {
    const href = link.getAttribute('href');
    if (href === 'privacidade.html' || href === './') pageLinks.set(link, href);
  });
  document.querySelectorAll('[data-language]').forEach(button => button.addEventListener('click', () => setLanguage(button.dataset.language)));
  window.addEventListener('popstate', () => {
    const value = new URL(location.href).searchParams.get('lang');
    if (valid(value)) { language = value; update(); }
  });
  window.PortfolioI18n = { t, text, clone, update, setLanguage, get language() { return language; } };
  if (valid(explicit)) { try { localStorage.setItem(STORAGE_KEY, language); } catch {} }
  update();
})();
