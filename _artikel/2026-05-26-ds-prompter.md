---
layout: artikel
title: "DS Prompter"
date: 2026-05-26
updated:
type: "Notiz"
topics:
  - Requisitenbau
  - Zauberei
  - Puppenspiel
  - Daumenspitze
  - BLE-Prompter
  - ESP32
summary: "Das Eckige muss ins Runde. Weitere Prompter Variante!"
hero:
status: "fertig"
difficulty:
permalink: /artikel/ds-prompter.html
---

# 2026-04-24 Das Eckige muss ins Runde. Weitere Prompter Variante!

Wo kann man so einen kleinen Prompter denn noch einbauen?
Irgend wie hab ich mir in den Kopf gesetzt, dass diese kleine Platine ...

<img src="./../assets/images/articles/ds-prompter/Abgenagt.jpg" style="zoom:33%;" />

... in eine Daumenspitze passen müsste. Naja, sie ist ein ganz klein wenig zu breit. Also erstmal ganz dreckig die Lötaugen auf der einen Seite etwas abgeknabbert. Kann man besser machen, aber für ein Experiment. Laut Lupe sind da keine Empfindlichen Leiterbahnen drunter. 

<img src="./../assets/images/articles/ds-prompter/DasEckigeMussInsRunde.jpg" alt="DasEckigeMussInsRunde" style="zoom:15%;" />

Also erstmal abrassiert. Auf der anderen Seite ist das leider etwas problematischer. Die V5 und die GD (Ground) brauen wir. Nur, da finden sich noch ein paar Stellen an denen man da sich selbst anschließen kann. Kommt noch. Vorerst reicht sogar der kleine Eingriff.

<img src="./../assets/images/articles/ds-prompter/PasstDas.jpg" alt="PasstDas" style="zoom:15%;" />

Könnte irgendwie passen...geht. Also die Platine geht rein. Ich denke mit etwas Aufwand bekomme ich da auch so einen von den kleinen Akkus rein.

<img src="./../assets/images/articles/ds-prompter/GehtRein2.jpg" alt="GehtRein2" style="zoom:15%;" />

Zum Laden muss man die Platine immer rausmachen. Muss man bei eine D-Light auch. Was man auf jeden Fall vorsehen muss ist ein Faden oder ein Band, die Platine sitzt schon recht fest in der Daumenspitze fest.

Bisher ist es erst einmal eine Idee. Mal sehen was daraus wird.

## 2026-05-26 Der erste Prototype

Einfach mal ein Versuch, jetzt mit Akku alles drin und ab auf den Daumen.

<img src="./../assets/images/articles/ds-prompter/DS_000.jpg" style="zoom:33%;" /> <img src="./../assets/images/articles/ds-prompter/DS_001.jpg" alt="DS_001" style="zoom:33%;" /> <img src="./../assets/images/articles/ds-prompter/DS_003.jpg" alt="DS_003" style="zoom:33%;" /> <img src="./../assets/images/articles/ds-prompter/DS_005.jpg" alt="DS_005" style="zoom:33%;" />

Da hat einer ein Loch in meinen Daumen gemacht....

<img src="./../assets/images/articles/ds-prompter/DS_009.jpg" alt="DS_009" style="zoom:33%;" /> <img src="./../assets/images/articles/ds-prompter/DS_011.jpg" alt="DS_011" style="zoom:33%;" />

Sollte so gehen, Ok, den Ausschnitt könnte man hübscher machen, aber Hauptsache es funktioniert. Falls jetzt jemand glaubt, dass Bild wäre ein Fake. Nein, das Display ist wirklich so klar.

## Noch ein paar Details

Hier nun ein paar Fotos wie die Montage bewerkstelligt wird. Das Teil wird mit dem Akku verbunden und dann einfach mit dem Akku zusammen in die Spitze der Daumenspitze geschoben.

Hinweis: Ja, da ist ein Schalter dran bezüglich On/Off. Zum einen habe ich gerade keinen super kleinen Schalter zur Hand, zum anderen so geht es auch. Mit einem geladenen Akku komme ich aktuell auf eine Betriebszeit von über 5 Stunden. Das sollte in der Praxis für eine Show reichen. Ggf. kann man vor jedem Auftritt einfach ein neuen Akku einsetzen. 

Man darf hier nicht vergessen, es handelt sich um die Nutzung von Fertigkomponenten und ich wollte den Lötaufwand auf ein Mindestmaß beschränken.

Um die Montage mit dem Akku etwas zu vereinfachen, habe ich den Akkuanschluss bewusst etwas länger gelassen. Das stört in der Daumenspitze nicht, vereinfacht aber das Handling

![](./../assets/images/articles/ds-prompter/IMG_20260526_083406.jpg)

Auf diesem Bild sieht man, dass auf dem Akku ein kleines Stück doppelseitiges Klebeband angebracht ist. Das verhindert bei der Montage, beim Einschieben in die Daumenspitze, dass die Teile verrutschen.

![](./../assets/images/articles/ds-prompter/IMG_20260526_083225.jpg)

Vor der Montage. Es ist so simpel wie es aussieht. Man nimmt das "Päckchen" und schiebt es vorsichtig in Position, so dass das Display in dem Ausschnitt erscheint.

![](./../assets/images/articles/ds-prompter/IMG_20260526_083422.jpg)

Und fertig!

![](./../assets/images/articles/ds-prompter/IMG_20260526_083451.jpg)

In der Praxis habe ich festgestellt, dass die invertierte Darstellung die Daumenspitze noch unverfänglicher macht.
Hinweis: Hier am Prototyp ist die Betriebled des Boards noch aktiv. Sie ist im Prinzip ein unnötiger Stromverbraucher. Man könnte sie auch einfach auslöten, hätte aber dann beim Experimentieren keine Kontrolle mehr ob der Akku Strom liefert oder nicht, falls das Display gerade gelöscht ist. Alternativ, man kann sie auch einfach mit etwas schwarzem Isolierband abkleben. Bei Tageslicht ist sie aber so gut wie gar nicht mehr aus Zuschauersicht zu erkennen. Vorerst bleibt sie mal dran. Das Projekt ist ja im "Werden".

Neu ist nun in der Firmware auch die Möglichkeit die Anzeige um 180 Grad zu drehen. Je nach Einbausituation, also nicht nur in einer Daumenspitze, kann es gut sein, die Anzeige nach Bedarf zu drehen. Dies Einstellung, genauso wie die Invertierung der Anzeige wird im Smartphone direkt vorgenommen. 

Hinweis: Das kleine Board hat einen Resetknopf, den habe ich deaktiviert, da dieser Knopf direkt vorne in der Spitze neben der, nun nicht sichtbaren, USB Schnittstelle sitzt. Die "Haut" der Daumenspitze hat die Tendenz durch die Klemmung gerne mal den kleinen Resetknopf zu drücken. Keine gute Idee. Also weg damit. Bzw. ich habe einfach ein Stück des Knopfe mit weggefrässt, als ich das Board "Daumenspitzentauglich" gemacht habe.

![IMG_20260526_083923_1](./../assets/images/articles/ds-prompter/IMG_20260526_083923_1.jpg)

![IMG_20260526_084006](./../assets/images/articles/ds-prompter/IMG_20260526_084006.jpg)



## Board verkleinern

Hier sieht man eine Detailansicht des für die Daumenspitze angepassten Boards.

> Hinweis: Die schwarze Buchsen sind schon eine Idee der Verbesserung des ON/OFF.

Wie man auf dem Bild sieht, habe ich mit der Dremel die gesamte Lötaugenreihe entfernt. Somit konnte ich das Board etwas "keilförmiger" machen und es passt so wunderbar bis in die Spitze des Daumens.

Das Ganze hat aber eine Nachteil. Zwei der Lötaugen werden eigentlich gebraucht. Der Masseanschluss (GND) und der 5V bzw. Akku Anschluss. Kann man aber lösen. Ich habe einfach die 5V direkt an die Schutzdiode gelötet. Die ist recht groß und man kann sehr einfach an dieser Stelle die 5V Leitung anlöten. Die Masse (GND) wird auf der Displayseite einfach an eines der Beinchen des zweiten Schalters angelötet. Die Kabel habe ich dann einfach mit etwas Sekundenklebergel "zugentlastet".

> Ja -  die Daumenspitzenidee ist ein übler Hack :-) 

![](./../assets/images/articles/ds-prompter/AngeknabbertRückseite.jpg)

