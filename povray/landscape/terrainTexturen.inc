#include "colors.inc"

#declare texWater = texture
{
    pigment {rgb <0.2, 0.2, 0.4 >}
    normal
    {
        crackle 0.15 
        scale 0.75
        turbulence 1.3
        translate <-1,0,5>
    }
    finish
    {
         ambient 0.15
         diffuse 0.75
         brilliance 6.0
         phong 0.8
         phong_size 120
         reflection 0.6
    }
}                  

#declare HFTex = texture{
                   pigment{
                     gradient y
                     color_map{  
                       [0 color Yellow]
                       [0.1 color Green]  
                       [0.35 color Gray]
                       [0.5 rgb 1]
                       [0.6 rgb 1]
                     }
                   }
                 }  
    

#declare texClouds = texture{
  pigment{
    bozo
    turbulence .6  octaves 19 omega 0.7 lambda 2
    color_map {
      [0   rgb <0.5,0.5,0.5> ]
      [0.3 rgb <0.9,0.9,0.9> ]
      [0.5 rgbt <1,1,1,1>    ]                      
      [1   rgbt <1,1,1,1>    ]                      
    }
    scale 528      
  }
  finish {ambient 1 diffuse 0}  
} 


#declare TT_Sand = texture
{
    pigment { color rgb < 1, 0.9, 0.65> }
    normal { granite 0.2 scale 0.02 }
    normal { bumps 0.4 scale 4 }
 
    finish
    {
        brilliance 1.6
        specular 0.3
        ambient 0.05
    }
}                
                     
#include "functions.inc"
#include "grasstex.inc"                          
#declare GrassNormal = normal {bumps 0.7 scale 20 turbulence 2}

#ifdef (TERRAIN) 
// Grass Tex Settings
// *********************************************************

#ifndef (scaleSize)
    #local scaleSize = 10;
#end
#ifndef (heightScale)
    #local heightScale = 10;
#end    
   
   #declare gt_scale   = 1/scaleSize;
   #declare gt_height  = 1/heightScale;
   #declare gt_turb    = 0.6;
   #declare gt_samples = 40;
   #declare gt_tweak   = 0.025;
                                 
#ifndef (PathFunction)
// A pattern function used for the path in the scene.
   #declare PathFunction =
   function {
      pattern {
         planar scale 1.4 rotate 90*z turbulence 0.3
         rotate 20*y translate <15,2.5,15>
      }
   }
#end                                 

#ifndef (gt_densitymap)
// The function that is used as grass map.
// It's the path function multiplied with a f_noise3d function.
#declare gt_densitymap =
    function(x,y,z)
    {
       (0.1+f_noise3d(x/5,y/5+3.6,z/5))
      *(1-1.2*PathFunction(x,y,z))
    }
#end
   
// The function used as height map for the grass.
// The function used here is constant.
#ifndef(gt_heightmap)
#declare gt_heightmap  = function(x,y,z) {1}    
#end
        
#declare TT_Ground = 
        
//    The very first layer should be the ground layer.
//    The color map controls the colors according to the density map:
    texture
    {
        #declare gt_groundcolors =
        color_map
        {
            [0.0, color <0.70,0.55,0.40>]
            [0.5, color <0.50,0.40,0.30>]
            [1.0, color <0.30,0.25,0.20>]
        }
        gt_ground()
        normal {wrinkles 0.5 scale 1*gt_scale turbulence 1}
    }

#declare TT_Grass = 
//    On top of that is a grass tex layer:
    texture
    {
        #declare gt_color   = <0.15,0.60,0.00>;
        #declare gt_offset  = -0.00;
        #declare gt_seed    = 0;
        gt_grass()
        normal {GrassNormal scale gt_scale}
    }         
    
#declare TT_GroundGrass = 
texture {TT_Ground}
texture {TT_Grass}

                
#declare TT_Terrain = texture
{
    gradient y
    scale heightScale
    texture_map
    {
        [-1 TT_Sand]
        [0.00001 TT_Sand]
        [0.00007 TT_Ground]
        [0.00225 TT_GroundGrass]
        [1 TT_GroundGrass]
    }        
}

#end