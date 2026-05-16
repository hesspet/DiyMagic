---
layout: page
title: "Themen"
summary: "Artikel nach kontrollierten Themen sortiert."
permalink: /themen/
---

{% assign artikel_sortiert = site.artikel | where_exp: "item", "item.status != 'entwurf'" | sort: "date" | reverse %}

<div class="topic-sections">
  {% for topic in site.data.topics %}
    {% assign passende_artikel = artikel_sortiert | where_exp: "item", "item.topics contains topic" %}
    {% if passende_artikel.size > 0 %}
      <section class="topic-section" id="{{ topic | slugify }}">
        <h2>{{ topic }}</h2>
        <div class="article-grid">
          {% for artikel in passende_artikel %}
            {% include article-card.html article=artikel %}
          {% endfor %}
        </div>
      </section>
    {% endif %}
  {% endfor %}
</div>

{% if artikel_sortiert.size == 0 %}
  <p class="empty-state">Noch keine veröffentlichten Artikel vorhanden.</p>
{% endif %}
