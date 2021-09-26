module Init exposing (..)

import Model exposing (Model, Msg)
import Task
import Time
import Typewriter exposing (withTypeDelay)

init : () -> (Model, Cmd Msg)
init _ =
    let
        typeWriterTuple : (Typewriter.Model, Cmd Typewriter.Msg)
        typeWriterTuple = initTypeWriter
        typeWriterModel : Typewriter.Model
        typeWriterModel = Tuple.first typeWriterTuple
        typeWriterCmd : Cmd Typewriter.Msg
        typeWriterCmd = (Tuple.second typeWriterTuple)
    in
  ( Model Time.utc (Time.millisToPosix 0) typeWriterModel
  , Cmd.batch
      [ Task.perform Model.AdjustTimeZone Time.here
      , Task.perform Model.Tick Time.now
      ,  Cmd.map (\ a -> Model.TypewriterMsg a) typeWriterCmd
      ]
  )

initTypeWriter : (Typewriter.Model, Cmd Typewriter.Msg)
initTypeWriter = Typewriter.withWords [ "Developer", "Software-Craftmanship", "Fitness-Lover", "Arch-Linux-Enthusiasts"]
                |> withTypeDelay 200
                |> Typewriter.init
