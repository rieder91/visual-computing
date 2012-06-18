#include "colors.inc"
#include "stones.inc"

#declare TT_Bridge = texture
{
     pigment
     {
         brick
         color <0.7, 0.7, 0.7>  //mortar
         color rgb<0.4,0.4,0.4> //brick         
         brick_size <0.75, 0.4, 0.5>        
         mortar 0.04 // size of the mortar 
         scale <0.001, 1.5, 4>
         warp
         {
             cylindrical
             orientation <0, 1, 0>
             dist_exp 0 // radial
         }
          
     }
     normal { wrinkles 0.9 scale 0.01}     
     finish { diffuse 0.7 phong 0}
}

#declare TT_Bridge_Sides = texture
{
     pigment
     {
         brick
         color <0.7, 0.7, 0.7>  //mortar
         color rgb<0.4,0.4,0.4> //brick         
         brick_size <0.75, 0.4, 0.5>        
         mortar 0.04 // size of the mortar  

     }
     normal { wrinkles 0.9 scale 0.01}     
     finish { diffuse 0.7 phong 0}
     scale 2
}      

#declare TT_Decor = texture
{
     pigment
     {
         color rgb<0.4,0.4,0.4>
     }
     normal { wrinkles 0.9 scale 0.01}     
     finish { diffuse 0.7 phong 0}
}