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
    //pigment { White }
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
plane{
        <0, 1, 0>, 2
        translate <0, -1.99, 0>
        texture {texWater scale 20 }
}


#include "brucke.pov"

object {
        Brucke(<450, 0, 75>, 5.468, <373.43, 0, -38.231>, 8, 6, 1)
        translate <0, 7, 0>
}

#include "vegetation.inc"

#include "haus.pov"
union {
    object { 
        Haus(7, 6, 2, 1) 
        translate <0,0,0> 
    }
    
    object { 
        Haus(6, 5, 1, 1) 
        translate <15,0,0> 
    }
    
    object { 
        Haus(7, 7, 2, 1) 
        translate <30,0,0> 
    }
    
    object { 
        Haus(5, 5, 2, 1) 
        translate <30,0,15> 
    }
    
    object { 
        Haus(5, 5, 1, 0) 
        translate <15,0,15> 
    }
    
    object { 
        Haus(4, 4, 2, 1) 
        translate <0,0,15> 
    }
    
    object { 
        Haus(9, 4, 2, 1) 
        rotate <0, 0, 1>
        translate <32,1,30> 
    }
    
    object { 
        Haus(8, 5, 1, 1) 
        translate <15,0,30> 
    }
    
    object { 
        Haus(4, 4, 2, 0) 
        
        translate <0,0,30> 
    }
    
    object { 
        Haus(35, 20, 2, 1) 
        rotate<-5, -45, 0>
        translate <-50,2,60> 
    }
    
    rotate <0, 38, 0>
    translate <468, 1, 72>
    
}
