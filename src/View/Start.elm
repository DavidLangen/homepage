module View.Start exposing (..)

import GithubRepositories exposing (viewRepositories)
import Model exposing (Model, Msg)
import Utils.TimeHelper exposing (..)
import View.CustomColor exposing (..)
import View.Header exposing (headerHeight)

import Element exposing (..)
import Element.Background as Background exposing (..)
import Element.Border as Border
import Element.Font as Font
import Typewriter
import Element.Input as Input exposing (button)

import Html.Attributes as Attr exposing (class, href, style)
import Animator
import Animator.Inline
import View.CurriculumVitae exposing (vitaeAsTimeline)

helloText : Model -> Element msg
helloText m =
    let
         age = calculateCurrentAge m.time m.zone
    in
    column [ width fill, Font.color (rgb255 211 224 202)]
                                                   [
                                                    row[  centerX, Font.bold, Font.size 30] [
                                                        el [] <| text ("I am a " ++ (Typewriter.view m.writer))
                                                        , el [ htmlAttribute (Animator.Inline.opacity m.checked <|
                                                                                      \state ->
                                                                                          if state then
                                                                                              Animator.at 0

                                                                                          else
                                                                                              Animator.at 1
                                                            )] <| text "|"
                                                    ]
                                                   , paragraph [padding 10]
                                                       [ text ("Hi, ich heiße David und bin " ++ String.fromInt age ++ " Jahre alt. Ich begrüße dich herzlich auf meiner Webseite.") ]
                                                   ]



portrait : Element msg
portrait = Element.image (withButtonEffectAnd [ height<| px 350
                           , width <| px 500
                           , Border.rounded 200
                           , clip
                           ])
                           { src = "images/portrait.jpg"
                           , description = "Portrait of me" }

middle : Model -> Element Msg
middle model =
    let
        marginToHeader = 0
        imageMarginRight = 350
        textPadding = 20
    in
    column [width fill, height fill, View.CustomColor.backgroundGradient, spacing 20, padding 30
            ][
        row [width fill, height (px View.Header.headerHeight)] [],
        row [width fill, spacing 30]
            [
            column [width fill] [ Element.el [centerX, padding textPadding] (helloText model) ]
            ,column [width fill] [ Element.el [centerX] (portrait)]
            ]
        , row [width fill][contentBelow model]
        ]

contentBelow : Model -> Element Msg
contentBelow model = column[width fill, centerX
                      , Font.color (rgb255 255 255 255)
                      , spacing 20
                      ]
                      [
                              passionParagraph "paragraph1",
                              repoParagraph "repos" model,
                              Element.el (withButtonEffectAnd [width fill, spacing 10, padding 20, Border.width 1, centerX]) ( row [ centerX][vitaeAsTimeline])

                      ]



passionParagraph : String -> Element msg
passionParagraph id =
    paragraph (withButtonEffectAnd [ spacing 10, padding 20, Border.width 1, htmlAttribute (Attr.id id)]) [ text "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet." ]


repoParagraph : String -> Model -> Element msg
repoParagraph id model =
    paragraph (withButtonEffectAnd [ spacing 10, padding 20, Border.width 1, htmlAttribute (Attr.id id)]) [viewRepositories model.time model.zone model.repoStatus]


buttonEffect : List (Attribute msg)
buttonEffect = [Border.color backgroundColorLight, Border.widthEach {bottom = 0, left = 5, top = 5, right = 0}
                               , Border.shadow { offset = ( 5, 4.5 )
                                                 , size = 5
                                                 , blur = 5
                                                 , color = backgroundColorDark
                                                }]

withButtonEffectAnd : List (Attribute msg) -> List (Attribute msg)
withButtonEffectAnd otherAttributes =
                        List.concat [buttonEffect, otherAttributes]


