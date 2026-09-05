from __future__ import annotations

import html
import re
import unicodedata
from pathlib import Path

from pypdf import PdfReader


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT
ASSETS = OUT / "assets"

DOCUMENTS = [
    {
        "slug": "visao",
        "label": "Visão",
        "eyebrow": "Direção do produto",
        "title": "Documento de Visão",
        "subtitle": "Centralização, automação e inteligência para a gestão financeira pessoal.",
        "date": "21 abr 2026",
        "version": "1.2",
        "pdf": "Documento_Visao_Centralizador_Financeiro_Inteligente.pdf",
        "accent": "#10b981",
        "highlights": [("4", "frentes estratégicas"), ("6", "grupos de stakeholders"), ("7", "páginas")],
    },
    {
        "slug": "prd",
        "label": "PRD",
        "eyebrow": "Requisitos do produto",
        "title": "Documento de Requisitos",
        "subtitle": "Escopo, histórias de usuário, regras de negócio e critérios de qualidade.",
        "date": "19 mai 2026",
        "version": "1.3",
        "pdf": "Centralizador_Financeiro_Inteligente_PRD.pdf",
        "accent": "#10b981",
        "highlights": [("16", "histórias de usuário"), ("17", "regras de negócio"), ("16", "páginas")],
    },
    {
        "slug": "arquitetura",
        "label": "Arquitetura",
        "eyebrow": "Decisões técnicas",
        "title": "Arquitetura de Software",
        "subtitle": "Visões 4+1, módulos, tecnologias, implantação e decisões arquiteturais.",
        "date": "02 jun 2026",
        "version": "1.2",
        "pdf": "Documento de Arquitetura de Software.pdf",
        "accent": "#10b981",
        "highlights": [("4+1", "modelo de visões"), ("Serverless", "estilo arquitetural"), ("13", "páginas")],
        "illustrations": {3: "Visões 4+1 da arquitetura de software"},
    },
]


CSS = r"""
:root {
  --theme-accent-dark: #111827;
  --theme-primary: #10b981;
  --theme-primary-hover: #059669;
  --theme-background: #f3f4f6;
  --theme-foreground: #111827;
  --theme-muted: #6b7280;
  --theme-surface: #ffffff;
  --font-heading: "Alfa Slab One", Georgia, serif;
  --font-body: "Outfit", Inter, Arial, sans-serif;
  --bg: var(--theme-background);
  --panel: var(--theme-surface);
  --panel-2: var(--theme-surface);
  --text: var(--theme-foreground);
  --muted: var(--theme-muted);
  --line: rgba(107, 114, 128, .16);
  --paper: var(--theme-surface);
  --ink: var(--theme-foreground);
  --paper-muted: var(--theme-muted);
  --shadow: 0 2px 8px rgba(17, 24, 39, .06);
  --radius: 24px;
  --accent: var(--theme-primary);
  color-scheme: light;
}
* { box-sizing: border-box; }
html { scroll-behavior: smooth; }
body {
  margin: 0;
  min-width: 320px;
  background:
    radial-gradient(circle at 15% -10%, rgba(16, 185, 129, .10), transparent 34rem),
    var(--theme-background);
  color: var(--text);
  font: 16px/1.65 var(--font-body);
}
a { color: inherit; }
button, input { font: inherit; }
.skip-link { position: fixed; left: 1rem; top: -5rem; z-index: 100; padding: .7rem 1rem; background: white; color: #111827; border-radius: .6rem; }
.skip-link:focus { top: 1rem; }
.topbar {
  position: sticky; top: 0; z-index: 50;
  display: flex; align-items: center; justify-content: space-between; gap: 1.5rem;
  min-height: 72px; padding: .75rem clamp(1rem, 4vw, 4rem);
  background: rgba(17, 24, 39, .96); border-bottom: 1px solid rgba(255, 255, 255, .08); backdrop-filter: blur(18px);
}
.brand { display: flex; align-items: center; gap: .8rem; color: #fff; text-decoration: none; font-weight: 750; letter-spacing: -.02em; }
.brand-mark { display: grid; place-items: center; width: 40px; height: 40px; border-radius: 50%; background: rgba(16, 185, 129, .10); color: var(--theme-primary); }
.brand-mark svg { width: 20px; height: 20px; }
.doc-nav { display: flex; align-items: center; gap: .35rem; }
.doc-nav a { padding: .5rem .75rem; border-radius: 12px; color: rgba(255, 255, 255, .80); text-decoration: none; font-size: .88rem; font-weight: 650; }
.doc-nav a { transition: color .2s ease, background-color .2s ease; }
.doc-nav a:hover { color: #fff; background: rgba(255, 255, 255, .08); }
.doc-nav a[aria-current="page"] { color: var(--theme-accent-dark); background: var(--theme-primary); }
.top-actions { display: flex; align-items: center; gap: .5rem; }
.icon-button, .outline-button { border: 1px solid rgba(107, 114, 128, .20); color: var(--text); background: var(--theme-surface); border-radius: 999px; cursor: pointer; text-decoration: none; }
.icon-button { width: 40px; height: 40px; display: grid; place-items: center; }
.outline-button { padding: .52rem .78rem; font-weight: 650; font-size: .86rem; }
.icon-button:hover, .outline-button:hover { border-color: color-mix(in srgb, var(--accent) 60%, white 10%); background: color-mix(in srgb, var(--accent) 13%, transparent); }
.hero { max-width: 1180px; margin: 0 auto; padding: clamp(4rem, 9vw, 8rem) clamp(1.2rem, 4vw, 2rem) 3.5rem; }
.eyebrow { margin: 0 0 1rem; color: var(--accent); font-size: .76rem; font-weight: 800; letter-spacing: .18em; text-transform: uppercase; }
.hero h1 { max-width: 900px; margin: 0; font-family: var(--font-heading); font-size: clamp(3rem, 6vw, 4.5rem); font-weight: 400; line-height: 1.08; letter-spacing: -.025em; text-wrap: balance; }
.hero .lead { max-width: 720px; margin: 1.6rem 0 2.2rem; color: var(--theme-muted); font-size: clamp(1.05rem, 2vw, 1.25rem); }
.meta-row { display: flex; flex-wrap: wrap; gap: .65rem; }
.meta-chip { padding: .45rem .72rem; border: 1px solid var(--line); border-radius: 999px; color: var(--muted); background: var(--theme-surface); font-size: .82rem; }
.stats { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 1px; max-width: 820px; margin-top: 3rem; overflow: hidden; border: 1px solid var(--line); border-radius: 18px; background: var(--line); }
.stat { padding: 1.2rem 1.35rem; background: var(--theme-surface); }
.stat strong { font-family: var(--font-heading); font-weight: 400; }
.stat strong { display: block; color: var(--text); font-size: 1.5rem; letter-spacing: -.035em; }
.stat span { color: var(--muted); font-size: .78rem; }
.reader { display: grid; grid-template-columns: 230px minmax(0, 900px); gap: 2rem; justify-content: center; align-items: start; padding: 1rem clamp(1rem, 3vw, 2.5rem) 7rem; }
.sidebar { position: sticky; top: 96px; max-height: calc(100vh - 120px); overflow: auto; padding: 1rem; border: 1px solid rgba(255, 255, 255, .08); border-radius: 24px; background: var(--theme-accent-dark); color: #fff; box-shadow: var(--shadow); }
.sidebar-title { margin: 0 0 .7rem; color: rgba(255, 255, 255, .68); font-size: .72rem; font-weight: 800; letter-spacing: .13em; text-transform: uppercase; }
.search { position: relative; margin-bottom: .85rem; }
.search input { width: 100%; min-height: 44px; padding: .65rem .7rem .65rem 2.35rem; border: 1px solid rgba(255, 255, 255, .16); border-radius: 12px; outline: none; background: rgba(255, 255, 255, .08); color: #fff; font-size: .82rem; transition: border-color .2s ease, box-shadow .2s ease; }
.search input::placeholder { color: rgba(255, 255, 255, .48); }
.search input:focus { border-color: var(--accent); box-shadow: 0 0 0 3px color-mix(in srgb, var(--accent) 15%, transparent); }
.search svg { position: absolute; left: .75rem; top: .75rem; width: 18px; height: 18px; color: rgba(255, 255, 255, .64); pointer-events: none; }
.page-nav { display: grid; grid-template-columns: repeat(4, 1fr); gap: .4rem; }
.page-nav a { display: grid; place-items: center; height: 34px; border: 1px solid transparent; border-radius: 8px; color: rgba(255, 255, 255, .80); text-decoration: none; font-size: .76rem; }
.page-nav a:hover { color: #fff; background: rgba(255, 255, 255, .08); }
.page-nav a.active { color: var(--theme-accent-dark); border-color: var(--theme-primary); background: var(--theme-primary); font-weight: 700; }
.result-note { min-height: 1.5rem; margin: .65rem 0 0; color: rgba(255, 255, 255, .64); font-size: .72rem; }
.pages { display: grid; gap: 1.5rem; min-width: 0; }
.paper { position: relative; min-height: 800px; overflow: hidden; padding: clamp(1.5rem, 4vw, 3rem); border: 1px solid var(--line); border-radius: 24px; background: var(--paper); color: var(--ink); box-shadow: var(--shadow); }
.paper::before { content: ""; position: absolute; inset: 0 0 auto; height: 5px; background: linear-gradient(90deg, var(--accent), color-mix(in srgb, var(--accent) 22%, white)); }
.paper[hidden] { display: none; }
.page-kicker { display: flex; align-items: center; justify-content: space-between; gap: 1rem; margin: 0 0 1.7rem; padding-bottom: .8rem; border-bottom: 1px solid #dde4ed; color: var(--paper-muted); font: 700 .7rem/1.2 Inter, sans-serif; letter-spacing: .12em; text-transform: uppercase; }
.page-text { margin: 0; overflow-x: auto; color: var(--ink); white-space: pre; tab-size: 4; font: 11px/1.58 "IBM Plex Mono", "Cascadia Mono", Consolas, monospace; }
.source-figure { margin: 2rem auto .5rem; padding: 1rem; border: 1px solid #d9e0e9; border-radius: 12px; background: white; text-align: center; }
.source-figure img { display: block; width: min(100%, 680px); height: auto; margin: auto; }
.source-figure figcaption { margin-top: .7rem; color: var(--paper-muted); font: 600 .72rem/1.4 Inter, sans-serif; }
mark { padding: 0 .08em; border-radius: 2px; background: #fde68a; color: #111827; }
.site-footer { max-width: 1180px; margin: 0 auto; padding: 2rem; border-top: 1px solid var(--line); color: var(--muted); font-size: .8rem; }
.home-hero { padding-bottom: 5rem; }
.home-hero h1 { max-width: 940px; }
.document-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 1.2rem; max-width: 1180px; margin: 0 auto; padding: 0 2rem 8rem; }
.doc-card { position: relative; min-height: 350px; padding: 1.6rem; overflow: hidden; border: 1px solid var(--line); border-radius: 16px; background: var(--theme-surface); box-shadow: var(--shadow); text-decoration: none; cursor: pointer; transition: box-shadow .2s ease, border-color .2s ease; }
.doc-card:hover { box-shadow: 0 8px 24px rgba(17, 24, 39, .10); border-color: rgba(16, 185, 129, .30); }
.doc-number { color: var(--card-accent); font-weight: 800; font-size: .75rem; letter-spacing: .15em; }
.doc-card h2 { margin: 4.6rem 0 .8rem; font-family: var(--font-heading); font-size: 2rem; font-weight: 400; line-height: 1.12; letter-spacing: -.02em; }
.doc-card p { color: var(--muted); }
.card-arrow { position: absolute; right: 1.5rem; bottom: 1.4rem; display: grid; place-items: center; width: 44px; height: 44px; border-radius: 50%; background: rgba(16, 185, 129, .10); color: var(--theme-primary); transition: color .2s ease, background-color .2s ease; }
.doc-card:hover .card-arrow { color: var(--theme-surface); background: var(--theme-primary-hover); }
.card-arrow svg { width: 20px; height: 20px; }
.home-note { max-width: 1180px; margin: 0 auto; padding: 0 2rem 2rem; color: var(--muted); }
:where(a, button, input):focus-visible { outline: 2px solid var(--theme-primary); outline-offset: 3px; }
@media (prefers-reduced-motion: reduce) {
  html { scroll-behavior: auto; }
  *, *::before, *::after { transition-duration: .01ms !important; animation-duration: .01ms !important; animation-iteration-count: 1 !important; }
}
@media (max-width: 900px) {
  .doc-nav { display: none; }
  .reader { grid-template-columns: 1fr; }
  .sidebar { position: static; max-height: none; }
  .page-nav { grid-template-columns: repeat(8, 1fr); }
  .document-grid { grid-template-columns: 1fr; }
  .doc-card { min-height: 260px; }
  .doc-card h2 { margin-top: 3rem; }
}
@media (max-width: 560px) {
  .brand span:last-child, .outline-button { display: none; }
  .hero { padding-top: 3rem; }
  .hero h1 { font-size: 2.8rem; }
  .stats { grid-template-columns: 1fr; }
  .page-nav { grid-template-columns: repeat(6, 1fr); }
  .paper { min-height: 0; padding: 1.5rem 1.1rem; }
  .page-text { font-size: 10px; line-height: 1.5; }
}
@media print {
  .topbar, .sidebar, .site-footer { display: none !important; }
  body { background: white; }
  .hero { padding: 2rem 0; color: #111827; }
  .hero .lead, .meta-chip { color: #334155; }
  .stats { border-color: #ddd; }
  .stat { background: white; color: #111827; }
  .reader { display: block; padding: 0; }
  .paper { min-height: 0; margin: 0; break-after: page; box-shadow: none; border: 0; }
}
"""


JS = r"""
const pages = [...document.querySelectorAll('.paper')];
const navLinks = [...document.querySelectorAll('.page-nav a')];
const search = document.querySelector('#doc-search');
const resultNote = document.querySelector('.result-note');
const escapeRegExp = value => value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
const highlight = (element, source, query) => {
  element.textContent = '';
  if (!query) {
    element.textContent = source;
    return;
  }
  const parts = source.split(new RegExp(`(${escapeRegExp(query)})`, 'gi'));
  for (const part of parts) {
    if (part.toLocaleLowerCase('pt-BR') === query.toLocaleLowerCase('pt-BR')) {
      const mark = document.createElement('mark');
      mark.textContent = part;
      element.append(mark);
    } else {
      element.append(document.createTextNode(part));
    }
  }
};

if (pages.length && 'IntersectionObserver' in window) {
  const observer = new IntersectionObserver(entries => {
    const visible = entries.filter(entry => entry.isIntersecting).sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
    if (!visible) return;
    navLinks.forEach(link => link.classList.toggle('active', link.hash === '#' + visible.target.id));
  }, { rootMargin: '-20% 0px -65% 0px', threshold: [0, .1, .4] });
  pages.forEach(page => observer.observe(page));
}

search?.addEventListener('input', event => {
  const query = event.target.value.trim();
  let count = 0;
  pages.forEach(page => {
    const pre = page.querySelector('.page-text');
    const source = pre.dataset.source;
    const matched = !query || source.toLocaleLowerCase('pt-BR').includes(query.toLocaleLowerCase('pt-BR'));
    page.hidden = !matched;
    document.querySelector(`.page-nav a[href="#${page.id}"]`)?.toggleAttribute('hidden', !matched);
    if (matched) count += 1;
    highlight(pre, source, query);
  });
  resultNote.textContent = query ? `${count} página${count === 1 ? '' : 's'} encontrada${count === 1 ? '' : 's'}` : `${pages.length} páginas`;
});
"""


def nav(active: str | None = None) -> str:
    links = [f'<a href="index.html"{(" aria-current=\"page\"" if active == "home" else "")}>Início</a>']
    for doc in DOCUMENTS:
        current = ' aria-current="page"' if active == doc["slug"] else ""
        links.append(f'<a href="{doc["slug"]}.html"{current}>{html.escape(doc["label"])}</a>')
    return "".join(links)


def shell(title: str, accent: str, active: str, body_content: str) -> str:
    return f"""<!doctype html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Documentação do Centralizador Financeiro Inteligente">
  <title>{html.escape(title)} · Centralizador Financeiro Inteligente</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Outfit:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body style="--accent: {accent}">
  <a class="skip-link" href="#conteudo">Ir para o conteúdo</a>
  <header class="topbar">
    <a class="brand" href="index.html"><span class="brand-mark" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="14" x="2" y="5" rx="2"/><path d="M16 13h4"/><path d="M2 10h20"/></svg></span><span>Centralizador Financeiro</span></a>
    <nav class="doc-nav" aria-label="Documentos">{nav(active)}</nav>
  </header>
  {body_content}
  <footer class="site-footer">Documentação acadêmica · UCB · 2026 · Samuel Mota, Thiago Marques e Miguel Candido</footer>
  <script src="assets/app.js"></script>
</body>
</html>
"""


def normalize_text(text: str) -> str:
    text = unicodedata.normalize("NFC", text)
    text = text.replace("\u00a0", " ").replace("\u200b", "")
    text = re.sub(r"[ \t]+$", "", text, flags=re.MULTILINE)
    text = re.sub(r"\n{4,}", "\n\n\n", text)
    return text.strip()


def build_document(doc: dict) -> None:
    reader = PdfReader(ROOT / doc["pdf"])
    rendered_pages: list[str] = []
    page_links: list[str] = []
    for index, page in enumerate(reader.pages, start=1):
        text = normalize_text(page.extract_text(extraction_mode="layout") or page.extract_text() or "")
        safe_text = html.escape(text)
        illustration = ""
        if index in doc.get("illustrations", {}) and list(page.images):
            source_image = list(page.images)[0]
            image_name = f'{doc["slug"]}-pagina-{index}-{source_image.name}'
            (ASSETS / image_name).write_bytes(source_image.data)
            caption = html.escape(doc["illustrations"][index])
            illustration = f'<figure class="source-figure"><img src="assets/{html.escape(image_name)}" alt="{caption}"><figcaption>{caption}</figcaption></figure>'
        page_links.append(f'<a href="#pagina-{index}" aria-label="Ir para a página {index}">{index}</a>')
        rendered_pages.append(
            f'<section class="paper" id="pagina-{index}" data-page="{index}">'
            f'<div class="page-kicker"><span>{html.escape(doc["label"])}</span><span>Página {index} de {len(reader.pages)}</span></div>'
            f'<pre class="page-text" data-source="{safe_text}">{safe_text}</pre>{illustration}</section>'
        )
    content = f"""
  <main id="conteudo">
    <section class="hero">
      <p class="eyebrow">{html.escape(doc["eyebrow"])}</p>
      <h1>{html.escape(doc["title"])}</h1>
      <p class="lead">{html.escape(doc["subtitle"])}</p>
      <div class="meta-row"><span class="meta-chip">Versão {html.escape(doc["version"])}</span><span class="meta-chip">{html.escape(doc["date"])}</span><span class="meta-chip">Leitura integral</span></div>
    </section>
    <div class="reader">
      <aside class="sidebar" aria-label="Navegação por páginas">
        <p class="sidebar-title">Neste documento</p>
        <label class="search"><span class="skip-link">Buscar</span><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg><input id="doc-search" type="search" placeholder="Buscar no texto…" autocomplete="off"></label>
        <nav class="page-nav">{''.join(page_links)}</nav>
        <p class="result-note">{len(reader.pages)} páginas</p>
      </aside>
      <article class="pages" aria-label="Conteúdo integral">{''.join(rendered_pages)}</article>
    </div>
  </main>
"""
    (OUT / f'{doc["slug"]}.html').write_text(shell(doc["title"], doc["accent"], doc["slug"], content), encoding="utf-8")


def build_index() -> None:
    cards = []
    for index, doc in enumerate(DOCUMENTS, start=1):
        cards.append(f"""
      <a class="doc-card" href="{doc['slug']}.html" style="--card-accent:{doc['accent']}">
        <span class="doc-number">DOCUMENTO 0{index}</span>
        <h2>{html.escape(doc['title'])}</h2>
        <p>{html.escape(doc['subtitle'])}</p>
        <span class="card-arrow" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="m13 6 6 6-6 6"/></svg></span>
      </a>""")
    content = f"""
  <main id="conteudo">
    <section class="hero home-hero">
      <p class="eyebrow">Biblioteca do projeto</p>
      <h1>Uma visão única do produto, dos requisitos e da arquitetura.</h1>
      <p class="lead">Navegue pela documentação do Centralizador Financeiro Inteligente. Todo o conteúdo dos PDFs foi convertido para HTML pesquisável e responsivo.</p>
    </section>
    <p class="home-note">Escolha um documento para iniciar a leitura.</p>
    <section class="document-grid" aria-label="Documentos">{''.join(cards)}</section>
  </main>
"""
    (OUT / "index.html").write_text(shell("Documentação", "#10b981", "home", content), encoding="utf-8")


def main() -> None:
    ASSETS.mkdir(parents=True, exist_ok=True)
    if not (ASSETS / "styles.css").exists():
        (ASSETS / "styles.css").write_text(CSS.strip() + "\n", encoding="utf-8")
    if not (ASSETS / "app.js").exists():
        (ASSETS / "app.js").write_text(JS.strip() + "\n", encoding="utf-8")
    build_index()
    for doc in DOCUMENTS:
        build_document(doc)
    print(f"HTML gerado em {OUT}")


if __name__ == "__main__":
    main()
