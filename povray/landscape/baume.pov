#include "baumTexturen.inc"
#macro Fichte(h, w0, w1, RND)
//Parameter: 
//           h  ... Baum Hoehe 
//           w0 ... maximale Stammbreite (Durchmesser)
//           w1 ... maximale Kronenbreite
//           RND... random generator stream

        #declare sbmax=w0;
        #declare kbmax=w1;

#local colR = 0.2 + 0.2*rand(RND);
#local colG = 0.5 + 0.2*rand(RND);
#local colB = colR + 0.07 - 0.1*rand(RND);

union
{
    //Wenn wir den ganzen Wald zeichnen wollen, ohne komplizierte Optimierungen durchzufuehren, muessen wir die Baeume nur mit extrem geringen Details zeichnen.

    //TODO Der Stamm soll ein Kegel sein. Der untere Durchmesser soll zufaellig fuer jeden Baum aus dem Intervall [w0/2, w0] gewaehlt sein. Die obere Breite betraegt immer 0.01.
    //     Nimm eine kleine Reserve am Boden, damit der Baum nicht ueber dem boden schwebt (also wird der Stamm etwas hoeher sein und mit negativen y anfangen).
    //Hint: Zufaellige Zahlen zwischen 0 und 1 lassen sich mit rand(RND) generieren.
    
    #declare sbunten=w0/2+w0*rand(RND);
    #declare sboben=0.01;
    cone
    {
        <0, -1, 0>, sbunten
        <0, h, 0>, sboben     //der Stamm hat Höhe h ÜBER dem Erdboden.
        pigment
        {
            color DarkBrown
        }
    }
    //TODO Die Krone soll aus mehreren Kegeln, die uebereinander platziert werden, bestehen. Diese sollen in einer #while Schleife erzeugt werden. Viele Parameter sollen zufaellig variiren:
    //      - Die Anzahl der Kegel soll zwischen 6 und 9 leigen
    //      - Die Basis der Kegel soll in den unteren Ästen viel breiter sein, als an der Spitze. Dazu eignen sich gut verschiedene Varianten von 1/x. Die Berechnung soll in der kronenKegelRadius Funktion implementiert werden (siehe weiter unten). Die Breite soll Teilweise auch von eienm zufaelligen Faktor bestimmt sein.
    //      - Die Hoehe der Kegel soll in den unteren Ästen kleiner sein, als an der Spitze. Die Berechnung soll in der kronenKegelHoehe Funktion implementiert werden (siehe weiter unten). Die Hoehe soll Teilweise auch von eienm zufaelligen Faktor bestimmt sein.
    //      - Die Kegel (ausser dem an der Spitze) sollen auch zufaellig gedreht sein, zwischen -3.5 und 3.5 Grad um die x und z Achsen.
    //Die Kegel sollen die Spitze als Pivotpunkt haben (auch wegen der Rotierung). Der erste soll in zwischen 1/4 und 1/3 der Baumhoehe platziert sein, danach in regelmaessigen Abstaenden. Die y-Koordinate soll in der Funktion kronenKegelY implementiert werden (siehe weiter unten).
    //TODO Die Kronenkegel werden nicht mit cone modelliert, sondern mit lathe. Verwendet 4 Punkte und verbindet sie mit einem quadratic_spline. Die Kontur soll etwas nach innen gewoelbt sein (siehe Bilder in der Angabe) und wieder ein wenig zufaellig bei jedem Kegel und jedem Baum variieren.
    
     
    #declare kegelanz=6; 
    #declare zuf=rand(RND);     //erzeugt Zahl zwischen 0 und 1; wenn sie zwischen 0 und 0.25 liegt, ist kegelanz 6, zwischen 0.25 und 0.5 ist sie 7, usw.
    #if(zuf>0.25)
        #declare kegelanz=kegelanz+1;
    #end
    #if(zuf>0.5)
        #declare kegelanz=kegelanz+1; 
    #end        
     #if(zuf>0.75)
        #declare kegelanz=kegelanz+1; 
    #end              
    
    #declare i=0;
    
    /*debug*/ //#declare kegelanz=2;
    
    #while(i<kegelanz)
       
            #declare kkr=kronenKegelRadius(kbmax, i+1, kegelanz, rand(RND));    //sonst Division durch 0, wenn i=0
            #declare kkh=kronenKegelHoehe(h, i, kegelanz, rand(RND));      //Hier passt i=0, weil es von der max Anzahl abgezogen wird.
            #declare kky=kronenKegelY(h, i+0, kegelanz-1);              //kegelanz-1, damit besser berechenbar (siehe unten in der Fkt) --> =obere spitze des kegels
            #declare kkh=5;
            
            #declare xrot=0;
            #declare zrot=0;
            #declare yrot=0;
            #if(i<kegelanz-1)           //der oberste Kronenkegel muss nicht gedreht werden
                #declare xrot=-3.5+rand(RND)*7;
                #declare zrot=-3.5+rand(RND)*7;         //evtl Angabefehler?
                #declare yrot=360*rand(RND);
                
            #end
            
            lathe {
                   quadratic_spline
                   4,
                    
                    
                    
                    
                    //<0,-kkh>,                                
                    <kkr, -kkh>,         //kkh und kkr bestehen bereits aus einem zufälligen Faktor!
                    //<kkr, -kkh*0.9>,      //nach innen gewölbt
                    <kkr,-kkh>, 
                    <kkr*0.4,-kkh*0.5>, 
                    <0, 0>        //Spitze im Ursprung, weil Pivotstelle          
                    sturm
                    rotate <xrot, yrot, zrot>
                    translate <0, kky, 0> 
                    FichteTex(colR, colG, colB, RND)
                  } 
             #declare i=i+1;
          
    #end        //While-Schleifen-Ende      
            
  
}
#end


#declare kronenKegelRadius = function(w, index, maxIndex, randomValue){ 1/sqrt(index)*w-(1/sqrt(index)*w/10*randomValue) } //Zufälliger Faktor: Bis zu ein Zehntel des errechneten Radius kann wieder verringert werden. Bei max. 9 Kronenkegeln kann es die darüberliegenden Äste nicht unterschreiten.
#declare kronenKegelHoehe = function(h, index, maxIndex, randomValue){ 1/(maxIndex-index)*h/maxIndex-(1/(maxIndex-index)*h/maxIndex/5*randomValue) }      //h/maxindex;  - Maximale Höhe eines Kronenkegels - da sie immer kleiner werden ist hier freier Platz am unteren Stamm garantiert. Bis zu 1/5 kann die Höhe zufällig kleiner werden.
                                                                                                                                                                                                                                                                                          
//Anforderungen: muss bei maximalem Index die Höhe ergeben!
#declare kronenKegelY = function(h, index, maxIndex){ h/3+index*(h-h/3)/maxIndex }      // errechnet sich so: h/3.5 ist das unterste stück, das frei bleibt. h-h/3.5 ist der rest. den teilen wir gleichmäßig auf alle möglichen äste (=indizes) auf, und dann laufen wir i teilstücke davon in die höhe. maxIndex wird als kegelanz-1 übergeben, somit kann index maxIndex erreichen; d.H. bei maximalem Index kommt die höhe heraus. --> entspricht oberem Punkt des Kronenkegels


/////////////////////////////////////////////////////////////////////////
//Detailansicht der Fichte. Deaktiviert, wenn aus Terrain.pov aufgerufen.
/////////////////////////////////////////////////////////////////////////
#ifndef (TERRAIN)
    #include "colors.inc"
background { White } 
#declare camera_location = <0, 5, -40>;
//#declare camera_location = <0, 15, -20>;

camera
{
    orthographic
    location camera_location
    look_at <0, 10, 0>
    //look_at <0, 15, 0>
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