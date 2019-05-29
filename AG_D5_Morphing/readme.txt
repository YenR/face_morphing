Der/Die BenutzerIn startet das Programm �ber einen Aufruf von main.m, nachdem der Ordner "MATLAB_files" als working directory gesetzt wurde. Er/Sie wird im Folgenden dazu aufgefordert zwei Bilder aus dem Datensatz zu w�hlen, welche dann f�r den Morphvorgang verwendet werden. Der vom Projektteam zur Verf�gung gestellte Datensatz ist im Ordner "input" zu finden. Es k�nnen nur Bilder aus jenem Ordner gew�hlt werden.

Darufhin m�ssen vom User auf beiden Bildern jeweils 13 Featurepoints gesetzt werden. Die Anzahl der zu w�hlenden Punkte kann in main.m ge�ndert werden.

Die restliche Interaktion findet �ber das GUI statt. Hier kann der/die BenutzerIn den Interpolationsfaktor durch Verschieben des Sliders oder durch Editieren des Textfeldes einstellen. Durch Klicken des Ok-Buttons werden die Bilder mit dem momentan gew�hlten Faktor zu einem neuen Bild zusammengef�gt, welches daraufhin im GUI gezeigt wird. Alternativ kann der Animate-Button verwendet werden, um eine Animation vom ersten Bild zum zweiten, und wieder zur�ck, anzuzeigen.

Durch Klicken des Save-Buttons wird das aktuell sichtbare Bild im Ordner "output" gespeichert.