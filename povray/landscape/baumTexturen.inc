#include "textures.inc"

#declare TransparentTex = texture
{
    pigment {color rgbt <1,1,1,1>}
}    
           
            
#macro FichteTex(r, g, b, RND)
    #local th = 0.2 + rand(RND) * 0.3;
    
    #local NadelnPigment = pigment
    {
        brick 
        color rgbt<0.1, 0.2, 0.1, 0.15 > // mortar
        color rgbt<r, g, b, 0> // brick 
        brick_size <0.0033, 0.05, 0.01>        
        mortar 0.0033  
    }
    
    #local NadelnNormal = normal
    {
        uv_mapping
        brick  
        brick_size <0.0033, 0.05, 0.01>
        mortar 0.0033  
    }  
    
    #local NadelnTexP = texture
    {
        uv_mapping
        pigment { NadelnPigment }
        normal { NadelnNormal }
        rotate <0,0,45>
        finish { specular 0.4 phong_size 300 }
    };
    
    #local NadelnTexN = texture
    {
        uv_mapping
        pigment { NadelnPigment }
        normal { NadelnNormal }
        rotate <0,0,-45>
        finish { specular 0.4 phong_size 300 }
    };

    texture
    {
        radial frequency 8 + floor(rand(RND) * 7)
        texture_map
        {
            [th TransparentTex]
            [th NadelnTexP]
            [th + 0.5*(1-th) NadelnTexP]
            [th + 0.5*(1-th) NadelnTexN]        
    }    
}
#end