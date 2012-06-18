function [x y p] = evc_pick_point(input)
%EVC_PICK_POINT L�sst den Benutzer einen Bildpunkt selektieren
%
%   EINGABE
%   input... Bild
%   AUSGABE
%   x... X Koordinate des ausgew�hlten Punktes
%   y... Y Koordinate des ausgew�hlten Punktes
%   p... true, falls die Koordinate (x,y) im Bild liegt
%              sonst p = false

    %TODO Lasse den Benutzer einen Bildpunkt ausw�hlen (mit ginput)
    %     Beachte, dass x und y aus der R�ckgabe vertauscht geh�ren,
    %     denn Matlab speichert die Bilder Spaltenweise!
    [y x] = ginput(1);
    
    %TODO Die Koordinaten runden 
    x = round(x);
    y = round(y);

    %TODO Ausgabe nicht vergessen
    [row, col] = size(input(:,:,1));
    p = (x > 0) && (y > 0) && (x < row) && (y < col);
end

