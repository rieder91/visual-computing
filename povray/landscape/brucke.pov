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

    // Angabe aus dem Web
    #declare k = 11;
    #declare d = 4;
    
    // Verschieben und Rotieren
    #declare B = <B.x - A.x, 0, B.z - A.z>; 
    #declare alph = VAngleD(<1, 0, 0>, B);
    #declare s = sqrt(B.x * B.x + B.z * B.z);
    
    #declare aSize = s / (2*(k+2));

    // TODO: Berechne die Koordinaten von B nach der Transformation und speichere sie in P.
    // Hint: Es ist der projizierte Abstand zwischen A und B (finde heraus in welcher Ebene!) zu nutzen.
    #local P = <s, 0>;
    
    union {
        difference {
            // Brücke selbst
            union {
                
                // Brückenkörper
                object {
                    DreiPunkteZylinder(h, P, bridgeWidth, 0)
                    
                    #declare circle = <result_DreiPunkteZylinder_px, result_DreiPunkteZylinder_py>;
                    #declare circleR = result_DreiPunkteZylinder_r;
                                        
                    texture {
                        TT_Bridge_Sides
                        scale <0.4, 0.4, 0.4>
                    }
                                
                }
                                
                // Geländer
                difference {
                    DreiPunkteZylinder(h, P, bridgeWidth, 0)
                    DreiPunkteZylinder(h, P, innerWidth, innerHeight)
                    DreiPunkteZylinder(h, P, bridgeWidth + innerHeight, -1)
                
                    translate <0, innerHeight, 0>
                
                    texture { 
                        TT_Bridge 
                        scale <0.4, 0.4, 0.4>
                        rotate <90, 90, 0>
                    }
                }
                                
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
                }
                
                // Markierungen
                union {
                    // Punkt A
                    cylinder {<0, 0, bridgeWidth/4> <0, 10, bridgeWidth/4> 0.3}        
                    cylinder {<0, 0, -bridgeWidth/4> <0, 10, -bridgeWidth/4> 0.3}
                    
                    
                    lineArcIntersection(s/2, circle, circleR);
                    
                    // Scheitel
                    cylinder {<s/2, result_lineArcIntersection, bridgeWidth/4> <s/2, result_lineArcIntersection + 10, bridgeWidth/4> 0.3}
                    cylinder {<s/2, result_lineArcIntersection, -bridgeWidth/4> <s/2, result_lineArcIntersection + 10, -bridgeWidth/4> 0.3}
                    
                    // Punkt B
                    cylinder {<s, 0, bridgeWidth/4> <s, 10 , bridgeWidth/4> 0.3}
                    cylinder {<s, 0, -bridgeWidth/4> <s, 10 , -bridgeWidth/4> 0.3}
                    
                    texture { TT_Decor }  
                }
            }
        
            // Arkaden abziehen                
            #declare i = 0;
            #declare pos = 0;
            
            #while (i < 2 * (k + 2))
                #if (mod(i, 2) = 0 & i != 0)
                    // Schnittpunkt bestimmen
                    lineArcIntersection(pos, circle, circleR);
                    
                    // Rausschneiden
                    box {<pos - aSize/2, result_lineArcIntersection - d - aSize/2, -bridgeWidth> <pos + aSize/2, -2 * circleR, bridgeWidth>}
                    
                    // Abrunden
                    cylinder {<pos, result_lineArcIntersection - d - aSize/2, bridgeWidth> <pos, result_lineArcIntersection - d - aSize/2, -bridgeWidth> aSize/2}
                #end
                
                #declare i = i + 1;
                #declare pos = pos + aSize;
            #end
        }

    // Zurückverschieben/-rotieren; Richtung hängt davon ab, welcher Punkt die größere Z-Koordinate hat
    #if (B.z < 0)
        rotate<0, alph, 0>
    #else
        rotate<0, -alph, 0>
    #end
    translate<A.x, 0, A.z>   
    }
    
#end

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
    // in die Kreisgleicung eingesetzt
    #declare result_lineArcIntersection = cM.y + sqrt(cR * cR - (px - cM.x) * (px - cM.x))
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
    
    // Punkt A
    location <455, 15, 75>
    look_at <450, 0, 75>
    
    // Punkt B
    location <340, 20 , -38.231>
    look_at <373.43,0 , -38.231>
    
    // Seitenansicht
    location<310, 0, 35>
    look_at <411, 0, 18>
}

light_source {<450 100, 95> color White }
light_source { <350, 20, -100> color White }
light_source { <0, 0, -1> color Gray50 }
light_source { <0, 0, 1> color Gray20 }
    
    // Angaben aus dem Web
    #declare PP0 = <450, 0, 75>;
    #declare PP1 = <373.43,0 , -38.231>;
    #declare h = 5.468;
    
    sphere {PP0 4 pigment {Blue}}
    sphere {PP1 4 pigment {Red}}

    object {Brucke(PP0, h, PP1, 8, 6, 1) pigment {White}}    

#end

// Ursprüngliche Angabe
/*
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
    #declare PP1 = <40, 0, 0>;
    #declare h = 5;
    object {Brucke(PP0, h, PP1, 8, 6, 1)} 
        
    #declare PP0 = <-40, 0, 0>;
    #declare PP1 = <40, 0, 0>;
    
    sphere {PP0 2 pigment {Red}} // markiert Punkt A
    sphere {PP1 2 pigment {Red}} // markiert Punkt B


#end
*/