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

union
{
    //Wenn wir den ganzen Wald zeichnen wollen, ohne komplizierte Optimierungen durchzufuehren, muessen wir die Baeume nur mit extrem geringen Details zeichnen.

    //TODO Der Stamm soll ein Kegel sein. Der untere Durchmesser soll zufaellig fuer jeden Baum aus dem Intervall [w0/2, w0] gewaehlt sein. Die obere Breite betraegt immer 0.01.
    //     Nimm eine kleine Reserve am Boden, damit der Baum nicht ueber dem boden schwebt (also wird der Stamm etwas hoeher sein und mit negativen y anfangen).
    //Hint: Zufaellige Zahlen zwischen 0 und 1 lassen sich mit rand(RND) generieren.
    //     Ein einfacher Platzhalter fuer den Stamm.
    cone
    {
        <0, -1, 0>, 1.0
        <0, 32, 0>, 0.01
        pigment
        {
            color DarkBrown
        }
    }
    //TODO Die Krone soll aus mehreren Kegeln, die uebereinander platziert werden, bestehen. Diese sollen in einer #while Schleife erzeugt werden. Viele Parameter sollen zufaellig variiren:
    //      - Die Anzahl der Kegel soll zwischen 7 und 11 leigen
    //      - Die Basis der Kegel soll in den unteren ?sten viel breiter sein, als an der Spitze. Dazu eignen sich gut verschiedene Varianten von 1/x. Die Berechnung soll in der kronenKegelRadius Funktion implementiert werden (siehe weiter unten). Die Breite soll Teilweise auch von eienm zufaelligen Faktor bestimmt sein.
    //      - Die Hoehe der Kegel soll in den unteren ?sten kleiner sein, als an der Spitze. Die Berechnung soll in der kronenKegelHoehe Funktion implementiert werden (siehe weiter unten). Die Hoehe soll Teilweise auch von eienm zufaelligen Faktor bestimmt sein.
    //      - Die Kegel (ausser dem an der Spitze) sollen auch zufaellig gedreht sein, zwischen -2 und 2 Grad um die x und z Achsen.
    //Die Kegel sollen die Spitze als Pivotpunkt haben (auch wegen der Rotierung). Der erste soll in zwischen 1/4 und 1/3 der Baumhoehe platziert sein, danach in regelmaessigen Abstaenden. Die y-Koordinate soll in der Funktion kronenKegelY implementiert werden (siehe weiter unten).
    //TODO Die Kronenkegel werden nicht mit cone modelliert, sondern mit lathe. Verwendet 4 Punkte und verbindet sie mit einem quadratic_spline. Die Kontur soll etwas nach innen gewoelbt sein (siehe Bilder in der Angabe) und wieder ein wenig zufaellig bei jedem Kegel und jedem Baum variieren.
    box
    {
        <-4, 8, -4>
        <4, 32, 4>
        FichteTex(colR, colG, colB, RND)
    }
}
#end


#declare kronenKegelRadius = function(w, index, maxIndex, randomValue){ 1.0 }
#declare kronenKegelHoehe = function(h, index, maxIndex, randomValue){ 1.0 }
#declare kronenKegelY = function(h, index, maxIndex){ 1.0 }


/////////////////////////////////////////////////////////////////////////
//Detailansicht der Fichte. Deaktiviert, wenn aus Terrain.pov aufgerufen.
/////////////////////////////////////////////////////////////////////////
#ifndef (TERRAIN)
    #include "colors.inc"
background { White } 
#declare camera_location = <0, 15, -20>;

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