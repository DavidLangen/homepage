module View.Footer exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font

footer =
    row
        [ paddingXY 10 10
        , width fill
        , Background.color (rgb255 34 37 42)
        , Font.color (rgb255 105 108 115)
        ]
        [ row [ centerX ] [ text "footer" ] ]
