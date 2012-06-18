function [result asShotNeutral] = evc_black_level(input, filename)
%EVC_BLACK_LEVEL Stellt den Schwarzwert ein und konvertiert das Bild ins double Format mit Werten [0, 1]
%   Zusätzliche Infos über das Bild können Sie mit dem Befehl imfinfo abrufen.
%
%   EINGABE
%   input... Eingelesenes Bild
%   filename... Dateiname des Bildes
%   AUSGABE
%   result... das veränderte Bayer Pattern Bild im double Format
%   asShotNeutral... neutraler Weißabgleich (in ImageInfos gespeichert)
    bits = 16;
    meta = imfinfo(filename);
    asShotNeutral = meta.AsShotNeutral;
    
    %TODO bestimme BlackLevel von den Informationen über die Datei
    blackLevel = double(meta.BlackLevel);
        
    %TODO Verschiebe und skaliere den Kontrast so das Schwarz auf 0 und
    %     Weiß auf 1 abgebildet wird. Die Bilder in deinem Datensatz haben
    %     alle den Weißwert auf (2^16) - 1 gesetzt.
    image = input - blackLevel;
    normalizer = double(2^bits - blackLevel - 1.);
    image = double(image) / normalizer;
    
    result = image;
end

