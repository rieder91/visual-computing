#macro HausInit(sx, sz, style)    

    //TODO Setze Stilabhaengige Konstanten

    //Folgende Variablen sind zu deklarieren:
    //FensterBreite
    //FensterHohe (bei gewoelbten Fenstern nur vom rechteckigen Teil. Der Halbkreis als oberer Abschluss addiert noch die halbe Fensterbreite zu der GesamtFensterhoehe.)
    //FensterBasisHohe (Abstand von der Basisoberkante bis zur Fensterbank)
    //FensterAbstand (Breite des Wandstuecks zwischen zwei Fenstern)
    //FensterSprAnz (ein boolscher Wert, der bestimmt, ob die Fenster eher viele oder weinige Sprossen haben)
    //FensterShape (ein boolscher Wert, der bestimmt, ob das Fenster rechtecking oder gewoelbt ist)
    //FensterStil (ein boolscher Wert, der bestimmt, ob das Fenster dekorative Elemente (nach freier Wahl) hat oder nicht)
    //TuerStil (ein boolscher Wert, der bestimmt, ob die Tuer rechtecking oder gewoelbt ist)
    //PfostenHoehe (dieser Wert haengt von der Haushoehe und der Hausbasishoehe ab)
    //DachFirstHoehe (vertikaler Abstand von der Traufe(Wandoberkante) bis zum First(Dachspitze))
    //HausDekoration (ein boolscher Wert, der bestimmt, ob das Haus dekorative Elemente (nach freier Wahl) hat oder nicht)
    #declare HausDekoration = 0;
    //GiebelDach (ein boolscher Wert, der bestimmt, ob das Haus ein Giebeldach(2 Seiten geneigt, 2 Seiten vertikal) oder ein Walmdach(alle Seiten geneigt) hat)
    //ZaunHoehe

    // Stilunabhaengige Konstanten

    //TODO Setze die Hofgroesse hier
    #declare BasisHoehe = 0.3; //inkludiert in der Haushoehe (d.h. der Hausboden ist 0.3 Einheiten hoeher als der Hof)
    #declare ZaunBreite = 0.2;
    #declare HofSX = 6.0; // unbebaute Hofbreite
    #declare HofSZ = 5.0; // unbebaute Hoftiefe
    #declare PfostenBreite = 0.3; //ein Pfosten ist eine quadratische Stuetze, die an jedem Eck des Hauses steht

    #declare DachKranzHoehe = 0.3; // Der vertikale Teil des Dachs bevor die Neigung zum First hin anfaengt
    #declare DachUeberstand = 0.5; // Auskragung des Dachs ueber die Hauswaende hinaus
    #//TODO Berechne die Dachwinkel hier, falls sie notwendig sein sollten 

    #declare WandDicke = 0.2; //Achtung - die Pfosten sind breiter und das sollte im fertigen Haus sichtbar sein!

    #declare TurBreite = 1.2;
    #declare TurHohe = 2.5; // nur vom rechteckigen Teil, falls die Tuer gewoelbt ist

    #declare DekorUeberstand = 0.25;
    #declare DekorHoehe = 2.00;
    #declare DekorStaerke = 0.05;
    #declare DekorEinschnitt = 1.25;

#end

