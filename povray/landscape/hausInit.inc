#macro HausInit(sx, sz, style)    

// sz
// sy
// style: =0 
//        =1 

    // mit '*' markierte Einträge kommen von der Angabe
    
    #declare BasisHoehe = 0.3;          // inkludiert in der Haushoehe (d.h. der Hausboden ist 0.3 Einheiten hoeher als der Hof)
    
    #declare HausHofAbstandX = 5;       //*Abstand vom Haus zum Hof X 
    #declare HausHofAbstandZ = 6;       //*Abstand vom Haus zum Hof Z  
    
    #declare HofSX = 5;                 //*unbebaute Hofbreite 
    #declare HofSZ = 6;                 //*unbebaute Hoftiefe
     
    #declare GesSX = sx + HofSX;        // Gesamte Breite
    #declare GesSZ = sz + HofSZ;        // Gesamte Tiefe     
    
    #declare ZaunBreite = 0.2;          // ZaunBreite
    #declare ZaunHoehe = 1.49;           //*ZaunHoehe
                                        
    #declare HausSX = sx;               // Breite des Hauses
    #declare HausSZ = sz;               // Tiefe des Hauses
    #declare HausHoehe = 4;             //*Hoehe des Hauses/der Wand    
    #declare HausDekoration = 1;        // HausDekoration (ein boolscher Wert, der bestimmt, ob das Haus dekorative Elemente (nach freier Wahl) (1) hat oder nicht (2))  
    
    #declare WandDicke = 0.2;           //Achtung - die Pfosten sind breiter und das sollte im fertigen Haus sichtbar sein!
    #declare PfostenHoehe =             // PfostenHoehe (dieser Wert haengt von der Haushoehe und der Hausbasishoehe ab)
        BasisHoehe + HausHoehe;         
    #declare PfostenBreite = 0.3;       // ein Pfosten ist eine quadratische Stuetze, die an jedem Eck des Hauses steht
    
    #declare DachFirstHoehe = 3.2;      //*DachFirstHoehe (vertikaler Abstand von der Traufe(Wandoberkante) bis zum First(Dachspitze))   
    #declare DachKranzHoehe = 0.3;      // Der vertikale Teil des Dachs bevor die Neigung zum First hin anfaengt
    #declare DachUeberstand = 0.5;      // Auskragung des Dachs ueber die Hauswaende hinaus     
    #                                   // TODO Berechne die Dachwinkel hier, falls sie notwendig sein sollten
    #declare GiebelDach = 1;            //*GiebelDach (ein boolscher Wert, der bestimmt, ob das Haus ein Giebeldach(2 Seiten geneigt, 2 Seiten vertikal) (1) oder ein Walmdach(alle Seiten geneigt) (2) hat)
                    
    #declare FensterBreite = 1.2;       //*FensterBreite  
    #declare FensterHoehe = 1.5;        //*FensterHohe (bei gewoelbten Fenstern nur vom rechteckigen Teil. Der Halbkreis als oberer Abschluss addiert noch die halbe Fensterbreite zu der GesamtFensterhoehe.)                         
    #declare FensterBasisHoehe = 1.0;   //*FensterBasisHohe (Abstand von der Basisoberkante bis zur Fensterbank)
    #declare FensterAbstand = 0.8;      //*FensterAbstand (Breite des Wandstuecks zwischen zwei Fenstern)
    #declare FensterSprAnz = 2;         // FensterSprAnz (ein boolscher Wert, der bestimmt, ob die Fenster eher viele (1) oder weinige Sprossen (2) haben)
    #declare FensterShape = 2;          //*FensterShape (ein boolscher Wert, der bestimmt, ob das Fenster rechtecking (1) oder gewoelbt ist (2))
    #declare FensterStil = 1;           //*FensterStil (ein boolscher Wert, der bestimmt, ob das Fenster dekorative Elemente (nach freier Wahl) (1) hat oder nicht (2))
 
    #declare TuerStil = 2;              // TuerStil (ein boolscher Wert, der bestimmt, ob die Tuer rechtecking (true) oder gewoelbt (false) ist)
    #declare TuerBreite = 1.2;          // TuerBreite
    #declare TuerHoehe = 2.5;           // nur vom rechteckigen Teil, falls die Tuer gewoelbt ist 
    #declare TuerMauerAbstand = TuerBreite / 2.0;        // Abstand von der Mauer zur Tuer
    
    #declare DekorUeberstand = 0.25;
    #declare DekorHoehe = 2.00;
    #declare DekorStaerke = 0.05;
    #declare DekorEinschnitt = 1.25; 
    
    #declare Hx = HausSX - HausSX/2.0;  // Absolute Eckwerte des Hauses für X
    #declare Hy = 0.0;                  // Absolute Eckwerte des Hauses für Y
    #declare Hz = HausSZ - HausSZ/2.0;  // Absolute Eckwerte des Hauses für Z

#end

