module View.CustomElements exposing (..)

import Element
import Html exposing (Html, node)
import Html.Attributes exposing (attribute)

-- Convert Javascript Webcomponents into Elements (elm-ui)
-- See also customElements.js


imageWithDefault : Int -> Int -> String -> String -> Element.Element msg
imageWithDefault width height src defaultSrc =  Element.html <|
                                        node "intl-image" [attribute "width" (String.fromInt width),
                                                          attribute "height" (String.fromInt height),
                                                          attribute "src" src,
                                                          attribute "defaultSrc" defaultSrc] []