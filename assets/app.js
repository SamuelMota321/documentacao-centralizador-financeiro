const themeStorageKey = 'centralizador-docs-theme';
const root = document.documentElement;
let savedTheme = null;
try {
  savedTheme = localStorage.getItem(themeStorageKey);
} catch {}
root.dataset.theme = savedTheme === 'dark' ? 'dark' : 'light';

const topbar = document.querySelector('.topbar');
const themeActions = document.createElement('div');
themeActions.className = 'top-actions';
const themeToggle = document.createElement('button');
themeToggle.className = 'theme-toggle';
themeToggle.type = 'button';
themeToggle.innerHTML = `
  <svg class="moon-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 3a9 9 0 1 0 9 9 7 7 0 0 1-9-9Z"/></svg>
  <svg class="sun-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.93 4.93l1.42 1.42M17.66 17.66l1.41 1.41M2 12h2M20 12h2M4.93 19.07l1.42-1.42M17.66 6.34l1.41-1.41"/></svg>
  <span class="theme-text"></span>`;
themeActions.append(themeToggle);
topbar?.append(themeActions);

const setTheme = theme => {
  const dark = theme === 'dark';
  root.dataset.theme = dark ? 'dark' : 'light';
  themeToggle.setAttribute('aria-pressed', String(dark));
  themeToggle.setAttribute('aria-label', dark ? 'Alternar para tema claro' : 'Alternar para tema escuro');
  themeToggle.querySelector('.theme-text').textContent = dark ? 'Tema claro' : 'Tema escuro';
};

setTheme(root.dataset.theme);
themeToggle.addEventListener('click', () => {
  const nextTheme = root.dataset.theme === 'dark' ? 'light' : 'dark';
  setTheme(nextTheme);
  try {
    localStorage.setItem(themeStorageKey, nextTheme);
  } catch {}
});

const pages = [...document.querySelectorAll('.paper')];
let navLinks = [];
const search = document.querySelector('#doc-search');
const resultNote = document.querySelector('.result-note');

const headingPattern = /^(?:\d+(?:\.\d+)*\.?\s+|HU-\d+\s*[-–]|S1-\d{2}\s*[—-].+$|Introdução$|Finalidade$|Escopo$|Contexto de negócio$|Contexto e objetivo da Sprint$|Dependências que orientam a divisão$|Estrutura de responsabilidades dos 3 desenvolvedores$|Divisão detalhada por atividade$|Matriz consolidada de responsabilidades$|Organização prática e evidências$|Fluxo recomendado de trabalho conjunto$|Recomendação final$|Open Finance e ingestão de dados$|Investimentos e inteligência patrimonial$|Analytics e projeções financeiras$|Posicionamento$|Declaração .+$|Descrição das partes interessadas$|Visão geral do produto$|Necessidades e funcionalidades$|Requisitos não funcionais preliminares$|Premissas e restrições técnicas$|Histórico (?:de|da) Revisão$|Definições, Acrônimos e Abreviações$|Restrições e requisitos arquiteturais$|Visão .+$|Decisões arquiteturais$|Representação .+$|Lista de .+$|Riscos técnicos e mitigação$)/i;

const repeatedLine = (line, index) => {
  const value = line.replace(/\s+/g, ' ').trim();
  if (!value) return false;
  if (/^(UCB, 2026|Confidencial\s+Page|Page \d+ of \d+)/i.test(value)) return true;
  if (index < 8 && /^(Centralizador financeiro Inteligente|Grupo:|Marques e Miguel Candido$|Visão: Centralizador Financeiro Inteligente|Documento de (Requisitos|Arquitetura) de Software|Data:)/i.test(value)) return true;
  return false;
};

const addText = (element, value, query = '') => {
  if (!query) {
    element.append(document.createTextNode(value));
    return;
  }
  const escaped = query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const pieces = value.split(new RegExp(`(${escaped})`, 'gi'));
  for (const piece of pieces) {
    if (piece.toLocaleLowerCase('pt-BR') === query.toLocaleLowerCase('pt-BR')) {
      const mark = document.createElement('mark');
      mark.textContent = piece;
      element.append(mark);
    } else {
      element.append(document.createTextNode(piece));
    }
  }
};

const appendHeading = (fragment, text, level, query) => {
  const heading = document.createElement(level);
  heading.className = 'doc-heading';
  addText(heading, text, query);
  fragment.append(heading);
};

const appendParagraph = (fragment, lines, query) => {
  const groups = [];
  let current = [];
  for (const line of lines.filter(line => line.trim())) {
    const startsIndented = /^\s{4,}\S/.test(line);
    const previousEndsSentence = current.length && /[.!?]$/.test(current[current.length - 1].trim());
    const currentLength = current.join(' ').length;
    if (current.length && currentLength > 180 && (startsIndented || previousEndsSentence)) {
      groups.push(current);
      current = [];
    }
    current.push(line.trim());
  }
  if (current.length) groups.push(current);
  for (const group of groups) {
    const text = group.join(' ').replace(/\s+/g, ' ');
    if (!text) continue;
    const paragraph = document.createElement('p');
    paragraph.className = 'doc-paragraph';
    addText(paragraph, text, query);
    fragment.append(paragraph);
  }
};

const isDataBlock = lines => {
  const meaningful = lines.filter(line => line.trim());
  if (meaningful.length < 2) return false;
  const separators = meaningful
    .map(line => line.search(/\s{3,}/))
    .filter(index => index > 0);
  const aligned = separators.length >= 2 && Math.max(...separators) - Math.min(...separators) <= 8;
  const identifiers = meaningful.filter(line => /^(?:HU-|RNF|RN-|ID\b|Data\b|Nome\b|Necessidade\b|Atributo\b|Item arquitetural\b|Entidade conceitual\b|Risco\b)/i.test(line.trim())).length;
  const header = /^(?:ID|Data|Nome|Necessidade|Atributo|Item arquitetural|Entidade conceitual|Risco|Requisito|Termo)\b/i.test(meaningful[0].trim());
  return header || identifiers >= 2 || (aligned && separators.length >= Math.ceil(meaningful.length * .6));
};

const appendDataBlock = (fragment, lines, query) => {
  const wrapper = document.createElement('div');
  wrapper.className = 'doc-data-block';
  const label = document.createElement('div');
  label.className = 'doc-data-label';
  label.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M3 3h18v18H3z"/><path d="M3 9h18M9 21V9"/></svg><span>Dados estruturados</span>';
  const sourceLines = lines.filter(line => line.trim());
  const cleanLines = sourceLines.map(line => line.trim());
  const headerPattern = /^(?:ID|Data|Nome|Necessidade|Atributo|Item arquitetural|Entidade conceitual|Risco|Requisito|Termo)\b/i;
  const hasHeader = headerPattern.test(cleanLines[0] || '');
  const splitAll = line => line.split(/\s{2,}/).map(cell => cell.replace(/\s+/g, ' ').trim()).filter(Boolean);
  const baseIndent = hasHeader ? Math.min(...sourceLines.map(line => line.match(/^\s*/)[0].length)) : 0;
  const normalizedLines = sourceLines.map(line => line.slice(Math.min(baseIndent, line.length)));
  const headerLine = normalizedLines[0] || '';
  const headerMatches = hasHeader ? [...headerLine.matchAll(/\S(?:.*?\S)?(?=\s{2,}|$)/g)] : [];
  const columnStarts = headerMatches.map(match => match.index);
  const headerCells = hasHeader ? headerMatches.map(match => match[0].replace(/\s+/g, ' ').trim()) : [];
  const columnCount = hasHeader ? Math.max(2, headerCells.length) : 2;
  const rows = [];

  for (const [lineIndex, cleanLine] of cleanLines.slice(hasHeader ? 1 : 0).entries()) {
    let cells;
    if (hasHeader && columnStarts.length >= 2) {
      const rawLine = normalizedLines[lineIndex + 1];
      cells = columnStarts.map((start, index) => rawLine
        .slice(start, columnStarts[index + 1])
        .replace(/\s+/g, ' ')
        .trim());
    } else if (hasHeader) {
      cells = splitAll(cleanLine);
      if (cells.length > columnCount) cells = [...cells.slice(0, columnCount - 1), cells.slice(columnCount - 1).join(' ')];
    } else {
      const match = cleanLine.match(/^(.*?)\s{2,}(.*)$/);
      cells = match ? [match[1].trim(), match[2].replace(/\s+/g, ' ').trim()] : [cleanLine.replace(/\s+/g, ' ').trim()];
    }
    const continuation = rows.length && (!cells[0] || /^[a-zà-ÿ(]/.test(cells[0]));
    if ((cells.length === 1 || continuation) && rows.length) {
      const lastRow = rows[rows.length - 1];
      if (cells.length === 1) {
        lastRow[lastRow.length - 1] = `${lastRow[lastRow.length - 1]} ${cells[0]}`;
      } else {
        cells.forEach((cell, index) => {
          if (cell) lastRow[Math.min(index, lastRow.length - 1)] = `${lastRow[Math.min(index, lastRow.length - 1)]} ${cell}`.trim();
        });
      }
    } else {
      while (cells.length < columnCount) cells.push('');
      rows.push(cells);
    }
  }

  const tableViewport = document.createElement('div');
  tableViewport.className = 'doc-table-viewport';
  const table = document.createElement('table');
  table.className = 'doc-table';
  if (hasHeader) {
    const thead = document.createElement('thead');
    const row = document.createElement('tr');
    for (const value of headerCells) {
      const cell = document.createElement('th');
      cell.scope = 'col';
      addText(cell, value, query);
      row.append(cell);
    }
    thead.append(row);
    table.append(thead);
  }
  const tbody = document.createElement('tbody');
  for (const values of rows) {
    const row = document.createElement('tr');
    values.forEach((value, index) => {
      const cell = document.createElement(index === 0 ? 'th' : 'td');
      if (index === 0) cell.scope = 'row';
      addText(cell, value, query);
      row.append(cell);
    });
    tbody.append(row);
  }
  table.append(tbody);
  tableViewport.append(table);
  wrapper.append(label, tableViewport);
  fragment.append(wrapper);
};

const appendList = (fragment, lines, query) => {
  const ordered = lines.every(line => /^\s*\d+[.)]\s+/.test(line) || !line.trim());
  const list = document.createElement(ordered ? 'ol' : 'ul');
  list.className = 'doc-list';
  for (const line of lines.filter(line => line.trim())) {
    const item = document.createElement('li');
    addText(item, line.trim().replace(/^(?:[●•-]|\d+[.)])\s*/, ''), query);
    list.append(item);
  }
  fragment.append(list);
};

const formatSource = (source, query = '', firstPage = false) => {
  const fragment = document.createDocumentFragment();
  let lines = source.replace(/\u00a0/g, ' ').split(/\r?\n/).filter((line, index) => !repeatedLine(line, index));
  if (firstPage) {
    const contentStart = lines.findIndex(line => /^(?:Histórico (?:de|da) Revisão|1\.\s*Introdução)/i.test(line.trim()));
    if (contentStart >= 0) lines = lines.slice(contentStart);
  }
  const blocks = [];
  let current = [];
  for (const line of lines) {
    if (!line.trim()) {
      if (current.length) blocks.push(current);
      current = [];
    } else {
      current.push(line.replace(/\s+$/, ''));
    }
  }
  if (current.length) blocks.push(current);

  for (const block of blocks) {
    const compact = block.map(line => line.replace(/\s+/g, ' ').trim()).filter(Boolean);
    if (!compact.length) continue;
    const first = compact[0];
    const listLike = block.filter(line => /^\s*(?:[●•-]|\d+[.)])\s+/.test(line)).length;

    if (headingPattern.test(first) && first.length < 110) {
      const numbered = /^\d+(?:\.\d+)*/.test(first);
      appendHeading(fragment, first, numbered ? 'h2' : 'h3', query);
      if (block.length > 1) {
        const remainder = block.slice(1);
        if (isDataBlock(remainder)) appendDataBlock(fragment, remainder, query);
        else appendParagraph(fragment, remainder, query);
      }
    } else if (listLike >= Math.max(2, Math.ceil(block.length * .5))) {
      appendList(fragment, block, query);
    } else if (isDataBlock(block)) {
      appendDataBlock(fragment, block, query);
    } else {
      appendParagraph(fragment, block, query);
    }
  }
  return fragment;
};

const renderPage = (page, query = '') => {
  const sourceNode = page.querySelector('.page-text, .document-content');
  const source = sourceNode?.dataset.source || '';
  const content = document.createElement('div');
  content.className = 'document-content';
  content.dataset.source = source;
  content.append(formatSource(source, query, page.dataset.page === '1'));
  sourceNode?.replaceWith(content);
};

pages.forEach(page => renderPage(page));

const slugify = value => value
  .normalize('NFD')
  .replace(/[\u0300-\u036f]/g, '')
  .toLocaleLowerCase('pt-BR')
  .replace(/[^a-z0-9]+/g, '-')
  .replace(/^-|-$/g, '');

const buildToc = () => {
  const nav = document.querySelector('.page-nav');
  if (!nav) return;
  const primaryHeadings = [...document.querySelectorAll('h2.doc-heading')];
  const headings = primaryHeadings.length >= 3 ? primaryHeadings : [...document.querySelectorAll('.doc-heading')];
  const usedIds = new Map();
  nav.className = 'toc';
  nav.replaceChildren();
  headings.forEach((heading, index) => {
    const base = slugify(heading.textContent) || `secao-${index + 1}`;
    const occurrence = (usedIds.get(base) || 0) + 1;
    usedIds.set(base, occurrence);
    heading.id = occurrence === 1 ? base : `${base}-${occurrence}`;
    const link = document.createElement('a');
    link.href = `#${heading.id}`;
    const number = document.createElement('span');
    number.textContent = String(index + 1).padStart(2, '0');
    link.append(number, document.createTextNode(heading.textContent.replace(/^\d+(?:\.\d+)*\.?\s*/, '')));
    nav.append(link);
  });
  navLinks = [...nav.querySelectorAll('a')];
  nav.setAttribute('aria-label', 'Seções do documento');
  if (resultNote) resultNote.textContent = `${navLinks.length} seções`;
};

buildToc();

document.querySelector('.sidebar')?.setAttribute('aria-label', 'Navegação e busca no documento');

const firstKicker = pages[0]?.querySelector('.page-kicker');
if (firstKicker?.lastElementChild) {
  firstKicker.lastElementChild.textContent = `Documento integral · ${pages.length} página${pages.length === 1 ? '' : 's'}`;
}

const observedHeadings = navLinks.map(link => document.querySelector(link.hash)).filter(Boolean);
if (observedHeadings.length && 'IntersectionObserver' in window) {
  const observer = new IntersectionObserver(entries => {
    const visible = entries.filter(entry => entry.isIntersecting).sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
    if (!visible) return;
    navLinks.forEach(link => {
      const active = link.hash === '#' + visible.target.id;
      link.classList.toggle('active', active);
      if (active) link.setAttribute('aria-current', 'location');
      else link.removeAttribute('aria-current');
    });
  }, { rootMargin: '-18% 0px -68% 0px', threshold: [0, .1, .35] });
  observedHeadings.forEach(heading => observer.observe(heading));
}

search?.addEventListener('input', event => {
  const query = event.target.value.trim();
  let count = 0;
  pages.forEach(page => {
    const content = page.querySelector('.document-content');
    const source = content.dataset.source;
    const matched = !query || source.toLocaleLowerCase('pt-BR').includes(query.toLocaleLowerCase('pt-BR'));
    page.hidden = !matched;
    if (matched) count += 1;
    content.replaceChildren(formatSource(source, query, page.dataset.page === '1'));
  });
  resultNote.textContent = query ? `${count} página${count === 1 ? '' : 's'} encontrada${count === 1 ? '' : 's'}` : `${navLinks.length} seções`;
});
