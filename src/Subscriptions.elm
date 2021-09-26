module Subscriptions exposing (..)

import Model exposing (Model, Msg)
import Time

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 Model.Tick

