module Update exposing (..)

import Model exposing (Model, Msg)
import Task
import Time
import Typewriter
import Animator
import Subscriptions exposing (animator)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Model.Tick newTime ->
      ( Animator.update newTime animator { model | time = newTime, checked = model.checked |> Animator.go (Animator.millis 300) (not (Animator.current model.checked)) }
      , Cmd.none
      )

    Model.AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )

    Model.Check newChecked ->
                ( { model
                    | checked =
                        -- (6) - Here we're adding a new state to our timeline.
                        model.checked
                            |> Animator.go Animator.quickly newChecked
                  }
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
