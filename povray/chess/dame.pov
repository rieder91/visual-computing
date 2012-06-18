#declare FIGUR = true; //Die lokalen Kameras werden ignoriert.
#include "korper.pov"
#macro Dame(KroneMax)
union
{
    #declare h0 = 0.254;
    #declare h1 = 0.708;
    #declare h2 = 0.239;
    #declare h3 = 0.586;
    
    #declare r0 = 0.902 / 2.0;
    #declare r1 = 0.572 / 2.0;
    #declare r2 = 0.460 / 2.0;
    #declare r3 = 0.643 / 2.0;
    
    #declare h_cone = h3 * 0.7;
    #declare r_topCone = r3 * 1.2;
    #declare r_bottomCone = r3 * 0.5;
    #declare r_holes = r_topCone * pi * 1.1 / KroneMax;
    
    Korper(r0, r1, r2, r3, h0, h1, h2, true)
    
    difference {
        cone {
                <0, h0 + h1 + h2 - 0.05, 0>, r_bottomCone
                <0, h0 + h1 + h2 + h_cone, 0>,  r_topCone
        }
        
        #declare n = 0;
        #while (n < KroneMax)
                sphere{
                        <r_topCone * 0.90, h0 + h1 + h2 + h_cone, 0>, r_holes
                        rotate<0, n * 360 / KroneMax, 0>
                }
                #declare n = n + 1;
        #end
        
        // Kugel die herausgeschnitten wird
        sphere {
           <0, h0 + h1 + h2 + h3 * 0.85 + h3 * 0.15 / 2, 0>, h3 / 2.0     
        }
    }
    
    // innere Kugel
    sphere {
        <0, h0 + h1 + h2 + h3 * 0.85 / 2, 0>, h3 * 0.85 / 2 
    }
    
    // oberste Kugel
    sphere {
        <0, h0 + h1 + h2 + h3 * 0.85 + h3 * 0.15 / 2, 0>, h3 * 0.15 / 2
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

object {Dame(12) pigment {color White}}
#end
