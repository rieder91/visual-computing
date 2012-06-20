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
      
      
      
    /***
     B A S I S
    
    ***/
    
    // TODO: Es ist die Hausbasis mit Ausmasse sx x sz zu zeichnen!
    //       Die BasisHoehe ist aus der Datei "hausInit.inc" zu entnehmen.
    box {
        <Hx, Hy, Hz>
        <Hx - HausSX, Hy + BasisHoehe, Hz - HausSZ>
    }
    
    
    /***
     E C K P F O S T E N
    
    ***/
    
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
     
    
    /***
     W A E N D E
    
    ***/

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
    #declare waende = union {        
        
    
        // Wand hinten                 
        box {
            <Hx, Hy, Hz>
            <Hx - HausSX, Hy + HausHoehe, Hz - WandDicke>
            translate <0,0,-WandIntend>
        }
        // Wand links
        box {
            <Hx - HausSX, Hy, Hz>
            <Hx - HausSX + WandDicke, Hy + HausHoehe, Hz - HausSZ> 
            translate <WandIntend,0,0>
        }
        // Wand vorne
        box {
            <Hx,Hy,Hz - HausSZ + WandDicke>
            <Hx - HausSX, Hy + HausHoehe, Hz - HausSZ>
            translate <0,0,WandIntend>
        }
        // Wand rechts
        box {
            <Hx, Hy, Hz>
            <Hx - WandDicke, Hy + HausHoehe, Hz - HausSZ> 
            translate <-WandIntend,0,>
        }
        translate <0,BasisHoehe,0>
    }
    
    
    // AUSBAUGEGENSTAENDE

    
        
    
    /***
     T U E R
    
    ***/  
    
    // TODO: Hier sind die Tuer und die Fenster in die dafuer ausgeschnittenen Oeffnungen einzusetzen
    
    // Tuer ausstanzen
    #declare waende = difference {
        object {waende}
                  
        #local TuerTiefe = 0.20;  // Tiefe des Rahmens
        #local TuerRahmen = 0.15; // Breite des Rahmens           
                     
        #if (TuerStil = 1)
            box {
                <(-TuerBreite/2.0), 0                   , -TuerTiefe/2.0-WandDicke>
                <(+TuerBreite/2.0), TuerHoehe+TuerRahmen, +TuerTiefe/2.0+WandDicke>
                translate <HausSX/2.0-TuerMauerAbstand-TuerBreite/2.0, BasisHoehe, HausSZ/2.0 - HausSZ>
            }
        #else 
            
            union
            {
                // Rahmen
                cylinder
                {
                    <0, TuerHoehe, -TuerTiefe/2-WandDicke>,
                    <0, TuerHoehe,  TuerTiefe/2+WandDicke>,
                    TuerBreite/2
                }
    
                box
                {
                    <(-TuerBreite/2.0), 0                   , -TuerTiefe/2.0-WandDicke>
                    <(+TuerBreite/2.0), TuerHoehe+TuerRahmen, +TuerTiefe/2.0+WandDicke>
                }
                translate <HausSX/2.0-TuerMauerAbstand-TuerBreite/2.0, BasisHoehe, HausSZ/2.0 - HausSZ>
            }
        
        #end
        
    }
      
    // Tuer einsetzen
    object { TuerQ(TuerBreite, TuerHoehe, TuerStil)
        translate <HausSX/2.0-TuerMauerAbstand-TuerBreite/2.0, BasisHoehe, HausSZ/2.0 - HausSZ + TuerTiefe/2 + WandIntend>
    }
      
     
     
    /***
     F E N S T E R
    
    ***/
    
    // Frontfenster
    #declare naechsterPlatz = Hx - TuerMauerAbstand - TuerBreite - ((TuerBreite/2.0) + (FensterBreite/2.0));   
         
    #while ((Hx-HausSX) < naechsterPlatz - (FensterBreite + FensterAbstand))
          
        // Fenster ausschneiden
        #declare waende = difference {
            object {waende}
                      
            #local FensterTiefe = 0.2;  // Tiefe des Rahmens
            #local FensterRahmen = 0.1; // Breite des Rahmens           
                         
            #if (FensterShape = 1)
                box {
                    <(-FensterBreite/2.0), 0           , -FensterTiefe/2.0-WandDicke>
                    <(+FensterBreite/2.0), FensterHoehe, +FensterTiefe/2.0+WandDicke>
                    translate <naechsterPlatz-FensterBreite/2.0, BasisHoehe+FensterBasisHoehe, HausSZ/2.0 - HausSZ>
                }
            #else 

                union
                {
                    cylinder
                    {
                        <0, FensterHoehe, -FensterTiefe/2.0-WandDicke>,
                        <0, FensterHoehe,  FensterTiefe/2.0+WandDicke>,
                        FensterBreite/2
                    }
        
                    box
                    {
                        <(-FensterBreite/2.0), 0           , -FensterTiefe/2.0-WandDicke-0.1>
                        <(+FensterBreite/2.0), FensterHoehe, +FensterTiefe/2.0+WandDicke+0.1>
                    }
                    translate <naechsterPlatz-FensterBreite/2.0, BasisHoehe+FensterBasisHoehe, HausSZ/2.0 - HausSZ>
                }
            
            #end
            
        }
        
        
        
        // Fenster einfuegen
        object { FensterQ(FensterBreite, FensterHoehe, FensterSprAnz, FensterShape, FensterStil) 
            translate <naechsterPlatz-FensterBreite/2.0, BasisHoehe+FensterBasisHoehe, HausSZ/2.0 - HausSZ + FensterTiefe/2 + WandIntend>
        }
         
         
        #declare naechsterPlatz = naechsterPlatz - (FensterBreite + FensterAbstand); 
         
    #end
    
    
    // Seiteliche Fenster
    #declare naechsterPlatz = Hz - HausSZ + FensterBreite + FensterAbstand + FensterBreite;   
         
    #while (Hz > naechsterPlatz)
         
        // Fenster ausschneiden
        #declare waende = difference {
            object {waende}
                      
            #local FensterTiefe = 0.2;  // Tiefe des Rahmens
            #local FensterRahmen = 0.1; // Breite des Rahmens           
                         
            #if (FensterShape = 1)
                box {
                    <(-FensterBreite/2.0), 0           , -FensterTiefe/2.0-WandDicke>
                    <(+FensterBreite/2.0), FensterHoehe, +FensterTiefe/2.0+WandDicke>
                    rotate <0,90,0> 
                    translate <HausSX/2.0 - HausSX, BasisHoehe+FensterBasisHoehe, naechsterPlatz-FensterBreite/2.0>
                }
            #else 

                union
                {
                    cylinder
                    {
                        <0, FensterHoehe, -FensterTiefe/2.0-WandDicke>,
                        <0, FensterHoehe,  FensterTiefe/2.0+WandDicke>,
                        FensterBreite/2
                    }
        
                    box
                    {
                        <(-FensterBreite/2.0), 0           , -FensterTiefe/2.0-WandDicke-0.1>
                        <(+FensterBreite/2.0), FensterHoehe, +FensterTiefe/2.0+WandDicke+0.1>
                    }
                    rotate <0,90,0> 
                    translate <HausSX/2.0 - HausSX, BasisHoehe+FensterBasisHoehe, naechsterPlatz-FensterBreite/2.0>
                }
            
            #end
            
        }
        
        
        
        // Fenster einfuegen
        object { FensterQ(FensterBreite, FensterHoehe, FensterSprAnz, FensterShape, FensterStil)
            rotate <0,90,0> 
            translate <HausSX/2.0 - HausSX + FensterTiefe/2 + WandIntend, BasisHoehe+FensterBasisHoehe, naechsterPlatz-FensterBreite/2.0>
        }
         
         
        #declare naechsterPlatz = naechsterPlatz + (FensterBreite + FensterAbstand); 
         
    #end                          
                              
    
    // Waende ausgeben
    
    #if (WandStyle = 1)
        object {waende texture { tex_HouseBrick }}
    #else    
        object {waende texture { tex_HousePlaster }}
    #end
      
      
    /***
     D A C H
    
    ***/

    // TODO: Hier ist das Dach zu zeichnen. Die Parameter sind in der Datei "hausInit.inc" zu finden.
    //       Nicht vergessen, dass das Dach ueber die Grenzen der Hauswaende auskragt!   
    #declare dach = union {
    
        box {
            <Hx + DachUeberstand, Hy, Hz + DachUeberstand>
            <Hx - HausSX - DachUeberstand, Hy + DachKranzHoehe,Hz - HausSZ - DachUeberstand>
        }
        
        #if (GiebelDach = 1)
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
    object { dach texture { tex_RoofTiles } translate<0,BasisHoehe + PfostenHoehe,0> } 
     
     
    
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
            location <-8, 4.3, -8>
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

