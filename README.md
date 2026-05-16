# DiyMagic

DiyMagic ist ein statisches Artikelarchiv für Anleitungen, Berichte, Projektnotizen und Referenzen. Die Inhalte liegen als Markdown-Dateien im Repository, Metadaten stehen im YAML-Header, Bilder werden lokal im Repository verwaltet.

## Lokaler Arbeitsablauf

Neuen Artikel erzeugen:

```powershell
.\tools\New-Article.ps1 `
  -Title "Gartenhaus: Fundament ausrichten" `
  -Type "Anleitung" `
  -Topics "Garten,Holzarbeiten" `
  -Summary "Eine Schritt-für-Schritt-Anleitung zum Ausrichten eines kleinen Gartenhausfundaments."
```

Artikel prüfen:

```powershell
.\tools\Validate-Articles.ps1
```

Lokalen Build starten, falls Jekyll installiert ist:

```powershell
.\tools\Build-Local.ps1
```

Lokale Vorschau starten, falls Jekyll installiert ist:

```powershell
.\tools\Serve-Local.ps1
```

## Artikelmetadaten

Pflichtfelder im YAML-Header:

- `title`
- `date`
- `type`
- `topics`
- `summary`
- `status`

Datumswerte werden im Header als `YYYY-MM-DD` geschrieben. Die Website zeigt Datumswerte im Format `DD.MM.YYYY` an.

Erlaubte Statuswerte:

- `entwurf`
- `fertig`
- `überarbeitet`
- `archiviert`

Entwürfe bleiben im Repository, erscheinen aber nicht auf Startseite, Archiv, Themenseite oder Suche.

Jekyll ist so konfiguriert, dass auch Artikel mit einem Datum in der Zukunft gebaut werden. Die Veröffentlichung wird in diesem Projekt nicht über das Datum gesteuert, sondern über `status`.

Artikeldateien müssen als UTF-8 ohne BOM gespeichert werden. Ein UTF-8-BOM vor dem ersten `---` verhindert, dass Jekyll den YAML-Header zuverlässig als Front Matter erkennt.

## Bilder

Artikelbilder liegen unter:

```text
assets/images/articles/<artikel-slug>/
```

In Artikeln werden Bildlinks Typora-kompatibel relativ aus `_artikel` heraus geschrieben:

```markdown
![Kurzer Alternativtext](./../assets/images/articles/<artikel-slug>/bild.jpg)
```

Damit diese Links auch auf GitHub Pages funktionieren, werden Artikel als HTML-Dateien unter `/artikel/<slug>.html` veröffentlicht. Von dort zeigt `./../assets/...` korrekt auf den zentralen Bilderordner, auch wenn `baseurl: "/DiyMagic"` gesetzt ist.

Empfohlen ist `.webp` mit maximal etwa 1600 px Breite für Artikelbilder. Mit ImageMagick können Bilder vorbereitet werden:

```powershell
.\tools\Optimize-Images.ps1 `
  -Source ".\_incoming-images\gartenhaus" `
  -Target "assets\images\articles\gartenhaus-fundament-ausrichten" `
  -MaxWidth 1600
```

## GitHub Pages

Die Veröffentlichung erfolgt über GitHub Actions. In den Repository-Einstellungen unter `Settings -> Pages` als Quelle `GitHub Actions` auswählen.

Wenn das Repository als Projektseite unter `https://<user>.github.io/DiyMagic/` läuft, in `_config.yml` setzen:

```yaml
baseurl: "/DiyMagic"
```

Wenn es als Benutzerseite, Organisationsseite oder mit eigener Domain läuft:

```yaml
baseurl: ""
```

## Backup

Das Repository selbst ist das wichtigste Backup für Texte und veröffentlichte Bilder. Originalbilder sollten zusätzlich außerhalb des Repositories gesichert werden, zum Beispiel auf einer externen Platte oder einem NAS.

Optional kann ein zweiter Remote eingerichtet werden:

```powershell
git remote add backup <backup-url>
git push backup main
```
