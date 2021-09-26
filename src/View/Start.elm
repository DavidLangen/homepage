module View.Start exposing (..)

import Model exposing (Model, Msg)
import Utils.TimeHelper exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font

import Html.Attributes as Attr exposing (class, href, style)

helloText : Model -> Element msg
helloText m =
    let
         age = calculateCurrentAge m
    in
    column [ width fill, spacing 10, Font.color (rgb255 211 224 202) ]
                                                   [ el [ centerX, Font.bold ] <| text "Me, Myself & I"
                                                   , paragraph [ width <| maximum 300 fill, centerX]
                                                       [ text ("Hi, ich heiße David und bin " ++ String.fromInt age ++ " Jahre alt. Ich begrüße dich herzlich auf meiner Webseite.") ]
                                                   ]



startImg : Element msg
startImg = image [ height<| px 500, width fill ]
                                                         { src = "images/David_Profilbild_Green9216x3456.png"
                                                         , description = "Portrait of me"
                                                         }
middle m =
    let
        h = Element.el [centerY, alignRight, moveLeft 200] (helloText m)
    in
    column [width fill][
    row [width fill, height <| px 500] -- Background.gradient {angle=Basics.pi/2, steps=[(rgb255 0 0 0), (rgb255 0 0 0), (rgb255 54 54 51)]}
        [
        Element.el [inFront(h), width fill, height fill] (startImg)
                                       ],
    row
        [ height fill
        , Font.color (rgb255 255 255 255)
        , Background.color (rgb255 0 0 0)
        ]
        [ column [ width fill, paddingXY 300 100, spacing 60 ]
            [
                para "paragraph1"
            ]
        ]]



para : String -> Element msg
para id =
    paragraph [ spacing 10, padding 20, Border.width 1, htmlAttribute (Attr.id id) ] [ text "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet." ]


