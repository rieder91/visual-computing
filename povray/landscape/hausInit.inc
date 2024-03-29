#macro HausInit(sx, sz, style)    

    // mit '*' markierte Eintr�ge kommen von der Angabe
    
    #declare BasisHoehe = 0.3;          // inkludiert in der Haushoehe (d.h. der Hausboden ist 0.3 Einheiten hoeher als der Hof)
    
    #declare HausHofAbstandX = 5;       //*Abstand vom Haus zum Hof X 
    #declare HausHofAbstandZ = 6;       //*Abstand vom Haus zum Hof Z  
    
    #declare ZaunBreite = 0.2;          // ZaunBreite
    #declare ZaunHoehe = 1.49;          //*ZaunHoehe
    
    #declare HausHoehe = 10;            //*Hoehe des Hauses/der Wand    
    #declare HausDekoration = 1;        //*HausDekoration (ein boolscher Wert, der bestimmt, ob das Haus dekorative Elemente (nach freier Wahl) (1) hat oder nicht (2))  
    
    #declare DachFirstHoehe = 1.2;      //*DachFirstHoehe (vertikaler Abstand von der Traufe(Wandoberkante) bis zum First(Dachspitze))   
    #declare DachKranzHoehe = 0.3;      // Der vertikale Teil des Dachs bevor die Neigung zum First hin anfaengt
    #declare DachUeberstand = 0.5;      // Auskragung des Dachs ueber die Hauswaende hinaus     
    #                                   // TODO Berechne die Dachwinkel hier, falls sie notwendig sein sollten
    #declare GiebelDach = 2;            //*GiebelDach (ein boolscher Wert, der bestimmt, ob das Haus ein Giebeldach(2 Seiten geneigt, 2 Seiten vertikal) (1) oder ein Walmdach(alle Seiten geneigt) (2) hat)
                    
    #declare FensterBreite = 1.6;       //*FensterBreite  
    #declare FensterHoehe = 5.5;        //*FensterHohe (bei gewoelbten Fenstern nur vom rechteckigen Teil. Der Halbkreis als oberer Abschluss addiert noch die halbe Fensterbreite zu der GesamtFensterhoehe.)                         
    #declare FensterBasisHoehe = 1.0;   //*FensterBasisHohe (Abstand von der Basisoberkante bis zur Fensterbank)
    #declare FensterAbstand = 0.02;     //*FensterAbstand (Breite des Wandstuecks zwischen zwei Fenstern)
    #declare FensterSprAnz = 2;         //*FensterSprAnz (ein boolscher Wert, der bestimmt, ob die Fenster eher viele (1) oder weinige Sprossen (2) haben)
    #declare FensterShape = 2;          //*FensterShape (ein boolscher Wert, der bestimmt, ob das Fenster rechtecking (1) oder gewoelbt ist (2))
    #declare FensterStil = 2;           //*FensterStil (ein boolscher Wert, der bestimmt, ob das Fenster dekorative Elemente (nach freier Wahl) (1) hat oder nicht (2))
 
    #declare TuerStil = 2;              //*TuerStil (ein boolscher Wert, der bestimmt, ob die Tuer rechtecking (1) oder gewoelbt (2) ist)
    #declare TuerBreite = 1.8;          // TuerBreite
    #declare TuerHoehe = 2.5;           // nur vom rechteckigen Teil, falls die Tuer gewoelbt ist 
    #declare TuerMauerAbstand =         // Abstand von der Mauer zur Tuer
        TuerBreite / 2.0;        
    
    #declare DekorUeberstand = 0.25;
    #declare DekorHoehe = 2.00;
    #declare DekorStaerke = 0.05;
    #declare DekorEinschnitt = 1.25; 
    
    
    // Angaben ueberschreiben
    
    #declare HofSX = 5;                 //*unbebaute Hofbreite 
    #declare HofSZ = 6;                 //*unbebaute Hoftiefe
    
    #if (style = 1)
        
        #declare HausHoehe = 4;                 //*Hoehe des Hauses/der Wand 
        #declare FensterBreite = 1.2;           //*FensterBreite  
        #declare FensterHoehe = 1.5;            //*FensterHohe (bei gewoelbten Fenstern nur vom rechteckigen Teil. Der Halbkreis als oberer Abschluss addiert noch die halbe Fensterbreite zu der GesamtFensterhoehe.)
        #declare FensterBasisHoehe = 1.0;       //*FensterBasisHohe (Abstand von der Basisoberkante bis zur Fensterbank)
        #declare FensterAbstand = 0.8;          //*FensterAbstand (Breite des Wandstuecks zwischen zwei Fenstern)
        #declare FensterSprAnz = 1;             //*FensterSprAnz (ein boolscher Wert, der bestimmt, ob die Fenster eher viele (1) oder weinige Sprossen (2) haben)
        #declare FensterShape = 1;              //*FensterShape (ein boolscher Wert, der bestimmt, ob das Fenster rechtecking (1) oder gewoelbt ist (2))
        #declare FensterStil = 2;               //*FensterStil (ein boolscher Wert, der bestimmt, ob das Fenster dekorative Elemente (nach freier Wahl) (2) hat oder nicht (1))
        #declare TuerStil = 1;                  //*TuerStil (ein boolscher Wert, der bestimmt, ob die Tuer rechtecking (1) oder gewoelbt (2) ist)
        #declare GiebelDach = 2;                //*GiebelDach (ein boolscher Wert, der bestimmt, ob das Haus ein Giebeldach(2 Seiten geneigt, 2 Seiten vertikal) (1) oder ein Walmdach(alle Seiten geneigt) (2) hat)
        #declare DachFirstHoehe = 3.2;          //*DachFirstHoehe (vertikaler Abstand von der Traufe(Wandoberkante) bis zum First(Dachspitze))
        #declare HausDekoration = 2;            //*HausDekoration (ein boolscher Wert, der bestimmt, ob das Haus dekorative Elemente (nach freier Wahl) (1) hat oder nicht (2))
        #declare ZaunHoehe = 1.5;               //*ZaunHoehe
        
    #else #if (style = 2)
        #declare HofSX = 5;                     //*unbebaute Hofbreite 
        #declare HofSZ = 6;                     //*unbebaute Hoftiefe
        #declare HausHoehe = 4.5;               //*Hoehe des Hauses/der Wand
        #declare FensterBreite = 1.5;           //*FensterBreite  
        #declare FensterHoehe = 2.5;            //*FensterHohe (bei gewoelbten Fenstern nur vom rechteckigen Teil. Der Halbkreis als oberer Abschluss addiert noch die halbe Fensterbreite zu der GesamtFensterhoehe.)
        #declare FensterBasisHoehe = 0.0;       //*FensterBasisHohe (Abstand von der Basisoberkante bis zur Fensterbank)
        #declare FensterAbstand = 1.0;          //*FensterAbstand (Breite des Wandstuecks zwischen zwei Fenstern)
        #declare FensterSprAnz = 2;             //*FensterSprAnz (ein boolscher Wert, der bestimmt, ob die Fenster eher viele (1) oder weinige Sprossen (2) haben)
        #declare FensterShape = 2;              //*FensterShape (ein boolscher Wert, der bestimmt, ob das Fenster rechtecking (1) oder gewoelbt ist (2))
        #declare FensterStil = 1;               //*FensterStil (ein boolscher Wert, der bestimmt, ob das Fenster dekorative Elemente (nach freier Wahl) (2) hat oder nicht (1))
        #declare TuerStil = 2;                  //*TuerStil (ein boolscher Wert, der bestimmt, ob die Tuer rechtecking (1) oder gewoelbt (2) ist)
        #declare GiebelDach = 1;                //*GiebelDach (ein boolscher Wert, der bestimmt, ob das Haus ein Giebeldach(2 Seiten geneigt, 2 Seiten vertikal) (1) oder ein Walmdach(alle Seiten geneigt) (2) hat)
        #declare DachFirstHoehe = 2.2;          //*DachFirstHoehe (vertikaler Abstand von der Traufe(Wandoberkante) bis zum First(Dachspitze))
        #declare HausDekoration = 1;            //*HausDekoration (ein boolscher Wert, der bestimmt, ob das Haus dekorative Elemente (nach freier Wahl) (1) hat oder nicht (2))
        #declare ZaunHoehe = 1.0;               //*ZaunHoehe
        
    #end
    #end
    
    #declare GesSX = sx + HofSX;        // Gesamte Breite
    #declare GesSZ = sz + HofSZ;        // Gesamte Tiefe 
    
    #declare HausSX = sx;               // Breite des Hauses
    #declare HausSZ = sz;               // Tiefe des Hauses
    
    #declare WandDicke = 0.2;           //Achtung - die Pfosten sind breiter und das sollte im fertigen Haus sichtbar sein!
    #declare PfostenHoehe =             // PfostenHoehe (dieser Wert haengt von der Haushoehe und der Hausbasishoehe ab)
        BasisHoehe + HausHoehe;         
    #declare PfostenBreite = 0.3;       // ein Pfosten ist eine quadratische Stuetze, die an jedem Eck des Hauses steh
    #declare WandIntend =               // Eintr�cken, damit man sehen kann, das die Pfosten dicker sind als die Waende
        (PfostenBreite - WandDicke)/2.0;
    #declare WandStyle = style;         // Aussehen der Wand
    
    #declare Hx = HausSX - HausSX/2.0;  // Absolute Eckwerte des Hauses f�r X
    #declare Hy = 0.0;                  // Absolute Eckwerte des Hauses f�r Y
    #declare Hz = HausSZ - HausSZ/2.0;  // Absolute Eckwerte des Hauses f�r Z
    
#end

