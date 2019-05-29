Der/Die BenutzerIn startet das Programm über einen Aufruf von main.m, nachdem der Ordner "MATLAB_files" als working directory gesetzt wurde. Er/Sie wird im Folgenden dazu aufgefordert zwei Bilder aus dem Datensatz zu wählen, welche dann für den Morphvorgang verwendet werden. Der vom Projektteam zur Verfügung gestellte Datensatz ist im Ordner "input" zu finden. Es können nur Bilder aus jenem Ordner gewählt werden.

Darufhin müssen vom User auf beiden Bildern jeweils 13 Featurepoints gesetzt werden. Die Anzahl der zu wählenden Punkte kann in main.m geändert werden.

Die restliche Interaktion findet über das GUI statt. Hier kann der/die BenutzerIn den Interpolationsfaktor durch Verschieben des Sliders oder durch Editieren des Textfeldes einstellen. Durch Klicken des Ok-Buttons werden die Bilder mit dem momentan gewählten Faktor zu einem neuen Bild zusammengefügt, welches daraufhin im GUI gezeigt wird. Alternativ kann der Animate-Button verwendet werden, um eine Animation vom ersten Bild zum zweiten, und wieder zurück, anzuzeigen.

Durch Klicken des Save-Buttons wird das aktuell sichtbare Bild im Ordner "output" gespeichert.