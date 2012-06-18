function [result] = evc_demosaic(input, neutral)
%EVC_DEMOSAIC Rechnet die fehlende Farbwerte nach
%   Dazu soll vorher noch ein neutraler Weißabgleich vorgenommen werden.
%   Anschließend sollen die fehlenden Werte durch lineare Interpolation 
%   berechnet werden (siehe Angabe!). Die Kernel der Interpolationsfilter 
%   müssen selbst geschrieben werden.
%
%   EINGABE
%   input... Bild
%   neutral... die neutrale Weißfarbe
%   AUSGABE
%   result... RGB Bild   
    % ich habe grbg
    
    %TODO Erzeuge Matricen für R, G und B mit lauter 0.
    %     Bestimme das Bayer Muster der Bilder in deinem Datensatz.
    %     Fülle sie mit Werten aus den Bayer Matrix.
    %     Dazu eignen sich gut die "start:skip:end" Selektion,
    %     oder die retmap Funktion.
    %     Wende den neutralen Weißabgelich an.
    [row, col] = size(input(:,:,1));
    r = zeros(row, col);
    g = zeros(row, col);
    b = zeros(row, col);
    
    for i = 1:col
        if mod(i, 2) == 0
            r((row * (i-1)) + 1 : 2 : row * i) = input((row * (i-1)) + 1 : 2 : row * i);
            g((row * (i-1)) + 2 : 2 : row * i) = input((row * (i-1)) + 2 : 2 : row * i);
        else
            g((row * (i-1)) + 1 : 2 : row * i) = input((row * (i-1)) + 1 : 2 : row * i);
            b((row * (i-1)) + 2 : 2 : row * i) = input((row * (i-1)) + 2 : 2 : row * i); 
        end
    end
    
    % neutraler Weißabgleich
    if neutral(1) > 0
        r = r / neutral(1);
    end;
    if neutral(2) > 0
        g = g / neutral(2);
    end;
    if neutral(3) > 0
        b = b / neutral(3);
    end;
    
    %TODO Interpoliere die fehlenden Farbwerte.
    int_rb = [1/4 1/2 1/4;
              1/2 1 1/2;
              1/4 1/2 1/4];
          
    int_g = [0 1/4 0;
             1/4 1 1/4;
             0 1/4 0];
    
    r_int = imfilter(r, int_rb); 
    b_int = imfilter(b, int_rb);
    g_int = imfilter(g, int_g);

    %TODO verbinde R, B, G zu einer Matrix.
    result(:,:,1) = r_int;
    result(:,:,2) = g_int;
    result(:,:,3) = b_int;   
end