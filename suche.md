---
layout: page
title: "Suche"
summary: "Lokale Suche im Artikelarchiv."
permalink: /suche/
---

<div id="search-config" data-search-url="{{ '/search.json' | relative_url }}"></div>

<form class="search-controls" role="search">
  <label for="search-input">Suchbegriff</label>
  <input id="search-input" type="search" placeholder="Suchbegriff eingeben..." autocomplete="off">

  <label for="type-filter">Artikeltyp</label>
  <select id="type-filter">
    <option value="">Alle Typen</option>
  </select>

  <label for="year-filter">Jahr</label>
  <select id="year-filter">
    <option value="">Alle Jahre</option>
  </select>
</form>

<div id="search-results" class="search-results" aria-live="polite">
  <p class="empty-state">Die Suche wird geladen.</p>
</div>

<noscript>
  <p class="empty-state">Die Suche benötigt JavaScript. Archiv und Themenübersicht funktionieren ohne JavaScript.</p>
</noscript>

<script src="{{ '/assets/js/search.js' | relative_url }}" defer></script>
