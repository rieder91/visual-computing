#include "colors.inc" //Farben
#declare SCHACHBRETT = true; //die lokalen Kameras werden ignoriert

#include "chess.inc" //Materialien

camera
{
    location <6, 2.5, -6>
    look_at <0, 0.5, 0>
}

light_source { <0, 400, -200> color White }
light_source { <300, 2, -200> color Gray80 }
light_source { <-30, 8, -20> color Gray25 }

box
{
    <-4, -0.05, -4>
    <4, 0, 4>
    texture
    {
        BoardTopTexture
    }
}

#include "aufstellung.inc" //Aufstellung der Figuren wird eingelesen
