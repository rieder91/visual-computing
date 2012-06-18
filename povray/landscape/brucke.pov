#include "math.inc"
#include "zylinder.mac"
#include "bruckeTexturen.inc"

#macro Brucke(A, h, B, bridgeWidth, innerWidth, innerHeight)
//INPUT:
//       A und B entsprechen den Punkten in der Web-Angabe
//       h entspricht der maximalen Hoehe der Bruecke ueber der Linie, die A mit B verbindet
//       bridgeWidth ... aeussere Breite der Bruecke
//       innerWidth ... Breite der strasse auf der Bruecke
//       innerHeight ... Hoehe des Randes der Bruecke

// WICHTIG: Die zu verwendende Texturen befinden sich in der Datei
//          "bruckeTexturen.inc".
//          Fuer den begehbaren Teil der Bruecke ist die Textur TT_Bridge,
//          fuer die Brueckenseiten -  die Textur TT_Bridge_Sides und
//          fuer die Marker - die Textur TT_Decor zu nehmen.

    // TODO: Verschiebe und drehe die Bruecke, so dass sich A in Koordinatenursprung befindet und B in der xy-Halbebene, wo x>=0, liegt.
    //       Nicht vergessen: das erstellte Modell ist am Ende zurueckzutransformieren.

    // TODO: Berechne die Koordinaten von B nach der Transformation und speichere sie in P.
    // Hint: Es ist der projizierte Abstand zwischen A und B (finde heraus in welcher Ebene!) zu nutzen.
    #local P = <0, 0>;

    // TODO: Baue den Brueckenkoerper auf. Dazu sollte das DreiPunkteZylinder
    //       Makro zur Berechnung von der Mitte und dem Radius aufgerufen werden, zur mehrfachen 
    //       Zeichnung verwende das zeichneZylinder Makro. Benutze die oben berechnete
    //       Variable P und den Inputparameter h. Die Ergebnisse aus dem Aufruf
    //       werden ueber folgende global deklarierte Variablen erreichbar sein:
    //       result_DreiPunkteZylinder_px
    //       result_DreiPunkteZylinder_py
    //       result_DreiPunkteZylinder_r

    // TODO: Schneide die Arkaden aus dem Brueckenkoerper aus.
    //       Benutze das weiter unten definierte Makro lineArcIntersection,
    //       um die Reichweite der Arkaden zu berechnen. An Stelle der 
    //       ersten und letzten soll nichts ausgeschnitten werden, deshalb 
    //       rechne mit 2 zusaetzlichen (fiktiven) Arkaden bei der Verteilung.

    // TODO: Zeichne die Bruecke. Markiere die Punkte A, B und
    //       den Punkt, der am hoechsten ueber der Gerade liegt,
    //       die A mit B verbindet, mit kleinen Saeulen, Lampen
    //       oder anderen zur Bruecke passenden Objekten nach eigener Wahl.
#end

// TODO: Hier sind andere notwendigen Makros zu definieren.

// Dises Makro berechnet den Schnittpunkt zwischen einem Bogen
// und einer vertikalen Geraden in 2D, die durch einen bestimmten
// Punkt laeuft.
#macro lineArcIntersection(px, cM, cR)
// INPUT 
//      px: ... die Gerade laeuft vertikal durch den Punkt (px,0)
//      cM: ... das Zentrum vom Bogen (Arkade)
//      cR: ... der Radius vom Bogen (Arkade)
// OUTPUT
//      result_lineArcIntersection ... die groessere y-Koordinate der (2) Schnittpunkte
//                                     der vertikalen Geraden durch (px,0) mit dem Bogen
#end

/////////////////////////////////////////////////////////////////////////
//Detailansicht der Bruecke. Deaktiviert, wenn aus Terrain.pov aufgerufen.
/////////////////////////////////////////////////////////////////////////

#ifndef (TERRAIN)
    #include "colors.inc"
    background { White } 
    camera
    {
        //orthographic
        location <-60, 20, -80>
        look_at <0, 0, 0>
    }

    light_source {<30, 100, 0> color Gray75 }
    light_source {<300, 10, -100> color Gray75 }
    light_source {<-30, 50, -30> color Gray75 }
    light_source {<-10, 40, -100> color Gray75 }
    light_source {<-10, 40, 100> color Gray75 }

    #declare PP0 = <-40, 0, 0>;
    #declare PP1 = <40, 15, 0>;
    #declare h = 5;
    object {Brucke(PP0, h, PP1, 8, 6, 1)} 

    sphere {PP0 2 pigment {Red}} // markiert Punkt A
    sphere {PP1 2 pigment {Red}} // markiert Punkt B
#end