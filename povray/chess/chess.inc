#include "textures.inc"

#declare WhiteTexture = 
texture {
    pigment { rgb <0.658824, 0.658824, 0.658824> }
    finish {
        ambient 0.3
        diffuse 0.7
        reflection 0.15
        brilliance 8
        specular 0.8
        roughness 0.1
    }
};               

#declare BlackTexture = 
texture {
    pigment { rgb <0.1, 0.09, 0.08> }
    finish {
        ambient 0.3
        diffuse 0.1
        reflection 0.1
        brilliance 8
        specular 0.7
        roughness 0.07
    }
};                          

#declare CheckerPigment = pigment
{
        checker 
        color rgbf <0, 0, 0, 0.1>, 
        color rgbf <0.98, 0.98, 0.98, 0.5>
        
        
        scale <1, -1, 1>
}

#declare BoardTopTexture = 
texture {
    //pigment { rgbf <0.98, 0.98, 0.98, 0.9> }
    pigment { CheckerPigment }
    finish  {
        ambient 0.3
        diffuse 1
        reflection 0.2
        specular 0.4
        roughness .01        
        phong 1
        phong_size 400 
        brilliance 2   
        ior 1.5
        }   
}