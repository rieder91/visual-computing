#declare HOUSE = true;

#include "math.inc"
#include "hausTexturen.inc"
#include "hausR.pov"
#include "hausInit.inc"

#macro Haus(sx, sz, style, fence)
     
     
    // TODO: Kontrolle der Ausmasse und Inputparameter. Bei falschen Werten eine Fehlermeldung ausschreiben.
    #declare validInput = true;
    
    #if (sx < 4 | sz < 4)
        #declare validInput = false;
        #error "sx und sz duerfen nicht kleiner als 4 sein"
    #end
    
    #if (style != 1 & style != 2)
        #declare validInput = false;
        #error "style darf entweder '1' oder '2'sein"
    #end
    
    #if (fence != 0 & fence != 1)
        #declare validInput = false;
        #error "fence darf entweder '0' (kein Zaun) oder '1' (mit Zaun) sein"
    #end

        
    #if (validInput = true) 
    
        //Die Stilparameter werden durch den folgenden Makroaufruf gesetzt
        HausInit(sx, sz, style)
    
        // ZAUN
        #declare Zaun = difference
        {
            // TODO: Falls ein Zaun modelliert sein soll, erzeuge diesen so dass der Umriss 
            //       der Parzelle HofSX + sx mal HofSZ + sz ist.
            //       Der Zaun soll auch die vorgegebene ZaunHoehe und ZaunBreite einhalten und
            //       an das Haus angrenzen. Ein Eingang gegenueber der Haustuer ist auszuschneiden.
            //       Falls der Zaun eine Hoehe von weniger als 1.5 hat, soll er einen Aufsatz
            //       bekommen, der so hoch ist wie der Zaun breit ist, eine Breite von 0.4 hat,
            //       und mittig auf dem Zaun sitzt.
            
            // Zaunaufsatzbreite laut Anleitung = 0.4    
            #declare ZaunAufsatzBreite = 0.4;
            
            
            union {
                // Mauer hinten                 
                box {
                    <Hx - HausSX, Hy, Hz>
                    <Hx - GesSX, Hy + ZaunHoehe, Hz - ZaunBreite>
                }
                // Mauer links
                box {
                    <Hx - GesSX, Hy, Hz>
                    <Hx - GesSX + ZaunBreite, Hy + ZaunHoehe, Hz - GesSZ>
                }
                // Mauer vorne
                box {
                    <Hx,Hy,Hz - GesSZ + ZaunBreite>
                    <Hx - GesSX, Hy + ZaunHoehe, Hz - GesSZ>
                }
                // Mauer rechts
                box {
                    <Hx, Hy, Hz - HausSZ>
                    <Hx - ZaunBreite, Hy + ZaunHoehe, Hz - GesSZ>
                }
                
                    
                // Aufs�tze falls n�tig (ZaunHoehe < 1.5)
                #if (ZaunHoehe < 1.5)
                        
                    // Mauer hinten                 
                    box {
                        <Hx - HausSX, Hy + ZaunHoehe, Hz - ZaunBreite>
                        <Hx - GesSX + ZaunBreite - ZaunAufsatzBreite/2.0 - ZaunBreite/2.0, Hy + ZaunHoehe + ZaunBreite, Hz - ZaunBreite + ZaunAufsatzBreite>
                        translate <0,0,-ZaunAufsatzBreite/2.0+ZaunBreite/2.0>
                    }
                    // Mauer links
                    box {
                        <Hx - GesSX + ZaunBreite, Hy + ZaunHoehe, Hz - ZaunBreite>
                        <Hx - GesSX + ZaunBreite - ZaunAufsatzBreite, Hy + ZaunHoehe + ZaunBreite, Hz - GesSZ + ZaunBreite - ZaunAufsatzBreite/2.0 - ZaunBreite/2.0>
                        translate <ZaunAufsatzBreite/2.0-ZaunBreite/2.,0,0>
                    }
                    // Mauer vorne
                    box {
                        <Hx - GesSX + ZaunBreite, Hy + ZaunHoehe, Hz - GesSZ + ZaunBreite>
                        <Hx - ZaunBreite + ZaunAufsatzBreite/2.0 + ZaunBreite/2.0, Hy + ZaunHoehe + ZaunBreite, Hz - GesSZ + ZaunBreite - ZaunAufsatzBreite>
                        translate <0,0,ZaunAufsatzBreite/2.0-ZaunBreite/2.0>
                    }
                    // Mauer rechts
                    box {
                        <Hx - ZaunBreite + ZaunAufsatzBreite, Hy + ZaunHoehe, Hz - HausSZ>
                        <Hx - ZaunBreite, Hy + ZaunHoehe + ZaunBreite, Hz - GesSZ>
                        translate <-ZaunAufsatzBreite/2.0+ZaunBreite/2.0,0,0>
                    }   
                
                #end
            }                
                             
                             
            texture {T_Grnt2}
        }
    
        union
        {
            // TODO: Hier soll anstatt union das HausR Makro aufgerufen werden.  
            HausR(sx, sz)
    
            #if (fence = 1)
                union
                {
                    
                    // Eingang herausstechen
                    difference {
                        
                        object {Zaun}
                        box { // Die Box ist so gross gewaehlt, dass der eingang auch dann komplett herausgestochen wird, falls der zaunaufsatz so gross ist, dass dieser auch geschnitten wird
                            <Hx-TuerMauerAbstand            , Hy-1                           , Hz+1>
                            <Hx-TuerMauerAbstand-TuerBreite , Hy + ZaunHoehe + ZaunBreite + 1, Hz-GesSZ-ZaunBreite-ZaunAufsatzBreite-1>   
                        }
                    }
                    
                    
                    // Zeichne den Hof
                    box
                    {
                        <-sx/2 - HofSX/2, -0.1, -sz/2 - HofSZ/2>
                        < sx/2 + HofSX/2,  0  ,  sz/2 + HofSZ/2>
                        translate <-HofSX/2, 0, - HofSZ/2>
                        texture {tex_HofText}
                    }
                }
            #end
        }
    
    #else
    // Fehlermeldung
        
        //Error marker zeichnen
        box
        {
            <-2, 0, -2>
            < 2, 2,  2>
            pigment {color rgb <1 0 0>}
        }
    
    #end
    
#end


///////////////////////////////////////////////////////////////////////////
//Detailansicht des Hauses. Deaktiviert, wenn aus Terrain.pov aufgerufen.//
///////////////////////////////////////////////////////////////////////////

#ifndef (TERRAIN)
    #include "colors.inc"
    background { White }
    camera
    {
        //orthographic
        location <-25, 9, -17>
        look_at <-6, 0, 0>
    }
    light_source {<30, 100, 0> color Gray50 }
    light_source {<300, 10, -100> color Gray50 }
    light_source {<-30, 50, -30> color Gray50 }
    light_source {<-10, 40, -100> color Gray50 }
    light_source {<-10, 40, 100> color Gray50 }
    
    union {
        object { Haus(10, 6, 1, 1) translate <-10,0,0> }
        object { Haus(10, 6, 2, 1) translate < 10,0,0> }
    }
#end
