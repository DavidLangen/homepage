module Utils.TimeHelper exposing (..)

import Model exposing (Model)
import Time

bornYear : number
bornYear = 1996

bornDayInMonth : number
bornDayInMonth = 10

calculateCurrentAge : Model -> Int
calculateCurrentAge model =
    let
        day = Time.toDay model.zone model.time
        month = Time.toMonth model.zone model.time
        year = Time.toYear model.zone model.time
        myAge = year - bornYear
    in
    case month of
        Time.Dec -> myAge
        Time.Nov -> myAge
        Time.Oct -> myAge
        Time.Sep -> myAge
        Time.Aug -> myAge
        Time.Jul -> myAge
        Time.Jun -> if day >= bornDayInMonth then myAge else myAge - 1
        _ -> myAge - 1
