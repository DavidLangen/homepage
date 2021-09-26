module Main exposing (main)

import Model exposing (Model, Msg)
import Init exposing (init)
import Update exposing (update)
import Subscriptions exposing (subscriptions)
import View exposing (view)

import Browser

main : Program () Model Msg
main = Browser.element {
                    init = Init.init,
                    view = View.view,
                    update = Update.update,
                    subscriptions = Subscriptions.subscriptions
       }
