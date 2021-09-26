module View.View exposing (..)

import Model exposing (Model, Msg)
import View.Footer exposing (footer)
import View.Header exposing (header)
import View.Start exposing (middle)

import Element exposing (..)
import Html

view : Model -> Html.Html msg
view m = Element.layout [inFront <| header] <|
    column [ width fill, height fill] [middle m, footer ]
