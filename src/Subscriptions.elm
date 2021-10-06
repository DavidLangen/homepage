module Subscriptions exposing (..)

import Model exposing (Model, Msg)
import Time
import Animator

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch [
            Time.every 1000 Model.Tick
            ,  animator |> Animator.toSubscription Model.Tick model
        ]


animator : Animator.Animator Model
animator =
    Animator.animator
        |> Animator.watching
            -- we tell the animator how
            -- to get the checked timeline using .checked
            .checked
            -- and we tell the animator how
            -- to update that timeline as well
            (\newChecked model ->
                { model | checked = newChecked }
            )

