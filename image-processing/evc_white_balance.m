function [result] = evc_white_balance(input, white)
%EVC_WHITE_BALANCE F�hrt einen Wei�abgleich durch.
%
%   EINGABE
%   input... Bild
%   white... ein RGB Vektor mit der Farbe, die wei� werden soll
%   AUSGABE
%   result... Ergebnis nach dem Wei�abgleich
    
    
    %TODO Berechne den Wei�abgleich mit dem white Wert
    if white(1) > 0
        result(:,:,1) = input(:,:,1) / white(1);
    end;
    if white(2) > 0
        result(:,:,2) = input(:,:,2) / white(2);
    end;
    if white(3) > 0
        result(:,:,3) = input(:,:,3) / white(3);
    end;
    
    %Hellere Bildpunkte als dieser, werden anschlie�end Werte > 1 haben.    
    %Die dadurch ben�tigte Normalisierung wird am Ende bei der Kontrastst�rkung gemacht.
end