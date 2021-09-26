module Main exposing (footer, header, main, middle, navbar, view)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input exposing (button)
import Element.Region as Region
import Html
import Html.Attributes as Attr exposing (class, href, style)
import Html exposing (Html)
import Task
import Time


main : Program () Model Msg
main = Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model Time.utc (Time.millisToPosix 0)
  , Cmd.batch
      [ Task.perform AdjustTimeZone Time.here
      , Task.perform Tick Time.now
      ]
  )

-- UPDATE


type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ( { model | time = newTime }
      , Cmd.none
      )

    AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 Tick







view : Model -> Html.Html msg
view m = Element.layout [inFront <| header] <|
    column [ width fill, height fill] [middle m, footer ]


navbar =
    Element.row
        [ Region.navigation
        , alignTop
        ]
        [ link [ headerMouseOverEffect ] { url = "#paragraph5", label = text "Passion" } ]

headerMouseOverEffect : Attribute msg
headerMouseOverEffect = mouseOver [ Font.color (rgb255 0 177 0)]

githubIcon : Element msg
githubIcon = (Element.html (Html.i [ class "fab fa-github" ] []))

helloText : Model -> Element msg
helloText m =
    let
         age = myCurrentAge m
    in
    column [ width fill, spacing 10, Font.color (rgb255 211 224 202) ]
                                                   [ el [ centerX, Font.bold ] <| text "Me, Myself & I"
                                                   , paragraph [ width <| maximum 300 fill, centerX]
                                                       [ text ("Hi, ich heiße David und bin " ++ String.fromInt age ++ " Jahre alt. Ich begrüße dich herzlich auf meiner Webseite.") ]
                                                   ]

header =
    row
        [ Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , width fill
        , paddingXY 20 10
        , Font.color (rgb255 105 108 115)
        , Background.color (rgb255 18 19 15)
        ,alpha 0.7
        ]
        [ navbar, Element.el [alignRight] (link [headerMouseOverEffect] {url="https://github.com/DavidLangen", label = githubIcon })]

startImg : Element msg
startImg = image [ height<| px 500, width fill ]
                                                         { src = "images/David_Profilbild_Green9216x3456.png"
                                                         , description = "Portrait of me"
                                                         }
middle m =
    let
        h = Element.el [centerY, alignRight, moveLeft 200] (helloText m)
    in
    column [width fill][
    row [width fill, height <| px 500] -- Background.gradient {angle=Basics.pi/2, steps=[(rgb255 0 0 0), (rgb255 0 0 0), (rgb255 54 54 51)]}
        [
        Element.el [inFront(h), width fill, height fill] (startImg)
                                       ],
    row
        [ height fill
        , Font.color (rgb255 255 255 255)
        , Background.color (rgb255 0 0 0)
        ]
        [ column [ width fill, paddingXY 300 100, spacing 60 ]
            [
                para "paragraph1"
            ]
        ]]


middle2 : Model -> Element msg
middle2 m =
    row
        [ height fill
        , Font.color (rgb255 114 127 140)
        , Background.color (rgb255 52 58 64)
        ]
        [ column [ width fill, paddingXY 300 100, spacing 60 ]
            [ ichPara m,
                para "paragraph1"
            ]
        ]

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


ichPara model =
    let
        age = myCurrentAge model
    in
    row [ explain Debug.todo,width fill, height fill, padding 50, spacing 20, Border.width 1 ] [column
                              [ width fill, Border.width 1] [ el [ centerX, clip] <|
                                  image [ width <| px 500, height <| px 700 ]
                                                                        { src = "images/portrait.jpg"
                                                                        , description = "Portrait of me"
                                                                        }
                              ]
                          , column [ width fill, spacing 10 ]
                              [ el [ centerX, Font.bold ] <| text "Me, Myself & I"
                              , paragraph [ width <| maximum 300 fill, centerX]
                                  [ text ("Hi, ich heiße David und bin " ++ String.fromInt age ++ " Jahre alt. Ich begrüße dich herzlich auf meiner Webseite.") ]
                              ]]



para id =
    paragraph [ spacing 10, padding 20, Border.width 1, htmlAttribute (Attr.id id) ] [ text "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet." ]


footer =
    row
        [ paddingXY 10 10
        , width fill
        , Background.color (rgb255 34 37 42)
        , Font.color (rgb255 105 108 115)
        ]
        [ row [ centerX ] [ text "footer" ] ]
