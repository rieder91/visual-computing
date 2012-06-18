function [result] = evc_white_balance(input, white)
%EVC_WHITE_BALANCE Führt einen Weißabgleich durch.
%
%   EINGABE
%   input... Bild
%   white... ein RGB Vektor mit der Farbe, die weiß werden soll
%   AUSGABE
%   result... Ergebnis nach dem Weißabgleich
    
    
    %TODO Berechne den Weißabgleich mit dem white Wert
    if white(1) > 0
        result(:,:,1) = input(:,:,1) / white(1);
    end;
    if white(2) > 0
        result(:,:,2) = input(:,:,2) / white(2);
    end;
    if white(3) > 0
        result(:,:,3) = input(:,:,3) / white(3);
    end;
    
    %Hellere Bildpunkte als dieser, werden anschließend Werte > 1 haben.    
    %Die dadurch benötigte Normalisierung wird am Ende bei der Kontraststärkung gemacht.
end