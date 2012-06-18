//Erst definieren wir die einzelnen Teile des Springers:
//  - vordere und hintere Koerperhaelfte
//  - Kopf
//  - Ohr
//  - Maehne
//
//Am Ende werden alle in einer union zusammengefuegt.

#declare SpringerKorperHinten = bicubic_patch
{
    type 1
    flatness 0.0001
    u_steps 64
    v_steps 64
    <-0.25, 0, 0>	<-0.25, 0, -0.125>	<-0.15, 0, -0.25>	<0.025, 0, -0.25>
    <-0.165, 0.134, 0>	<-0.15, 0.178, -0.15>	<-0.1, 0.223, -0.2>	<0.05, 0.223, -0.25>
    <-0.15, 0.402, 0>	<-0.15, 0.446, -0.15>	<0.1, 0.446, 0>	<0.05, 0.595, -0.05>
    <-0.31, 1.114, 0>	<-0.31, 1.044, 0>	<-0.279, 1.044, -0.1>	<-0.15, 0.974, -0.1>

    translate <0, 0.23016259, 0>
}

#declare SpringerKorperVorne = bicubic_patch
{
    type 1
    flatness 0.0001
    u_steps 64
    v_steps 64
    <0.025, 0, -0.25>	<0.125, 0, -0.25>	<0.25, 0, -0.125>	<0.25, 0, 0>
    <0.05, 0.223, -0.25>	<0.1, 0.223, -0.2>	<0.425, 0.178, -0.15>	<0.425, 0.178, 0>
    <0.05, 0.595, -0.05>	<0.1, 0.446, -0.2>	<0.425, 0.446, -0.15>	<0.425, 0.446, 0>
    <-0.15, 0.974, -0.1>	<0, 0.974, -0.1>	<0, 0.905, -0.05>	<0.075, 0.835, 0>

    translate <0, 0.23016259, 0>
}

//Die Schnittmenge schafft runde Formen vor allem an der unteren Seite des Kopfes. Durch verschiedene Kugeln werden immer kleine eckige Teile weggeschnitten.
#declare SpringerKopf = intersection
{
    //Die Differenz des Prism-Objekts und vieler kleinen Zylinder erzeugt fast alle Details am Kopf.
    difference
    {
        //Die Basis fuer den Kopf
        prism
        {
            cubic_spline
            0 0.6 11
            <-0.5, 0.2>
            <-0.5, -0.2>
            <-0.1, -0.3>
            <0.3, -0.18>
            <0.6, -0.1>
            <0.6, 0.1>
            <0.3, 0.18>
            <-0.1, 0.3>
            <-0.5, 0.2>
            <-0.5, -0.2>
            <-0.1, -0.3>
        }

        //Das untere Maul
        cone
        {
            <0.4, -0.25, -3>, 0.4
            <0.4, -0.25, 3>, 0.4
        }

        //Augen
        cone
        {
            <-0.03, 0.45, -0.5>, 0.06
            <-0.03, 0.45, -0.27>, 0.06
        }
        cone
        {
            <-0.03, 0.45, 0.5>, 0.06
            <-0.03, 0.45, 0.27>, 0.06
        }
        //Maul
        sphere 
        {
            <0, 0, 0>, 0.3
            scale <1, 0.2, 1>
            translate <0.7, 0.3, 0>
        }

        //Nasenloecher
        cone
        {
            <0, 0, -3>, 0.03
            <0, 0, -0.07>, 0.03
            translate <0.6, 0.47, 0>
        }
        cone
        {
            <0, 0, 3>, 0.03
            <0, 0, 0.07>, 0.03
            translate <0.6, 0.47, 0>
        }

        //Trense
        cone
        {
            <0.45, 0.3, -3>, 0.05
            <0.45, 0.3, 3>, 0.05
        }

        //Der Kopf soll ein Bisschen nach unten rotiert sein
        rotate <0, 0, -2>
    }

    //Bart
    sphere 
    {
        <0, 0, 0>, 0.8
        scale <1, 0.8, 1>
        rotate <0, 0, -10>
        translate <-0.11, 0.35, 0>
    }

    //Nase und Stirn
    sphere 
    {
        <0, 0, 0>, 1.0
        scale <2, 0.6, 1>
        rotate <0, 0, 12>
        translate <-1.1, -0.15, 0>
    }

    //Hinterkopf
    sphere 
    {
        <0, 0, 0>, 1.0
        scale <1, 0.6, 1>
        rotate <0, 0, 12>
        translate <0.5, 0.59, 0>
    }

    //Nacken unter den Ohren
    sphere 
    {
        <0, 0, 0>, 1.05
        scale <1, 1, 0.4>
        rotate <0, 0, 12>
        translate <0.25, 0.9, 0>
    }
}

//Beim Ohr handelt es sich um 2 geschlossene Kurven, die Innere wird automatisch aus der Aeusseren herausgeschnitten.
#declare SpringerOhr = 
prism
{
    cubic_spline
    0 0.1 14
    <-0.13, 0.04>
    <-0.13, -0.04>
    <0.13, -0.07>
    <0.13, 0.07>
    <-0.13, 0.04>
    <-0.13, -0.04>
    <0.13, -0.07>
    <-0.104, 0.032>
    <-0.104, -0.032>
    <0.104, -0.056>
    <0.104, 0.056>
    <-0.104, 0.032>
    <-0.104, -0.032>
    <0.104, -0.056>

    rotate <-90, 15, -5>
    translate <-0.25, 0.45, -0.2>
}

//Die Maehne kopiert ungefaehr den Ruecken, ein grosser Teil ist aber versteckt im Inneren des Koerpers.
#declare SpringerMahne = difference
{
    prism
    {
        cubic_spline
        0 0.065 12
        <-0.025, 0.394>
        <0, 0>
        <-0.305, 0>
        <-0.26, 0.298>
        <-0.275, 0.668>
        <-0.375, 1.026>
        <-0.307, 1.175>
        <-0.124, 1.182>
        <-0.031, 1.063>
        <-0.025, 0.394>
        <0, 0>
        <-0.305, 0>

        rotate <-90, 0, 0>
        translate <0, 0, 0.032>
    }

    //Alles unterhalb des Koerpers wird weggeschnitten.
    box
    {
        <-3, -3, -3>
        <3, 0, 3>
    }
}

#declare Springer = union
{
    lathe
    {
        linear_spline 7,
        //Podest
        <0, 0>
        <0.415, 0>
        <0.415, 0.064>
        //Beine
        <0.358, 0.077>
        <0.415, 0.118>
        <0.278, 0.182>
        <0.25, 0.23>
    }

    //Linke Seite
    object {SpringerKorperHinten}
    object {SpringerKorperVorne}
    //Rechte Seite
    object {SpringerKorperHinten scale<1,1,-1>}
    object {SpringerKorperVorne scale<1,1,-1>}

    union
    {
        object {SpringerKopf}
        object {SpringerOhr}
        object {SpringerOhr scale<1,1,-1>}

        scale 0.62000006
        translate <0, 0.9956939, 0>
    }

    object {SpringerMahne translate <0, 0.23016259, 0>}
}

//////////////////////////////////////////////////////////////////////////////
//Detailansicht dieser Figur. Deaktiviert, wenn aus chessboard.pov aufgerufen.
//////////////////////////////////////////////////////////////////////////////
#ifndef (SCHACHBRETT)
#include "colors.inc"
camera
{
    orthographic
    location <0, 1.175, -2.7>
    look_at <0, 1.175, 0>
}

light_source { <10, 30, -20> color White }
light_source { <0, 0.2, -5> color Gray50 }
light_source { <-30, 0, -10> color Gray20 }

object {Springer  pigment {color White}}
#end
