function [result] = evc_compute_binary(input, x, top)
%EVC_COMPUTE_BINARY Berechnet ein binäres Bild nach dem übergebenen Schwellwert (x)
%
%   EINGABE
%   input... Bild
%   x... Schwellwert
%   top... Falls 0, soll ein Inversionsbild generiert werden (0=>Weiß, 1=>Schwarz).
%   AUSGABE
%   result = Binäres Bild

    result = input;
    if top == 1
        result(result > x) = 1;
        result(result <= x) = 0;
    else
        % Inversionsbild
        result(result > x) = 0;
        result(result <= x) = 1;
    end
    %Da im Eingabebild auch Intensitäten über 1 vorkommen, ist es besser
    %die Funktion im2bw nicht zu verwenden (sie wird abstürzen).
end
    