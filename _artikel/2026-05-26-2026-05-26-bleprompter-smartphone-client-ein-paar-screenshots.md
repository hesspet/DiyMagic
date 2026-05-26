---
layout: artikel
title: "2026-05-26 BlePrompter Smartphone Client - Ein paar Screenshots"
date: 2026-05-26
updated: 2026-05-26
type: "Bericht"
topics:
  - BLE-Prompter
  - Smartphone
  - Zauberapp
  - Software
  - Android
summary: "Eine erste Vorstellung der Bedienung des BlePrompter Smartphone Client"
hero:
status: "fertig"
difficulty:
permalink: /artikel/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots.html
---

# BlePrompter Smartphone Client - Ein paar Screenshots

Wie funktioniert das Ganze Thema mit der Übertragung vom Smartphone auf den BlePrompter?

Hier mal ein kurzer Duchlauf des aktuellen Stands der Smartphone App.

## Android und iOS?

Jaaa... braucht aber noch Zeit mit dem iOS. Die Plattform die ich zum Entwickeln nutze kann Code für Android als auch für iOS erzeugen. Ein iPhone 12 bekomme ich die Tage. Dann brauche ich nur noch einen Entwickleraccount bei Apple. Das schiebe ich aber hinaus, denn erst wenn klar ist, dass ein paar Leute Interesse an der kleinen Hardware haben und bereit sind ein paar Euro für die App auszugeben werden ich die Entwickleraccounts kaufen.

Grundsätzlich kann ich im Moment aber nur für iOS einen Testmode verwenden. Also hier ein paar Screenshots meines Android Phones.

## Screenshots

### Verbindungsaufbau und Setup

Die Anwendung selbst ist erst einmal recht unscheinbar. Im Kopfbereich sehen wir "Getrennt". Dies bedeutet, aktuell haben wir keine BLE Verbindung zum BlePrompter.

Der hier gezeigte Teil "Peeker (Videofake)" ist die Implementation einer Showsituation, dass der Vorführende mit einem Zuschauer eine Gedankenleseroutine ausführt. Ein Helfer hat das Smartphone mit dieser Anwendung und verhält sich wie ein üblicher Zuschauer und filmt. Schaut jemand auf das Display, so sieht er einfach die typische Optik einer Smartphone Kamera. Das sehen wir dann später. Daher der Name "Videofake".

Hintergrund ist, dass ich die App vor allem für meinen eigenen Zweck als Bauchredner in der Form eines Streetacts verwende. Zaubern und Bauchreden ist schwierig. Man hat nur eine Hand... also lasse ich mir helfen und habe einen Companion unter den Zuschauern...

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/001-Vor_de_Verbindungsaufbau.jpg" style="zoom: 33%;" />

Wir klicken auf Verbinden und sehen "Gefundene Geräte". Beim BLE Scan sucht die Anwendung gezielt nach Geräten mit unserem speziellen Profil. Normalerweise findet die Anwendung nur ein Gerät das ausgewählt werden kann.

War das Gerät bereits beim letzten Anwendungsaufruf schon einmal verbunden, so wird beim App Start, die Verbindung automatisch aufgebaut. Das erspart in einer Livesituation Bedienungsfehler. Hier aber der Grundablauf. "Suche Gerät"

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/002_Scan_nach BlePrompter.jpg" alt="002_Scan_nach BlePrompter" style="zoom:33%;" />

Wir sehen nun "Verbunden" und bekommen das "Hauptmenü"

* **Anzeige löschen**
  Löschen der Anzeige des Displays im BlePrompter
* **Trennen**
  Abbau der Verbindung zum BlePrompter. Hier überlege ich ob das überhaupt auf die Hauptseite soll, denn warum sollte man auf die Idee kommen die Verbindung während einer Show zu Trennen. Das wandert ggf. noch in die Einstellungen
* **Anzeigen im BlePrompter**
  Dies ist die aktuelle Auswahl von Ideen was man dem Prompter schicken kann. Dies kann recht einfach in der Firmware erweitert werden. Aktuell gibt es vier Darstellungen
  * Pfeile
    Übertragung von Kommandos von Pfeilrichtungen
  * Karten (Kartenkürzel)
    Übertragung der Farbe und des Wertes einer Karte. Pokerdeck
  * Symbole
    Freier "Text" ein oder zwei Buchstaben per Texteingabe
  * ESP
    Übertragung eines der fünf ESP Symbole (aktuell mein Anwendungsfall)

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/003_Verbindung_hergestellt.jpg" alt="003_Verbindung_hergestellt" style="zoom:33%;" />

Über das Drawer Menü (Hamburger) oben rechts erreicht man die Einstellungen. Diese werden gespeichert müssen also nur einmal durchgeführt werden.

* **Dunkelmodus** - Je nach Bediener kann eine helle oder dunkle Oberfläche eingestellt werden
* **Schließe Buttonansicht nach Senden**
  Wenn das Geheimmenü in der Videoanwendung gestartet wird, kann nach dem Senden einer Information an den BlePrompter das Menü automatisch geschlossen werden, oder wenn nicht aktiviert geöffnet bleiben.
* **Displayanzeige invertiert**
  * Off - BlePrompter: weiße Schrift auf schwarzem Hintergrund
  * On - BlePrompter: schwarze Schrift auf weißem Hintergrund
* **Displayanzeige drehen**
  * Off - BlePrompter: Ausrichtung der Anzeige in Boardhauptrichtung
  * On - BlePrompter: Ausrichtung der Anzeige um 180 Grad gedreht. "Kopfüber". Wird z.B. bei dem Einsatz in der Daumenspitze gebraucht
* **Kameraansicht**
  Anpassungen der Kameraansicht an das jeweilige Betriebssystem, damit die Kamera möglichst realistisch aussieht.
* **Kamera-Bedienung**
  Anzeigevariationen des geheimen Sendemenüs in der Fakevideoansicht
  * **Normal**
    Das Menü wird komplett sichtbar eingeblendet
  * **Durchsichtig**
    Das Menü wird nur mit den Rahmen dargestellt "Durchsichtig"
  * **Unauffällig / Anpassbar**
    Experimentelle Optionen, bisher nur rudimentär implementiert. Kann auch sein, dass die wieder ausgebaut werden. Der Nutzen ist zweifelhaft.

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/004_Programmeinstellungen.jpg" alt="004_Programmeinstellungen" style="zoom:33%;" />

Umschaltung auf Dunkelmodus erfolgt sofort

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/005_Dunkelmodus aktiviert.jpg" alt="005_Dunkelmodus aktiviert" style="zoom:33%;" />

Hier jetzt die Einstellung der Kamera auf "Android und Normalansicht"

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/006_Setup_durchgefuehrt.jpg" alt="006_Setup_durchgefuehrt" style="zoom:33%;" />

Zurück zur Hauptansicht. Jetzt geht es los. ESP Modus wird angeklickt

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/007_Es_geht_los_ESP.jpg" alt="007_Es_geht_los_ESP" style="zoom:33%;" />

Uns so würde nun ein Betrachter neben des Companion, der auf das Smartphone schaut die das Livevideobild sehen. Vollkommen unverfänglich. Sieht einfach so aus wie jemand der die Vorführung filmt.

![008_LivePseudFilen](./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/008_LivePseudFilen.jpg)

Kurzer Klick auf die Kopfzeile, das Geheimmenü erscheint und der Companion kann dem Vorführenden auf den BlePrompter das "gepeekte" ESP Symbol übermitteln.

![009_Das_geheimmenue_in_normalansicht](./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/009_Das_geheimmenue_in_normalansicht.jpg)

Wir schalten auf die noch geheimere Ansicht im Setup um

<img src="./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/010_Kamera_Bedienung_Showmodus.jpg" alt="010_Kamera_Bedienung_Showmodus" style="zoom:33%;" />

Der gleiche Ablauf wie vorher

![011_Nochmal_Filmen](./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/011_Nochmal_Filmen.jpg)

Jetzt blendet sich das Menü aber fast unsichtbar ein. Selbst ein misstrauischer Zuschauer dürfte jetzt nicht mehr erkennen, dass hier "geschummelt" wird. 

![012_Unsichtbares_Menu](./../assets/images/articles/2026-05-26-bleprompter-smartphone-client-ein-paar-screenshots/012_Unsichtbares_Menu.jpg)
