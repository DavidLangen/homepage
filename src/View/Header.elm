module View.Header exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import View.CustomIcons exposing (githubIcon)

headerMouseOverEffect : Attribute msg
headerMouseOverEffect = mouseOver [ Font.color (rgb255 0 177 0)]

navbar =
    Element.row
        [ Region.navigation
        , alignTop
        ]
        [ link [ headerMouseOverEffect ] { url = "#paragraph1", label = text "Passion" } ]

paddingYAxes : number
paddingYAxes = 10

paddingXAxes : number
paddingXAxes = 20

borderSizeBottom : number
borderSizeBottom = 1

fontSize = 20

headerHeight : number
headerHeight = paddingYAxes * 2 + borderSizeBottom + fontSize

header =
    row
        [ Border.widthEach { bottom = borderSizeBottom, left = 0, right = 0, top = 0 }
        , width fill
        , paddingXY paddingYAxes paddingYAxes
        , Font.color (rgb255 105 108 115)
        , Font.size fontSize
        , Background.color (rgb255 18 19 15)
        ,alpha 0.7
        ]
        [ navbar, Element.el [alignRight] (link [headerMouseOverEffect] {url="https://github.com/DavidLangen", label = githubIcon })]
