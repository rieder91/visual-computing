// *********************************************************
// Rune's Grass Tex v1.01 for POV-Ray 3.5
// *********************************************************
// 
// Copyright (C) 2002 Rune S. Johansen
// http://runevision.com
// 
// See "grasstex.html" for more information.
// 
// *********************************************************

/*
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
   
   #include "functions.inc"
   #include "strings.inc"
   
   #declare gt_height         = 1.00;
   #declare gt_turb           = 0.5;
   #declare gt_samples        = 20;
   #declare gt_tweak          = 0.00;
   #declare gt_seed           = 0;
   #declare gt_groundcolors   =
   color_map {
      [0.0, color <0.70,0.55,0.40>]
      [0.5, color <0.50,0.40,0.30>]
      [1.0, color <0.30,0.25,0.20>]
   }
   #declare gt_offset         = 0.00;
   #declare gt_color          = <0.40,0.80,0.20>;
   #declare gt_flowercolor    = <1.00,0.80,0.00>;
   
   #macro gt_check (Layer)
      #ifndef(camera_location)
         #error "No camera_location #declared!"
      #end
      #ifndef(gt_scale)
         #declare gt_scale_ = gt_height;
      #else
         #declare gt_scale_ = gt_scale;
      #end
      #ifndef(gt_densitymap)
         #declare gt_densitymap = function(x,y,z) {1}
      #end
      #if (Layer=2)
         #ifndef(gt_heightmap)
            #declare gt_heightmap = function(x,y,z) {1}
         #end
      #end
   #end
   
   #macro gt_ground ()
      gt_check(1)
      pigment {
         function {min(1,max(0,gt_densitymap(x,y,z)))}
         color_map {gt_groundcolors}
      }
   #end
   
   #macro gt_grass ()
      gt_check(2)
      pigment {
         #local Vx = camera_location.x;
         #local Vy = camera_location.y;
         #local Vz = camera_location.z;
         #local MyTurb =
         function (x,y,z,Xval,Yval,Zval,Level,Height,LTurb,Freq) {
            f_noise3d(
               5*Xval/gt_scale_ -(f_noise3d(Xval*Freq,0,Zval*Freq)*2-1)*LTurb,
               Yval,
               5*Zval/gt_scale_ -(f_noise3d(Xval*Freq,8,Zval*Freq)*2-1)*LTurb
            )
         }
         #local FunctionB =
         function(x,y,z,xz_len,xyz_len,Height,Turb){
            min(1,max(0,
               max(
               #declare C = 1;
               #declare Cm = gt_samples;
               #while (C<=Cm)
                  #declare Cv = C/Cm;
                  MyTurb(
                     x,y,z,
                     (x/xz_len*( (-C/Cm*Height-gt_offset) *xz_len/xyz_len +xz_len )+Vx),
                     gt_seed*8,
                     (z/xz_len*( (-C/Cm*Height-gt_offset) *xz_len/xyz_len +xz_len )+Vz),
                     Cv,
                     Height,
                     pow(Cv,2)*Height*Turb,
                     5/8/gt_scale_
                  )*(1.0-0.1*pow((C/Cm),2)),
                  #declare C = C+1;
               #end
               0)
               +gt_tweak
               -0.3 +0.3*pow(min(1,gt_densitymap(x+Vx,y+Vy,z+Vz)),0.3)
            ))
         }
         function {
            FunctionB(
               x,y,z,
               sqrt(x*x+z*z),
               sqrt(x*x+pow((y*3),2)+z*z)/3,
               gt_height*gt_heightmap(x+Vx,y+Vy,z+Vz),
               10/gt_scale_*gt_turb
            )
         }
         translate camera_location
         color_map {
            [0.70, transmit 1          ]
            [0.70, rgb gt_color*0.4    ]
            [0.80, rgb gt_color*1.0    ]
            [1.00, rgb gt_color*1.0+0.5]
         }
      }
   #end
   
   #macro gt_flowers ()
      gt_check(3)
      pigment {
         #local FPat = function{pattern{crackle form x}}
         function {
            min(1,max(0,
               1-FPat(x/gt_scale_*0.15,y/gt_scale_*0.15+gt_seed*8,z/gt_scale_*0.15)
               -0.3+0.3*min(1,gt_densitymap(x,y+gt_seed*8,z))
            ))
         }
         scale 30 warp {turbulence 1} scale 1/30
         translate 8*gt_seed*y
         color_map {
            [0.85-0.08, color transmit 1        ]
            [0.85-0.08, color gt_flowercolor*0.6]
            [0.90-0.08, color gt_flowercolor*0.9]
            [1.00-0.08, color gt_flowercolor*1.0]
         }
      }
   #end
   