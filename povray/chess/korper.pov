#macro Korper(r0, r1, r2, r3, h0, h1, h2, hatNacken)
    //r0 ... Podest Radius (ACHTUNG, Breite aus der Angabe / 2.0 )
    //r1 ... Bauch Radius
    //r2 ... Torso Radius
    //r3 ... Nacken Radius (ignoriert wenn hatNacken == false)
    //h0 ... Podest Hoehe
    //h1 ... Koerper Hoehe
    //h2 ... Nacken Hoehe (ignoriert wenn hatNacken == false)
    //hatNacken ... true fuer den Laeufer, die Dame und fuer den Koenig
    //TODO Der Koerper ist am besten mit einem lathe Objekt zu modellieren (Beispiel weiter unten), es ist aber auch moeglich ihn mit mehreren cone Objekten darzustellen.
    //     Die Hoehe soll eine uniforme Skalierung des ganzen Koerpers erzwingen.
    //     Eine #if(hatNacken) Abfrage soll unterscheiden, ob die Figur auch einen Nacken hat (Laeufer, Dame, Koenig).

    lathe
    {
        #if (hatNacken)
                linear_spline 20
        #else
                linear_spline 9  
        #end
 
        //Torso
        <0, 0>
        <r0, 0>
        <r0, h0 * 0.20>
        <r0 * 0.90, h0 * 0.35>
        <r0, h0 * 0.45>
        <r0 * 0.70, h0 * 0.75>
        <r0 * 0.68, h0 * 0.90>
      
        //Koerper
        <r1, h0>
        <r2, h0 + h1>
        
        //Wenn hatNacken Falsch ist, ist das lathe Objekt nicht zu schliessen. D.h. Es ist am Ende kein Punkt [0, x] notwendig.

        #if (hatNacken)         
            // Nacken
            <r3, h0 + h1>
            <r3, h0 + h1 + h2 * 0.2>
            <r3 * 0.40, h0 + h1 + h2 * 0.35>
            <r3 * 0.75, h0 + h1 + h2 * 0.35>
            <r3 * 0.75, h0 + h1 + h2 * 0.45>
            <r3 * 0.50, h0 + h1 + h2 * 0.55>
            <r3 * 0.50, h0 + h1 + h2 * 0.65>
            <r3 * 0.50, h0 + h1 + h2 * 0.70>
            <r3 * 0.60, h0 + h1 + h2 * 0.70>
            <r3 * 0.60, h0 + h1 + h2 * 0.75>
            <0, h0 + h1 + h2> 
        #end
    }
#end

////////////////////////////////////////////////////////////////////////////////////////
//Vorschau des Koerpers fuer alle Figuren. Deaktiviert wenn aus chessboard.pov aufgerufen.
////////////////////////////////////////////////////////////////////////////////////////
#ifndef (SCHACHBRETT)
    #ifndef (FIGUR)
        #include "colors.inc"
        camera
        {
            orthographic
            location <0, 0.7, -2.0>
            look_at <0, 0.7, 0>
        }

        light_source { <10, 30, -20> color White }
        light_source { <0, 0.2, -5> color Gray50 }
        light_source { <-30, 0, -10> color Gray20 }

        //WICHTIG:
        //         So wird das Makro fuer den Laeufer mit den richtigen Massen aufgerufen.
        //         Das Pigment soll fuer Aufrufe innerhalb von Figuren nicht spezifiziert sein.
        object { Korper(0.433, 0.268, 0.22, 0.308, 0.242, 0.591, 0.211, true) pigment {color White}}
    #end
#end
