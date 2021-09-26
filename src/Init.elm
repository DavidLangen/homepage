module Init exposing (..)

import Model exposing (Model, Msg)
import Task
import Time


init : () -> (Model, Cmd Msg)
init _ =
  ( Model Time.utc (Time.millisToPosix 0)
  , Cmd.batch
      [ Task.perform Model.AdjustTimeZone Time.here
      , Task.perform Model.Tick Time.now
      ]
  )
