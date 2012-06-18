#include "colors.inc"
#include "stones.inc"
#include "woods.inc"

#declare tex_HofText=
texture {
   T_Grnt1
   normal{
     granite 0.7
     turbulence 0.2
     scale 1.2
     accuracy 0.1
  }
  finish { specular .5 reflection .5 }
}
                     
#declare tex_HouseBrick=
 texture{
   pigment{
     brick color rgb <0.937, 0.965, 0.902>, color rgb <0.902, 0.812, 0.714>
     scale 0.1
   }
   normal{
     brick// 0.6
     scale 0.1
   }
   finish{phong 0.8 phong_size 200}
 }
  
#declare tex_HousePlaster=
texture {
    //pigment { color rgb <0.98, 1.00, 0.90> }
    pigment{ 
        crackle
        metric 2
        color_map{
            [ 0.0 color rgb<1.0, 0.80, 0.7> ]
            [ 0.1 color rgb<1.0, 0.90, 0.8> ]
            [ 0.4 color rgb<1.0, 0.95, 0.9> ]
            [ 1.0 color rgb<1.0, 1.00, 1.0> ]
        }
        warp { turbulence 0.6 }
        scale 1
        rotate <0, 0, 90>
    }
    normal {
      granite 0.7
      turbulence 0.2
      scale 0.2
      accuracy 0.1
    }
    finish { diffuse 0.65 ambient 0.015 }
  }
  
 
#declare tex_RoofTiles=
texture{
   pigment {
        crackle
        colour_map {
            [0.05 colour rgb<0.667, 0.502, 0.478> ]
            [0.08 colour rgb<0.804, 0.569, 0.494> ]
            [0.10 colour rgb<0.816, 0.725, 0.537> ]
            [1.00 colour rgb<0.820, 0.580, 0.522> ]
        }
        scale 0.5
    }
    normal{
        crackle
        scale 0.5
    }
    finish{phong 0.8 phong_size 200}
}