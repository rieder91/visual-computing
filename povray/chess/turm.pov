#declare FIGUR = true; //Die lokalen Kameras werden ignoriert.
#include "korper.pov"
#macro Turm(KopfMax)
union
{  
    #declare h0 = 0.218;
    #declare h1 = 0.698;
    #declare h2 = 0.345;
    
    #declare r0 = 0.794 / 2.0;
    #declare r1 = 0.464 / 2.0;
    #declare r2 = 0.400 / 2.0;
    #declare r3 = 0.588 / 2.0;
    
    
    Korper(r0, r1, r2, r3, h0, h1, h2, false)
    
    // Kopf
    difference {
        // Gesamter Kopf
        cylinder {
                <0, h0 + h1, 0>
                <0, h0 + h1 + h2>
                r3
        }
        
        // was abgezogen wird
        union { 
                // obere Haelfte des Kopfes
                cylinder {
                        <0, h0 + h1 + h2 / 2.0, 0>
                        <0, h0 + h1 + h2, 0>
                        r2 
                }
                
                // Zinnen
                #declare n = 0;
                #declare box_width = pi * r3 / KopfMax;
                #while (n < KopfMax)
                        box {
                                <0, 0, -box_width / 2.0>
                                <r3 * 2.0, h2 / 2.0 + 0.001, box_width / 2.0>    // ohne das 0.001 hat man Fehler beim Rendern (Problem vom Renderer selbst?)
                                translate <0, h0 + h1 + h2 / 2.0, 0>
                                rotate <0, n * 360 / KopfMax, 0>
                        }
                        #declare n = n + 1;
                #end
        }
    }   
}
#end

//////////////////////////////////////////////////////////////////////////////
//Detailansicht dieser Figur. Deaktiviert, wenn aus chessboard.pov aufgerufen.
//////////////////////////////////////////////////////////////////////////////
#ifndef (SCHACHBRETT)
#include "colors.inc"
camera
{
    orthographic
    location <0, 1.175, -2.7>
    look_at <0, 1.175, 0>
}

light_source { <10, 30, -20> color White }
light_source { <0, 0.2, -5> color Gray50 }
light_source { <-30, 0, -10> color Gray20 }

object {Turm(10) pigment {color White}}
#end
