#declare FIGUR = true; //Die lokalen Kameras werden ignoriert.
#include "korper.pov"
#declare Konig = union
{  
    #declare h0 = 0.266;
    #declare h1 = 0.815;
    #declare h2 = 0.267;
    #declare h3 = 0.690;
    
    #declare h_prism = h3 * 0.25;
    
    #declare r0 = 0.938 / 2.0;
    #declare r1 = 0.608 / 2.0;
    #declare r2 = 0.480 / 2.0;
    #declare r3 = 0.668 / 2.0;
    
    #declare r_crown = 0.61 / 2.0;
    #declare r_prism = r_crown * 0.20;
    
    Korper(r0, r1, r2, r3, h0, h1, h2, true)
    
    // Hut
    cone {
        <0, h0 + h1 + h2 - 0.05, 0>, r_crown * 0.7
        <0, h0 + h1 + h2 + h3 * 0.70>, r_crown
    }
    
    // Podest fuer das Kreuz
    cylinder {
        <0, h0 + h1 + h2 + h3 * 0.70, 0>
        <0, h0 + h1 + h2 + h3 * 0.75, 0>
        r_prism 
    }
    
    // Kreuz
    prism {
        0.0, r_prism / 2.0, 15
        
        <0, 0>
        
        <r_prism, h_prism * 0.1>
        <r_prism * 0.2, h_prism * 0.40>
        <r_prism, h_prism * 0.3>
        <r_prism, h_prism * 0.7>
        <r_prism * 0.2, h_prism * 0.60>
        <r_prism, h_prism * 0.9>
        
        <0, h_prism>
        
        <r_prism * -1.0, h_prism * 0.9>
        <r_prism * -0.2, h_prism * 0.60>
        <r_prism * -1.0, h_prism * 0.7>
        <r_prism * -1.0, h_prism * 0.3>
        <r_prism * -0.2, h_prism * 0.40>
        <r_prism * -1.0, h_prism * 0.1>
        
        <0, 0>
          
        rotate<-90, 0, 0>
        translate<0, h0 + h1 + h2 + h3 * 0.75, 0>    
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

object {Konig  pigment {color White}}
#end
