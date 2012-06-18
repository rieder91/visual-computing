function [result asShotNeutral] = evc_black_level(input, filename)
%EVC_BLACK_LEVEL Stellt den Schwarzwert ein und konvertiert das Bild ins double Format mit Werten [0, 1]
%   Zus�tzliche Infos �ber das Bild k�nnen Sie mit dem Befehl imfinfo abrufen.
%
%   EINGABE
%   input... Eingelesenes Bild
%   filename... Dateiname des Bildes
%   AUSGABE
%   result... das ver�nderte Bayer Pattern Bild im double Format
%   asShotNeutral... neutraler Wei�abgleich (in ImageInfos gespeichert)
    bits = 16;
    meta = imfinfo(filename);
    asShotNeutral = meta.AsShotNeutral;
    
    %TODO bestimme BlackLevel von den Informationen �ber die Datei
    blackLevel = double(meta.BlackLevel);
        
    %TODO Verschiebe und skaliere den Kontrast so das Schwarz auf 0 und
    %     Wei� auf 1 abgebildet wird. Die Bilder in deinem Datensatz haben
    %     alle den Wei�wert auf (2^16) - 1 gesetzt.
    image = input - blackLevel;
    normalizer = double(2^bits - blackLevel - 1.);
    image = double(image) / normalizer;
    
    result = image;
end

