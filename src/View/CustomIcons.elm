module View.CustomIcons exposing (..)

import Element exposing (..)
import Html
import Html.Attributes exposing (class)

githubIcon : Element msg
githubIcon = (Element.html (Html.i [ class "fab fa-github" ] []))

arrowIcon : Element msg
arrowIcon = (Element.html (Html.i [ class "fas fa-arrow-alt-circle-up" ] []))