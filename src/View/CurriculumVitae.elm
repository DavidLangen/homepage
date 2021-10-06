module View.CurriculumVitae exposing (vitaeAsTimeline, TimelineRowContent)

import Html
import Html.Attributes exposing (wrap)
import Collage exposing (circle, rectangle, filled, outlined, uniform, path, Point, traced, defaultLineStyle, rendered, invisible)
import Collage.Layout exposing (at, top, left, bottom, showOrigin, showEnvelope, debug, connect, right, base, horizontal, name, vertical, spacer, align)
import Collage.Render exposing (svg)
import Collage.Text exposing (size, large, shape, Shape, weight, normal)
import Color
import View.CustomColor
import Element exposing (..)

timelineColor : Collage.FillStyle
timelineColor = Color.rgb255 178 178 178 |> uniform

type alias TimelineRowContent = {year:YearAsString, explainText:ExplainText}
type alias ExplainText = { title:String, text:String}
type alias YearAsString = String


timelineStyle : Collage.LineStyle
timelineStyle = {defaultLineStyle | fill = timelineColor}

vitaeAsTimeline : Element msg
vitaeAsTimeline = generateVitaeAsSvg [
        {year = "2016", explainText = {title="Ausbildung im b.i.b.",
                                        text = "Progammieren gelerent und so."}},
        { year = "2018", explainText = {title = "Student bei der FHDW",
                                            text="Studiert und so ein Kram."}},
        { year = "2020", explainText = {title = "Arbeiten bei klose brothers GmBH",
                                            text="Hier steht alles, was ich da so gemacht habe."}}
        ] |> Element.html


generateVitaeAsSvg : List TimelineRowContent -> Html.Html msg
generateVitaeAsSvg entries =
                          let
                              mappedIndexBaseAnchorList = List.indexedMap
                                                            (\index _ -> (String.fromInt index, base)) entries
                          in
                              List.indexedMap generateTimelinePoint entries
                              |> vertical
                              |> connect mappedIndexBaseAnchorList
                                        {defaultLineStyle | fill = timelineColor}
                              --|> debug
                              |> svg


generateTimelinePoint : Int -> TimelineRowContent -> Collage.Collage msg
generateTimelinePoint index content =
                                    let
                                      circ = circle 10
                                              |> filled timelineColor
                                      timelinePointInTheMiddle n =  invisibleBoxForAlignmentCenter
                                              |> at base circ
                                              |> name n
                                      indexAsString = String.fromInt index
                                    in
                                        if modBy 2 index == 0 then
                                            (horizontal [createYearCollage content.year, timelinePointInTheMiddle (indexAsString), explainText content.explainText ])
                                            |> connect [(content.year, right), ((indexAsString), base)] timelineStyle
                                        else
                                            (horizontal [ explainText content.explainText, timelinePointInTheMiddle (indexAsString),createYearCollage content.year])
                                            |> connect [(content.year, left), ((String.fromInt index), base)] timelineStyle


createYearCollage : String -> Collage.Collage msg
createYearCollage yearAsString =
                    let
                        outerCircle = circle 40
                                      |> outlined timelineStyle
                                      |>  name yearAsString
                    in
                    invisibleBoxForAlignment
                    |> at base outerCircle
                    |> at base (textFromStringForExplainTitle yearAsString)

explainText : ExplainText -> Collage.Collage msg
explainText t = invisibleBoxForAlignment
                |> at base (textFromStringForExplainTextBottom t.text)
                |> at top (textFromStringForExplainTitle t.title)


textFromStringForExplainTitle : String -> Collage.Collage msg
textFromStringForExplainTitle s = Collage.Text.fromString s
                    |> Collage.Text.color Color.white
                    |> size large
                    |> weight Collage.Text.Bold
                    |> Collage.rendered


textFromStringForExplainTextBottom : String -> Collage.Collage msg
textFromStringForExplainTextBottom contentString =
                    let
                        breakAllAttr = Html.Attributes.style "word-break" "break-all"
                        whiteSpaceNormalAttr = Html.Attributes.style "white-space" "normal"
                        padd = Html.Attributes.style "padding" "20px"
                    in
                    Html.p [breakAllAttr, whiteSpaceNormalAttr, padd] [Html.i [] [Html.text contentString]]
                    |> Collage.html (400, 150) []

--- Fixes and Alignment

--wrapText textSize = 2

invisibleBoxForAlignment : Collage.Collage msg
invisibleBoxForAlignment = spacer 400 10

invisibleBoxForAlignmentCenter : Collage.Collage msg
invisibleBoxForAlignmentCenter = spacer 100 100
