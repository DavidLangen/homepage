module View.CustomColor exposing (..)

import Element exposing (rgb255)
import Element.Background as Background exposing (..)

darkgreen : Element.Color
darkgreen = rgb255 3 23 0

applegreen : Element.Color
applegreen = rgb255 33 133 20

backgroundColorDark : Element.Color
backgroundColorDark = rgb255 20 20 20

backgroundColorLight : Element.Color
backgroundColorLight = rgb255 38 38 38

backgroundGradient : Element.Attr decorative msg
backgroundGradient = Background.gradient {angle=Basics.pi*2, steps=[backgroundColorDark, rgb255 30 30 30, rgb255 34 34 34, backgroundColorLight]}
