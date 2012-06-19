



/* // NOTES //    to be removed

   - Beim Zaunaufsatz steht, es soll mittig aufgesetzt werden, jedoch ist es im demobild auch nicht so, da geht es auch nur nach außen
   - Wo genau sitzt das dach auf?
   - sitzt die dekoration zu weit oben? bzw. warum ist im pfosten die basis eingerechnet und bei der dekoration nochmal?
   - Fehlermeldung ausschreiben fehlt noch
   
*/                 




#declare HOUSE = true;

#include "math.inc"
#include "hausTexturen.inc"
#include "hausR.pov"
#include "hausInit.inc"

#macro Haus(sx, sz, style, fence)
    #declare validInput = true;
    // TODO: Kontrolle der Ausmasse und Inputparameter. Bei falschen Werten eine Fehlermeldung ausschreiben.

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
                
                
            // Aufsätze falls nötig (ZaunHoehe < 1.5)
            #if (ZaunHoehe < 1.5)
                    
                #declare ZaunAufsatzBreite = 0.4;
                    
                // Mauer hinten                 
                box {
                    <Hx - HausSX, Hy + ZaunHoehe, Hz - ZaunBreite>
                    <Hx - GesSX + ZaunBreite - ZaunAufsatzBreite, Hy + ZaunHoehe + ZaunBreite, Hz - ZaunBreite + ZaunAufsatzBreite>
                }
                // Mauer links
                box {
                    <Hx - GesSX + ZaunBreite, Hy + ZaunHoehe, Hz - ZaunBreite>
                    <Hx - GesSX + ZaunBreite - ZaunAufsatzBreite, Hy + ZaunHoehe + ZaunBreite, Hz - GesSZ + ZaunBreite - ZaunAufsatzBreite>
                }
                // Mauer vorne
                box {
                    <Hx - GesSX + ZaunBreite, Hy + ZaunHoehe, Hz - GesSZ + ZaunBreite>
                    <Hx - ZaunBreite + ZaunAufsatzBreite, Hy + ZaunHoehe + ZaunBreite, Hz - GesSZ + ZaunBreite - ZaunAufsatzBreite>
                }
                // Mauer rechts
                box {
                    <Hx - ZaunBreite + ZaunAufsatzBreite, Hy + ZaunHoehe, Hz - HausSZ>
                    <Hx - ZaunBreite, Hy + ZaunHoehe + ZaunBreite, Hz - GesSZ>
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
                    box {
                        <Hx-TuerMauerAbstand            , Hy-1                           , Hz-GesSZ+ZaunBreite+1>
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
        location <-15, 8, -15>
        look_at <0, 0, 0>
    }
    light_source {<30, 100, 0> color Gray50 }
    light_source {<300, 10, -100> color Gray50 }
    light_source {<-30, 50, -30> color Gray50 }
    light_source {<-10, 40, -100> color Gray50 }
    light_source {<-10, 40, 100> color Gray50 }

    object { Haus(10, 8, 1, 1) }

#end
