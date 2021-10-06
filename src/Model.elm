module Model exposing (..)
import Time
import Animator
import Typewriter

type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  , writer: Typewriter.Model
  , checked : Animator.Timeline Bool
  }



type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone
  | TypewriterMsg Typewriter.Msg
  | Check Bool


