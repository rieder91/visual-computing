#include "math.inc"
#include "hausTexturen.inc"

#include "tuer.mac"
#include "fenster.mac"

#macro HausR(sx, sz)
// INPUT:
//        sx, sz ... ausmasse des Hauses

// Folgende Variablen sollen bereits von HausInit gesetz sein:
// FensterBreite, FensterHohe, FensterBasisHohe, FensterAbstand,
// FesnterSprAnz, FensterShape, FensterStil, Tuerstil, PfostenHoehe, DachFirstHoehe,
// HausDekoration, GiebelDach, ZaunHoehe,
// BasisHoehe, ZaunBreite, PfostenBreite, HausPfosten,
// DachKranzHoehe, DachUeberstand, WandDicke, WandOffset, TurBreite, TurHohe

// WICHTIG: Alle Texturen, die man braucht befinden sich in der Datei "hausTexturen.inc".
//    TODO: Die Wandtextur sollte sich in Abhaengigkeit vom Stil aendern (tex_HouseBrick oder tex_HousePlaster).

union
{

    // BASIS
    // TODO: Es ist die Hausbasis mit Ausmasse sx x sz zu zeichnen!
    //       Die BasisHoehe ist aus der Datei "hausInit.inc" zu entnehmen.
    box {
        <Hx, Hy, Hz>
        <Hx - HausSX, Hy + BasisHoehe, Hz - HausSZ>
    }

    // ECKPFOSTEN
    // TODO: An jedem Hauseck ist jeweils ein HausPfosten zu stellen.
    //       Die notwendigen Parameter sind in der Datei "hausInit.inc" zu finden.
    
    // Pfosten Objekt deklarieren
    #declare pfostenObj = box {
        <Hx,Hy,Hz>
        <Hx-PfostenBreite,Hy+PfostenHoehe,Hz-PfostenBreite>    
    } 
    
    // Vier Pfosten erstellen und an die Ecken des Hauses verschieben
    union {
    
        object { pfostenObj 
            translate <0, 0, 0> 
        }
        object { pfostenObj                                    
            translate <-HausSX+PfostenBreite,0,>
        }
        object { pfostenObj
            translate <0,0,- HausSZ+PfostenBreite>
        }
        object { pfostenObj                                     
            translate <-HausSX+PfostenBreite,0,-HausSZ+PfostenBreite>
        }
        translate <0,BasisHoehe,0>
    }
     
    // WAENDE

    // TODO: Hier sind die Waende zu erstellen und alle Oeffnungen fuer Fenster und Tuer auszuschneiden.
    //       Die Tuer befindet sich auf der Fronseite (parallel zu der x-Achse, dem Hof zugewandt), eine
    //       halbe Tuerbreite von der linken oder rechten Ecke entfernt.
    //       Der Abstand zwischen der Tuer und dem ersten Fenster ist gleich der Summe der halben Tuerbreite
    //       und der halben Fensterbreite. Der Abstand zwischen den Fenstern und die Abmessungen der Tuer und
    //       Fenster ist aus der Datei "hausInit.inc" zu entnehmen. Die Fenster auf der Frontseite sollen
    //       so weit gehen, bis die Laenge der Wand erlaubt.
    //       Die andere dem Hof zugewandte Seite (parallel zu der z-Achse) ist gefuellt mit Fenstern, wobei das
    //       erste Fenster (gezaehlt von der Frontseite) im Abstand von einer Fensterbreite und einem FensterAbstand
    //       von der Frontecke entfernt ist.
    union {        
        
        // Eintrücken, damit man sehen kann, das die Pfosten dicker sind als die Waende
        #declare intend = (PfostenBreite - WandDicke)/2.0;
    
        // Wand hinten                 
        box {
            <Hx, Hy, Hz>
            <Hx - HausSX, Hy + HausHoehe, Hz - WandDicke>
            translate <intend,0,0>
        }
        // Wand links
        box {
            <Hx - HausSX, Hy, Hz>
            <Hx - HausSX + WandDicke, Hy + HausHoehe, Hz - HausSZ> 
            translate <0,0,intend>
        }
        // Wand vorne
        box {
            <Hx,Hy,Hz - HausSZ + WandDicke>
            <Hx - HausSX, Hy + HausHoehe, Hz - HausSZ>
            translate <-intend,0,0>
        }
        // Wand rechts
        box {
            <Hx, Hy, Hz>
            <Hx - WandDicke, Hy + HausHoehe, Hz - HausSZ> 
            translate <0,0,-intend>
        }
        translate <0,BasisHoehe,0>
    }
    
    
    // AUSBAUGEGENSTAENDE

    // TODO: Hier sind die Tuer und die Fenster in die dafuer ausgeschnittenen Oeffnungen einzusetzen.
    
    TuerQ(100, 500, 1)
    

    // DACH

    // TODO: Hier ist das Dach zu zeichnen. Die Parameter sind in der Datei "hausInit.inc" zu finden.
    //       Nicht vergessen, dass das Dach ueber die Grenzen der Hauswaende auskragt!   
    #declare dach = union {
    
        box {
            <Hx + DachUeberstand, Hy, Hz + DachUeberstand>
            <Hx - HausSX - DachUeberstand, Hy + DachKranzHoehe,Hz - HausSZ - DachUeberstand>
        }
        
        #if (GiebelDach | false)
        // Giebeldach(2 Seiten geneigt, 2 Seiten vertikal)
         
            object {    
                prism {
                    0, HausSZ + 2*DachUeberstand, 4
                    <0, 0>,
                    <0 - HausSX - 2*DachUeberstand, 0>
                    <(0 - HausSX - 2*DachUeberstand) / 2.0, DachFirstHoehe>
                    <0, 0>
                }
                rotate <-90,0,0>
                translate <Hx+DachUeberstand,DachKranzHoehe,Hz+DachUeberstand>
            }   
            
        #else
        // Walmdach(alle Seiten geneigt)
            
            intersection {
            
                object {    
                    prism {
                        0, HausSZ + 2*DachUeberstand, 4
                        <0, 0>,
                        <0 - HausSX - 2*DachUeberstand, 0>
                        <(0 - HausSX - 2*DachUeberstand) / 2.0, DachFirstHoehe>
                        <0, 0>
                    }
                    rotate <-90,0,0>
                    translate <Hx+DachUeberstand,DachKranzHoehe,Hz+DachUeberstand>
                }
                
                object {    
                    prism {
                        0, HausSX + 2*DachUeberstand, 4
                        <0, 0>,
                        <0 - HausSZ - 2*DachUeberstand, 0>
                        <(0 - HausSZ - 2*DachUeberstand) / 2.0, DachFirstHoehe>
                        <0, 0>
                    }
                    rotate <-90,90,0>
                    translate <Hx+DachUeberstand,DachKranzHoehe,-Hz-DachUeberstand>
                }
            
            }     
              
        #end
    }
    
    // Dach erzeugen und nach oben schieben
    object { dach translate<0,BasisHoehe + HausHoehe,0> } 
    
    
    // DEKORATION
    #if (HausDekoration = 1)
        difference
        {
            box
            {
                <-sx/2 - DekorUeberstand, 0          , -sz/2 - DekorUeberstand>
                < sx/2 + DekorUeberstand, -DekorHoehe,  sz/2 + DekorUeberstand>
                translate <0, BasisHoehe + PfostenHoehe, 0>
            }
            box
            {
                <-sx/2 - DekorUeberstand + DekorStaerke, 1              , -sz/2 - DekorUeberstand + DekorStaerke>
                < sx/2 + DekorUeberstand - DekorStaerke, -DekorHoehe - 1,  sz/2 + DekorUeberstand - DekorStaerke>
                translate <0, BasisHoehe + PfostenHoehe, 0>
            }
            box
            {
                <-sx, -DekorHoehe + DekorEinschnitt, -sz/2>
                < sx, -DekorHoehe - 1              ,  sz/2>
                translate <0, BasisHoehe + PfostenHoehe, 0>
            }
            box
            {
                <-sx/2, -DekorHoehe + DekorEinschnitt, -sz>
                < sx/2, -DekorHoehe - 1              ,  sz>
                translate <0, BasisHoehe + PfostenHoehe, 0>
            }
            texture {T_Wood2 rotate <90, 0, 0> scale 3}
        }
    #end

    pigment { color rgb <0.75,0.7,0.7>} 
}
#end


//////////////////////////////////////////////////////////////////////////
//Detailansicht des Hauses. Deaktiviert, wenn aus Terrain.pov aufgerufen//
//////////////////////////////////////////////////////////////////////////
#ifndef (TERRAIN)
    #ifndef (HOUSE)
        #include "colors.inc"
        background { White }
        camera
        {
            //orthographic
            location <-15, 10, -15>
            look_at <0, 0, 0>
        }

        light_source {<30, 100, 0> color Gray50 }
        light_source {<300, 10, -100> color Gray50 }
        light_source {<-30, 50, -30> color Gray50 }
        light_source {<-10, 40, -100> color Gray50 }
        light_source {<-10, 40, 100> color Gray50 }

        #include "hausInit.inc"
        HausInit(8, 10, 0);

        object { HausR(8, 10) }
    #end
#end

