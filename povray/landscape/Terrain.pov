#declare TERRAIN = true;

#include "colors.inc"
#include "textures.inc"
#include "brucke.pov"                                
#include "haus.pov"
                                  
global_settings { noise_generator 3 }
global_settings { assumed_gamma 1.6 }
 
#declare sx0 = 20;
#declare sz0 = 20;
#declare style0 = 1;
#declare fence0 = 0;

#declare sx1 = 10;
#declare sz1 = 8;
#declare style1 = 1;
#declare fence1 = 1;
   
#declare sx2 = 10;
#declare sz2 = 8;
#declare style2 = 1;
#declare fence2 = 0;

#declare sx3 = 10;
#declare sz3 = 8;
#declare style3 = 0;
#declare fence3 = 1;

#declare sx4 = 10;
#declare sz4 = 8;
#declare style4 = 0;
#declare fence4 = 0;

#declare sx5 = 10;
#declare sz5 = 8;
#declare style5 = 1;
#declare fence5 = 1;      

#declare sx6 = 10;
#declare sz6 = 8;
#declare style6 = 1;
#declare fence6 = 0;      

#declare sx7 = 10;
#declare sz7 = 8;
#declare style7 = 0;
#declare fence7 = 1;

#declare sx8 = 10;
#declare sz8 = 8;
#declare style8 = 0;
#declare fence8 = 0;

#declare sx9 = 10;
#declare sz9 = 8;
#declare style9 = 1;
#declare fence9 = 1;
   
//Die Grass Textur erfordert, dass die Position der Kamera in camera_location gespeichert ist
//#declare camera_location = <468.75, 30, 6.25>; 
#declare camera_location = <150, 150, -150>;
camera
{
    location camera_location   
    //look_at <468.75, -0, 106.25>
    look_at <0, 100, 0>
}

//Ausmas vom Terrainblock
#declare scaleSize = 1600;
//Maximale moegliche Hoehe
#declare heightScale = scaleSize / 8;
//Wasserpegel
#declare waterLevel = heightScale * 0.0099;

light_source
{
    <300, heightScale * 2, -150>,
    color rgb <1, 1, 0.9>
    parallel
    point_at<0,0,0>
}

//Nachdem der Wasserpegel definiert ist, lassen sich hoehenabhaengige Texturen definieren
#include "terrainTexturen.inc"

fog
{
    color <0.9,1.0,1.0>
    fog_type 2
    distance scaleSize
    fog_offset 0
    fog_alt   20
}

//Die Landschaft
height_field
{
    png "height.png"
    smooth
    translate <-0.5, 0, -0.5>
    scale <scaleSize, heightScale, scaleSize>
    translate <0, -waterLevel, 0>
    texture {TT_Terrain}
}

//Der Himmel und die Wolken
sky_sphere{ pigment {color rgb<0.19, 0.3, 0.8>} }

plane
{
    y, 500
    hollow
    texture {texClouds scale 20 }
}        
                  
object{Haus(sx0, sz0, style0, fence0)  rotate <0,180,0>     translate <-150,60,-140>    rotate <0,45,0>}
object{Haus(sx1, sz1, style1, fence1)  rotate <0,180,0>     translate <-150,60,-100>    rotate <0,45,0>}
object{Haus(sx2, sz2, style2, fence2)  rotate <0,180,0>     translate <-150,60,-60>     rotate <0,45,0>}
object{Haus(sx3, sz3, style3, fence3)  rotate <0,180,0>     translate <-150,60,-20>     rotate <0,45,0>}
object{Haus(sx4, sz4, style4, fence4)  rotate <0,180,0>     translate <-150,60,20>      rotate <0,45,0>}
object{Haus(sx5, sz5, style5, fence5)  rotate <0,180,0>     translate <-150,30,-140>    rotate <0,45,0>}
object{Haus(sx6, sz6, style6, fence6)  rotate <0,180,0>     translate <-150,30,-100>    rotate <0,45,0>}
object{Haus(sx7, sz7, style7, fence7)  rotate <0,180,0>     translate <-150,30,-60>     rotate <0,45,0>}
object{Haus(sx8, sz8, style8, fence8)  rotate <0,180,0>     translate <-150,30,-20>     rotate <0,45,0>}
object{Haus(sx9, sz9, style9, fence9)  rotate <0,180,0>     translate <-150,30,20>      rotate <0,45,0>}

object{Brucke(<-50, 0, 337.5>, 5.448, <-14.109, 0, 206.108>, 8, 6, 1)     translate <-50,20,-360> rotate <0,-25,0>}
                   
//TODO erzeuge die Wasseroberflaeche mit einem plane Objekt. Verwende dafuer die texWater Textur.

plane
{
    <0, 1, 0>, 2
    texture {texWater scale 20 }
}    

//TODO Um den Wald einzufuegen, inkludiere das richtige .inc File.

             

//TODO Erstelel die Brucke. Implementiere und rufe das Brucke Makro auf. Die Werte der Parameter findest du im Abgabesystem.#include "haus.pov"
//TODO Platziere 10 verschiedene Haeuser mit dem Haus Makro.

