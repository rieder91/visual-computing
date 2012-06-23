#include "baumTexturen.inc"         

#macro Fichte(h, w0, w1, RND)
//Parameter: 
//           h  ... Baum Hoehe 
//           w0 ... maximale Stammbreite (Durchmesser)
//           w1 ... maximale Kronenbreite
//           RND... random generator stream

#local colR = 0.2 + 0.2*rand(RND);
#local colG = 0.5 + 0.2*rand(RND);
#local colB = colR + 0.07 - 0.1*rand(RND);     
#declare stammHoehe = h;                      
#declare stammReserve = 0.05;
#declare stammUnten = (w0/2) + (w0/2)*rand(RND);
#declare stammOben = 0.01;

union
{
    //Wenn wir den ganzen Wald zeichnen wollen, ohne komplizierte Optimierungen durchzufuehren, muessen wir die Baeume nur mit extrem geringen Details zeichnen.

    //TODO Der Stamm soll ein Kegel sein. Der untere Durchmesser soll zufaellig fuer jeden Baum aus dem Intervall [w0/2, w0] gewaehlt sein. Die obere Breite betraegt immer 0.01.
    //     Nimm eine kleine Reserve am Boden, damit der Baum nicht ueber dem boden schwebt (also wird der Stamm etwas hoeher sein und mit negativen y anfangen).
    //Hint: Zufaellige Zahlen zwischen 0 und 1 lassen sich mit rand(RND) generieren.
    //     Ein einfacher Platzhalter fuer den Stamm.   
    
        cone
    {
        <0, 0, 0>, stammUnten,
        <0, stammHoehe+stammReserve, 0>, stammOben
        pigment
        {
            color DarkBrown
        }            
        translate<0,-stammReserve,0>
    }       
    
    //TODO Die Krone soll aus mehreren Kegeln, die uebereinander platziert werden, bestehen. Diese sollen in einer #while Schleife erzeugt werden. Viele Parameter sollen zufaellig variiren:
    //      - Die Anzahl der Kegel soll zwischen 7 und 10 leigen
    //      - Die Basis der Kegel soll in den unteren ?sten viel breiter sein, als an der Spitze. Dazu eignen sich gut verschiedene Varianten von 1/x. Die Berechnung soll in der kronenKegelRadius Funktion implementiert werden (siehe weiter unten). Die Breite soll Teilweise auch von eienm zufaelligen Faktor bestimmt sein.
    //      - Die Hoehe der Kegel soll in den unteren ?sten kleiner sein, als an der Spitze. Die Berechnung soll in der kronenKegelHoehe Funktion implementiert werden (siehe weiter unten). Die Hoehe soll Teilweise auch von eienm zufaelligen Faktor bestimmt sein.
    //      - Die Kegel (ausser dem an der Spitze) sollen auch zufaellig gedreht sein, zwischen -1.75 und 1.75 Grad um die x und z Achsen.
    //Die Kegel sollen die Spitze als Pivotpunkt haben (auch wegen der Rotierung). Der erste soll in zwischen 1/4 und 1/3 der Baumhoehe platziert sein, danach in regelmaessigen Abstaenden. Die y-Koordinate soll in der Funktion kronenKegelY implementiert werden (siehe weiter unten).
    //TODO Die Kronenkegel werden nicht mit cone modelliert, sondern mit lathe. Verwendet 4 Punkte und verbindet sie mit einem quadratic_spline. Die Kontur soll etwas nach innen gewoelbt sein (siehe Bilder in der Angabe) und wieder ein wenig zufaellig bei jedem Kegel und jedem Baum variieren.
     
     //Für KronenKegel:
     
     
     
     //Krone
    #local i = 0;
    #local n = 7+floor((4*rand(RND))-0.001);  

    #while (i < n)      
    
        #local i = i + 1;  
        //Die Kontur soll etwas nach innen gewoelbt sein (siehe Bilder in der Angabe) und wieder ein wenig zufaellig bei jedem Kegel und jedem Baum variieren.
        #local kkr = kronenKegelRadius(w1, i, n, rand(RND));    //Das random findet man im Kronenkegelradius
        #local kkh = kronenKegelHoehe(h, i, n, rand(RND));
        #local kky = kronenKegelY(h, i, n);          
                                       
        //Für random teil der Wöbung   
        #local f1 = 0.9;
        #local f2 = (1-f1)*2;       
        #local random1 = f1 + f2*rand(RND);
        #local random2 = f1 + f2*rand(RND);
        #local random3 = f1 + f2*rand(RND);
        #local random4 = f1 + f2*rand(RND);
                 
  
        
           
        lathe
        {
            quadratic_spline 4    
           
            <0,0>    
            <kkr/5 * random1,-kkh/6  * random2>  
            <kkr/2 *random3,-kkh*2/3 *random4> 
            <kkr, -kkh>  
                rotate<0, rand(RND)*360,0>
              #if( (i+1 < n)) 
                rotate<rand(RND) * 3.5-1.75,0, rand(RND) * 3.5-1.7>
              #end       
            translate <0, kky, 0>     

            FichteTex(colR, colG, colB, RND)           
        }   
        
                  
                
       
    #end                                                 
    
}
#end
            
            //W =>  MAX Kronenbreite
#declare kronenKegelRadius = function(w, index, maxIndex, randomValue)
{                                                            
    //Max Kronenbreite
    //    ((maxIndex-index)/ maxIndex) => da index von 1 bis maxindex rennt ... haben wir hier unten breit und oben nicht breit
    //Randomfaktor am ende noch wie in angagebe        
        (w) * ((maxIndex-index)/ (maxIndex)) * (randomValue * 0.15 + 0.85)       
}


//Die Hoehe der Kegel soll in den unteren Ästen kleiner sein, als an der Spitze.
//Die Hoehe soll Teilweise auch von eienm zufaelligen Faktor bestimmt sein.
#declare kronenKegelHoehe = function(h, index, maxIndex, randomValue)
{                    
    //(h*0.7) wir fangen erst bei 0.3 an ... d.h. wir haben 0.7 des baumes zur verfügung   
    //MaxIndex im Bruch, weil index von 1 bis MaxIndex    läuft und ich gerne von 1/maxindex - 1 alles hätte                                                          
    (h*0.7) / maxIndex * (1.5+0.5 *((index)/(maxIndex)))
}

//Die Kegel sollen die Spitze als Pivotpunkt haben (auch wegen der Rotierung).
//Der erste soll in zwischen 1/4 und 1/3 der Baumhoehe platziert sein, danach in regelmaessigen Abstaenden.
#declare kronenKegelY = function(h, index, maxIndex)
{                                                      
    //MaxIndex im Bruch, weil index von 1 bis MaxIndex    läuft und ich gerne von 1/maxIndex bis maxIndex/maxIndex alles hätte     
    h * 0.3 + (h * (1-0.3)) * (index) / (maxIndex)
}




/////////////////////////////////////////////////////////////////////////
//Detailansicht der Fichte. Deaktiviert, wenn aus Terrain.pov aufgerufen.
/////////////////////////////////////////////////////////////////////////
#ifndef (TERRAIN)
    #include "colors.inc"
background { White } 
#declare camera_location = <0, 20, -25>;

camera
{
    orthographic
    location camera_location
    look_at <0, 15, 0>
}

light_source { <-25, 0, -15> color 0.3 }
light_source { <-15, 5, -15> color 0.3 }
light_source { <-5, 10, -15> color 0.3 }
light_source { <5, 15, -15> color 0.3 }
light_source { <15, 20, -15> color 0.3 }
light_source { <25, 25, -15> color 0.3 }

#declare RND = seed(0);
object { Fichte(25, 1, 5, RND) } 

#end
