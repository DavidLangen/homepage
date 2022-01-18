module Utils.TimeHelper exposing (..)

import Result exposing (map, withDefault)
import Time
import Date exposing (Unit(..), diff, fromIsoString, fromPosix)

bornYear : number
bornYear = 1996

bornDayInMonth : number
bornDayInMonth = 10

calculateCurrentAge : Time.Posix -> Time.Zone -> Int
calculateCurrentAge timePosix zone =
    let
        day = Time.toDay zone timePosix
        month = Time.toMonth zone timePosix
        year = Time.toYear zone timePosix
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



formatLastPush : Time.Posix -> Time.Zone-> String -> String
formatLastPush nowInPosix timeZone pushDateString =
    let
        now = (fromPosix timeZone nowInPosix)
        datePartOfString = String.split "T" pushDateString |> List.head |> Maybe.withDefault pushDateString
        maybeParsedDate : Result String Date.Date
        maybeParsedDate = (fromIsoString datePartOfString)
    in
    case maybeParsedDate of
        Err msg -> msg
        Ok _ ->
            maybeParsedDate
                |> map (formattedParsedPushDate now)
                |> withDefault pushDateString


formattedParsedPushDate : Date.Date -> Date.Date -> String
formattedParsedPushDate now parsedPushedDate =
    let
        years = diff Years parsedPushedDate now
        months = diff Months parsedPushedDate now
        weeks = diff Days parsedPushedDate now
        days = diff Days parsedPushedDate now
    in
    if days == 0 then
        "Today"
    else if days == 1 then
        "yesterday"
    else if days < 7 then
        String.fromInt days ++ " Days ago"
    else if weeks < 4 then
        String.fromInt weeks ++ " Weeks ago"
    else if months < 12 then
        String.fromInt months ++ " Months ago"
    else if years == 1 then
        "Last year"
    else
        String.fromInt years ++ " Years ago"