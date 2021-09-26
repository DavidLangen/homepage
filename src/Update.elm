module Update exposing (..)

import Model exposing (Model, Msg)
import Task
import Time
import Typewriter

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

    Model.TypewriterMsg twMsg ->
                    let
                        typeWriterTuple : (Typewriter.Model, Cmd Typewriter.Msg)
                        typeWriterTuple = (Typewriter.update twMsg model.writer)
                        typeWriterModel : Typewriter.Model
                        typeWriterModel =Tuple.first typeWriterTuple
                        typeWriterCmd : Cmd Typewriter.Msg
                        typeWriterCmd = (Tuple.second typeWriterTuple)
                    in
                    (
                    {
                      model | writer = typeWriterModel}
                    , Cmd.map (\ a -> Model.TypewriterMsg a) typeWriterCmd
                    )
