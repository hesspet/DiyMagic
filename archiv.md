---
layout: page
title: "Archiv"
summary: "Alle veröffentlichten Artikel nach Jahr sortiert."
permalink: /archiv/
---

{% assign artikel_sortiert = site.artikel | where_exp: "item", "item.status != 'entwurf'" | sort: "date" | reverse %}
{% assign aktuelles_jahr = "" %}

{% if artikel_sortiert.size > 0 %}
  <div class="archive-list">
    {% for artikel in artikel_sortiert %}
      {% assign jahr = artikel.date | date: "%Y" %}
      {% if jahr != aktuelles_jahr %}
        {% unless forloop.first %}</section>{% endunless %}
        <section class="archive-year">
          <h2>{{ jahr }}</h2>
        {% assign aktuelles_jahr = jahr %}
      {% endif %}
      {% include article-card.html article=artikel %}
      {% if forloop.last %}</section>{% endif %}
    {% endfor %}
  </div>
{% else %}
  <p class="empty-state">Noch keine veröffentlichten Artikel vorhanden.</p>
{% endif %}
