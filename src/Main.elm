module Main exposing (footer, header, main, middle, navbar, view)

import Element exposing (..)
import Element.Background
import Element.Border as Border
import Element.Font as Font
import Element.Input exposing (button)
import Element.Region as Region
import Html.Attributes as Attr exposing (style)


main =
    Element.layout [] view


view =
    column [ width fill, height fill ] [ header, middle, footer ]


navbar =
    Element.row
        [ Region.navigation
        , Font.color (rgb255 105 108 115)
        , alignTop
        ]
        [ link [ mouseOver [ Font.color (rgb255 0 177 0) ] ] { url = "#paragraph5", label = text "Paragraph 1" } ]


header =
    row
        [ Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , width fill
        , paddingXY 20 10
        , Element.Background.color (rgb255 34 37 42)
        ]
        [ navbar, el [ alignRight ] (image [ width (px 30) ] { src = "images/github.svg", description = "Github" }) ]


middle =
    row
        [ height fill
        , Font.color (rgb255 114 127 140)
        , Element.Background.color (rgb255 52 58 64)
        ]
        [ column [ width fill, paddingXY 300 100, spacing 60 ]
            [ para "paragraph1"
            , para "paragraph2"
            , para "paragraph2"
            , para "paragraph2"
            , para "paragraph2"
            , para "paragraph2"
            , para "paragraph2"
            , para "paragraph2"
            , para "paragraph5"
            ]
        ]


para id =
    paragraph [ spacing 10, padding 20, Border.width 1, htmlAttribute (Attr.id id) ] [ text "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet." ]


footer =
    row
        [ paddingXY 10 10
        , width fill
        , Element.Background.color (rgb255 34 37 42)
        , Font.color (rgb255 105 108 115)
        ]
        [ row [ centerX ] [ text "footer" ] ]
