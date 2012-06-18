function [maximum] = evc_histshow(input, bins)
%EVC_HISTSHOW Zeichnet das Histogramm mit angegebenen Anzahl der Balken
%   Das Histogramm soll R, G und B zusammen akkumulieren, d.h. als ob
%   das Bild ein Vektor und keine Matrix wäre.
%   imhist normiert die Intensitäten, deshalb empfehlen wir die Funktionen
%   hist und bar. 
%
%   EINGABE
%   input... Bild
%   bins... Anzahl der Balken
%   AUSGABE
%   maximum... Höhe des größten Balken (Anzahl der Bildpunkte)

    %TODO Generiere einen Vektor mit linearen Abständen im Intervall [0,maximale_intensität_im_Bild].
    [count location] = hist(input(:), bins);
    
    %TODO Bilde den Histogramm auf das erzeugte Vektor ab und zeichne es
    %     als Balkendiagramm.   
    bar(location, count);
    maximum = max(count);

    %TODO Ausgabe nicht vergessen
end