module Utils.TimeHelper exposing (..)

import Model exposing (Model)
import Time

myCurrentAge : Model -> Int
myCurrentAge model =
    let
        day = Time.toDay model.zone model.time
        month = Time.toMonth model.zone model.time
        year = Time.toYear model.zone model.time
        myAge = year - 1996
    in
    case month of
        Time.Dec -> myAge
        Time.Nov -> myAge
        Time.Oct -> myAge
        Time.Sep -> myAge
        Time.Aug -> myAge
        Time.Jul -> myAge
        Time.Jun -> if day >= 10 then myAge else myAge - 1
        _ -> myAge - 1
