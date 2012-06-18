function [result] = evc_compute_binary(input, x, top)
%EVC_COMPUTE_BINARY Berechnet ein bin�res Bild nach dem �bergebenen Schwellwert (x)
%
%   EINGABE
%   input... Bild
%   x... Schwellwert
%   top... Falls 0, soll ein Inversionsbild generiert werden (0=>Wei�, 1=>Schwarz).
%   AUSGABE
%   result = Bin�res Bild

    result = input;
    if top == 1
        result(result > x) = 1;
        result(result <= x) = 0;
    else
        % Inversionsbild
        result(result > x) = 0;
        result(result <= x) = 1;
    end
    %Da im Eingabebild auch Intensit�ten �ber 1 vorkommen, ist es besser
    %die Funktion im2bw nicht zu verwenden (sie wird abst�rzen).
end
    