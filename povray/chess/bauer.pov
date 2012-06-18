#declare FIGUR = true; //Die lokalen Kameras werden ignoriert.
#include "korper.pov"
#declare Bauer = union
{   

    #declare h0 = 0.206;
    #declare h1 = 0.47;
    #declare h2 = 0.107;
    
    #declare r0 = 0.758 / 2.0;
    #declare r1 = 0.428 / 2.0;
    #declare r2 = 0.38 / 2.0  ;
    #declare r3 = 0.421 / 2.0  ;
    #declare rUnten = r1 * 1.2 ;
    #declare rOben =  r2 * 0.7 ;
    
    Korper(r0, r1, r2, r3, h0, h1, h2, false)
    
    cone {
        <0.0, h0 + h1,      0.0>, rUnten, 
        <0.0, h0 + h1 + h2, 0.0>, rOben
    }

    sphere {
        <0.0, h0 + h1 + h2 + sqrt(r3 * r3 - rOben * rOben), 0.0>, r3
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

object {Bauer  pigment {color White}}
#end
