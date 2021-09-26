module View.Header exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html
import Html.Attributes as Attr exposing (class, href, style)
import Html exposing (Html)

headerMouseOverEffect : Attribute msg
headerMouseOverEffect = mouseOver [ Font.color (rgb255 0 177 0)]


githubIcon : Element msg
githubIcon = (Element.html (Html.i [ class "fab fa-github" ] []))

navbar =
    Element.row
        [ Region.navigation
        , alignTop
        ]
        [ link [ headerMouseOverEffect ] { url = "#paragraph5", label = text "Passion" } ]

header =
    row
        [ Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , width fill
        , paddingXY 20 10
        , Font.color (rgb255 105 108 115)
        , Background.color (rgb255 18 19 15)
        ,alpha 0.7
        ]
        [ navbar, Element.el [alignRight] (link [headerMouseOverEffect] {url="https://github.com/DavidLangen", label = githubIcon })]
