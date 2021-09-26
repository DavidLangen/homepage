module Update exposing (..)

import Model exposing (Model, Msg)
import Task
import Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Model.Tick newTime ->
      ( { model | time = newTime }
      , Cmd.none
      )

    Model.AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )
