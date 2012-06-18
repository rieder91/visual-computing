#declare TERRAIN = true;

#include "colors.inc"
#include "textures.inc"

global_settings { noise_generator 3 }
global_settings { assumed_gamma 1.6 }

//Die Grass Textur erfordert, dass die Position der Kamera in camera_location gespeichert ist
#declare camera_location = <468.75, 30, 6.25>;
camera
{
    location camera_location
    look_at <468.75, -0, 106.25>
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

//TODO erzeuge die Wasseroberflaeche mit einem plane Objekt. Verwende dafuer die texWater Textur.

//TODO Um den Wald einzufuegen, inkludiere das richtige .inc File.

#include "brucke.pov"
//TODO Erstelel die Brucke. Implementiere und rufe das Brucke Makro auf. Die Werte der Parameter findest du im Abgabesystem.#include "haus.pov"
//TODO Platziere 10 verschiedene Haeuser mit dem Haus Makro.

