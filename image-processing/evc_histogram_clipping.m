function [result] = evc_histogram_clipping(input, low, high)
%EVC_HISTOGRAM_CLIPPING Schneidet das Histogramm und normalisiert die Intensitäten
%
%   EINGABE
%   input ... Bild
%   low... Schwarzpunkt für das Histogramm Clipping
%   high... Weißpunkt für das Histogramm Clipping
%   AUSGABE
%   result... Bild nach dem Histogramm Clipping (Intensitäten im Bereich [0,1])

    result = input;
    
    %TODO Falls low < 0 ist, muss es zuerst auf 0 gesetzt werden,
    %           high soll <= als die maximale Intensität im Bild sein.
    %     Schneide die Werte so ab, dass [low, high] auf [0, 1] 
    %     abgebiltet wird.
    if low < 0
        low = 0;
    end
    
    if high > max(input)
        high = max(input);
    end
    
    % Histogramm stauchen
    result(result < low) = low;
    result(result > high) = high;
    result = result - low;
    
    % Check auf DIV/0
    if max(result(:)) ~= 0
        result = result / max(result(:));
    end;
end