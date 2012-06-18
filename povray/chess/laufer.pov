#declare FIGUR = true; //Die lokalen Kameras werden ignoriert.
#include "korper.pov"
#declare Laufer = union
{
    #declare h0 = 0.242;
    #declare h1 = 0.591;
    #declare h2 = 0.211;
    #declare h3 = 0.582;
    
    #declare r0 = 0.866 / 2.0;
    #declare r1 = 0.536 / 2.0;
    #declare r2 = 0.440 / 2.0;
    #declare r3 = 0.617 / 2.0;
    
    #declare r_small = h3 * 0.15 / 2;
    #declare r_big = h3 * 0.85 / 2;
    
    Korper(r0, r1, r2, r3, h0, h1, h2, true)
    
    difference {
        // Groﬂe Kugel
        sphere {
                <0, 0, 0>, r_big scale<1.0, 1.15, 1.0>
                translate <0, h0 + h1 + h2 + r_big - h2 * 0.1, 0>         
        }
        
        // Visier
        box {
                <-0.25, -0.05, -0.4>
                <0.25, 0.05, 0.4>
                rotate<0, 0, 45>
                translate<r_big, h0 + h1 + h2 + r_big * 1.3, 0>
        }
    
    }
    // kleine Kugel
    sphere {
        <0,h0 + h1 + h2 + 2 * 1.15 * r_big,0>, r3 * 0.2
    }
}

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

object {Laufer  pigment {color White}}
#end
