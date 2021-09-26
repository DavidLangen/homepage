module Model exposing (..)
import Time
import Animator
import Typewriter

type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  , writer: Typewriter.Model
  }



type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone
  | TypewriterMsg Typewriter.Msg


