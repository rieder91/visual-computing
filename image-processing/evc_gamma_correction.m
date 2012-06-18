function [result] = evc_gamma_correction(input, gamma, saturate)
%EVC_GAMMA_CORRECTION Wendet Gammakorrektur pro Farbkanal oder Helligkeit an
%   EINGABE
%   input... Bild
%   gamma.... Gamma Wert
%   saturate... Falls 1: Die Farbanteile sollen erhalten bleiben.
%               Sonst: Die Intensitätswerte sollen direkt hoch Gamma exponiert werden.
%   AUSGABE
%   result... Bild nach der Gammakorrektur

%   Wenn saturate == 1 sollen die Farbanteile erhalten bleiben.
    %result = input;
    %TODO Nicht vergessen gamma^(-1) zu nehmen und auf Division durch 0 achten
    
    result = input;
    
    if gamma == 0
        gamma = 1;
    end
    
    if (saturate)
        %TODO Berechne die Helligkeiten der Bildpunkte.
        %     Achtung, rgb2gray normalisiert das Bild. Der Ausmaß der 
        %     Intensitäten soll aber erhalten bleiben!        
        %     Berechne die Farbanteile und erhalte sie,
        %     nachdem Gammakorrektur angewandt wird
        
        % Umwandeln in Graustufen
        maximum = max(input);
        if maximum > 1
            % normalisieren
            input = input / maximum;
        end
        gray = rgb2gray(input);
        
        % Division durch 0 verhindern
        gray(gray == 0) = 1;
        
        % Chromatizität
        result(:, :, 1) = result(:, :, 1) ./ gray;
        result(:, :, 2) = result(:, :, 2) ./ gray;
        result(:, :, 3) = result(:, :, 3) ./ gray;
        
        % Gammakorrektur auf Helligkeit
        gray(:) = gray(:) .^ (1/gamma);
        
        % Rekonstruktion der Farbwerte
        result(:, :, 1) = result(:, :, 1) .* gray;
        result(:, :, 2) = result(:, :, 2) .* gray;
        result(:, :, 3) = result(:, :, 3) .* gray;
        
        if maximum > 1
            % "denormalisieren"
            result = result * maximum;
        end;
    else           
        %TODO Alle Intensitätswerte hoch gamma exponieren    
        result(:) = input(:) .^ (1/gamma);
    end
end    