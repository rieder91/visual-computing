function [maximum] = evc_histshow(input, bins)
%EVC_HISTSHOW Zeichnet das Histogramm mit angegebenen Anzahl der Balken
%   Das Histogramm soll R, G und B zusammen akkumulieren, d.h. als ob
%   das Bild ein Vektor und keine Matrix w�re.
%   imhist normiert die Intensit�ten, deshalb empfehlen wir die Funktionen
%   hist und bar. 
%
%   EINGABE
%   input... Bild
%   bins... Anzahl der Balken
%   AUSGABE
%   maximum... H�he des gr��ten Balken (Anzahl der Bildpunkte)

    %TODO Generiere einen Vektor mit linearen Abst�nden im Intervall [0,maximale_intensit�t_im_Bild].
    [count location] = hist(input(:), bins);
    
    %TODO Bilde den Histogramm auf das erzeugte Vektor ab und zeichne es
    %     als Balkendiagramm.   
    bar(location, count);
    maximum = max(count);

    %TODO Ausgabe nicht vergessen
end