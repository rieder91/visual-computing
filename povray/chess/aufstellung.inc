#include "bauer.pov"
#include "turm.pov"
#include "springer.pov"
#include "laufer.pov"
#include "dame.pov"
#include "konig.pov"


//AUFSTELLUNG.INC ist nur ein Include, der nicht alleine ausfuehrbar ist! Bitte stattdessen chessboard.pov zeichnen lassen.

#declare size_v = 8.0;
#declare offset_v = size_v / 8.0;
#declare offset_center = offset_v / 2.0;
#declare start = -size_v / 2.0 - offset_center;
#declare white = 90;
#declare black = -90;
 
 

//Weiss hinten
object {Turm(6)  rotate <0, white, 0> translate<start + offset_v,     0, start + size_v> texture {WhiteTexture}} 
object {Springer rotate <0, white, 0> translate<start + offset_v * 2, 0, start + size_v> texture {WhiteTexture}}  
object {Laufer   rotate <0, white, 0> translate<start + offset_v * 3, 0, start + size_v> texture {WhiteTexture}}                                                                                                
object {Konig    rotate <0, 0,     0> translate<start + offset_v * 4, 0, start + size_v> texture {WhiteTexture}}                                                                                                
object {Dame(12) rotate <0, white, 0> translate<start + offset_v * 5, 0, start + size_v> texture {WhiteTexture}}                                                                                                
object {Laufer   rotate <0, white, 0> translate<start + offset_v * 6, 0, start + size_v> texture {WhiteTexture}}    
object {Springer rotate <0, white, 0> translate<start + offset_v * 7, 0, start + size_v> texture {WhiteTexture}}     
object {Turm(6)  rotate <0, white, 0> translate<start + offset_v * 8, 0, start + size_v> texture {WhiteTexture}}                                                                                                

                                   
//Schwarz hinten
object {Turm(6)  rotate <0, black, 0> translate<start + offset_v    , 0, start + offset_v> texture {BlackTexture}} 
object {Springer rotate <0, black, 0> translate<start + offset_v * 2, 0, start + offset_v> texture {BlackTexture}}  
object {Laufer   rotate <0, black, 0> translate<start + offset_v * 3, 0, start + offset_v> texture {BlackTexture}}                                                                                                
object {Konig    rotate <0, 0,     0> translate<start + offset_v * 4, 0, start + offset_v> texture {BlackTexture}}                                                                                                
object {Dame(12) rotate <0, black, 0> translate<start + offset_v * 5, 0, start + offset_v> texture {BlackTexture}}                                                                                                
object {Laufer   rotate <0, black, 0> translate<start + offset_v * 6, 0, start + offset_v> texture {BlackTexture}}    
object {Springer rotate <0, black, 0> translate<start + offset_v * 7, 0, start + offset_v> texture {BlackTexture}}     
object {Turm(6)  rotate <0, black, 0> translate<start + offset_v * 8, 0, start + offset_v> texture {BlackTexture}}                                       


// Bauern
#declare bauern_cnt = 8;
#while (bauern_cnt > 0)
        object {Bauer rotate <0, white, 0> translate<start + offset_v * bauern_cnt, 0, start + offset_v * 7> texture {WhiteTexture}}
        object {Bauer rotate <0, black, 0> translate<start + offset_v * bauern_cnt, 0, start + offset_v * 2> texture {BlackTexture}}
        #declare bauern_cnt = bauern_cnt - 1;        
#end
