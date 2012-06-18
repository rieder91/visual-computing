#include "math.inc"
#include "zylinder.mac"
#include "bruckeTexturen.inc"
#include "math.inc"

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
//union {
    // TODO: Verschiebe und drehe die Bruecke, so dass sich A in Koordinatenursprung befindet und B in der xy-Halbebene, wo x>=0, liegt.
    //       Nicht vergessen: das erstellte Modell ist am Ende zurueckzutransformieren.
    
    #declare aNote = A;
    #declare bNote = B;
  
    #declare B = <B.x - A.x, 0, B.z-A.z>; 
    #declare alph = VAngleD(<1, 0, 0>, B);
    #declare BN = <B.x * cos(alph) + B.z*sin(alph), -B.z*sin(alph) + B.z*cos(alph), 0>;
    
   
    // TODO: Berechne die Koordinaten von B nach der Transformation und speichere sie in P.
    // Hint: Es ist der projizierte Abstand zwischen A und B (finde heraus in welcher Ebene!) zu nutzen.
    #local P = <BN.x, BN.z>;
    

    // TODO: Baue den Brueckenkoerper auf. Dazu sollte das DreiPunkteZylinder
    //       Makro zur Berechnung von der Mitte und dem Radius aufgerufen werden, zur mehrfachen 
    //       Zeichnung verwende das zeichneZylinder Makro. Benutze die oben berechnete
    //       Variable P und den Inputparameter h. Die Ergebnisse aus dem Aufruf
    //       werden ueber folgende global deklarierte Variablen erreichbar sein:
    //       result_DreiPunkteZylinder_px
    //       result_DreiPunkteZylinder_py
    //       result_DreiPunkteZylinder_r
    union {
      
        cylinder {aNote <aNote.x, 6, aNote.z> 0.5 texture {TT_Decor}} // markiert Punkt A
        cylinder {bNote <bNote.x, 6, bNote.z> 0.5 texture {TT_Decor}} // markiert Punkt A
             
    
        
        // Gehweg
        difference {
             DreiPunkteZylinder(h, P, bridgeWidth - 0.001, 0.001)
             DreiPunkteZylinder(h, P, bridgeWidth, 0)

             texture { 
                        TT_Bridge 
                        translate<100000, 0>
                        rotate<0, 90, 90>
                        scale<0.4, 0.4, 0.4>
                        
             }    
             
             rotate<0, VAngleD(<1, 0, 0>, B), 0>
             translate<A.x, 0, A.z>

        } 
       
        
        // Unterer Teil
        object {
                object {
                       
                                DreiPunkteZylinder(h, P, bridgeWidth, -0.001)
                                // TODO Arkaden abziehen
                        
                }
           
                texture {
                        TT_Bridge_Sides
                        scale <0.4, 0.4, 0.4>
                }
                 
                rotate<0, VAngleD(<1, 0, 0>, B), 0>
                translate<A.x, 0, A.z>    
                
        }
        
        
        
        // Geländer
        difference {
                DreiPunkteZylinder(h, P, bridgeWidth, innerHeight)
                DreiPunkteZylinder(h, P, innerWidth, innerHeight + 1)
                DreiPunkteZylinder(h, P, bridgeWidth + 0.001, 0)
                
                texture { 
                        TT_Bridge 
                        scale <0.4, 0.4, 0.4>
                        rotate <90, 90, 0>
                }
                
                rotate<0, VAngleD(<1, 0, 0>, B), 0>
                translate<A.x, 0, A.z>
        }
       
 
    }
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
    orthographic
    location <455, 10, 75>
    look_at <450, 0, 75>
}
light_source {<450 100, 95> color White }
light_source { <350, 20, -100> color White }
light_source { <0, 0, -1> color Gray50 }
light_source { <0, 0, 1> color Gray20 }
    
    // Angaben aus dem Web
    #declare PP0 = <450, 0, 75>;
    #declare PP1 = <373.43,0 , -38.231>;
    #declare h = 5.468;
  

   // sphere {PP0 5 pigment {Blue}} // markiert Punkt A
   // sphere {PP1 5 pigment {Red}} // markiert Punkt B
  

    object {Brucke(PP0, h, PP1, 8, 6, 1) pigment {White}}    
     

#end