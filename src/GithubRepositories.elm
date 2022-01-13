module GithubRepositories exposing (..)

import Dict
import Element.Background as Background
import Element.Font as Font
import Element exposing (..)
import Element.Border as Border
import Http
import Json.Decode as JD
import View.CustomColor as CustomColor
import View.CustomIcons as CustomIcons exposing (arrowIcon)

-- Model
type RepoStatus = ReposLoading | ReposLoaded Repositories| ReposLoadedFailed

type alias Repository = {
              name: String,
              url: String,
              language: String,
              description: Maybe String,
              size: Int,
              lastPush: String
            }

type alias Repositories = List Repository

type RepoMsg = Noop | GetRepos | GotRepos (Result Http.Error Repositories)

-- update and load Repositories

updateRepos : RepoMsg -> RepoStatus -> (RepoStatus, Cmd RepoMsg)
updateRepos msg model =
    case msg of
        Noop -> (model, Cmd.none)
        GetRepos -> (ReposLoading, loadRepos)
        GotRepos result ->
            case result of
                Ok repos -> (ReposLoaded repos, Cmd.none)
                Err err ->let
                              msg0 = Debug.log "Error during fetching from Github:" err
                          in
                           (ReposLoadedFailed, Cmd.none)



loadRepos : Cmd RepoMsg
loadRepos = Http.get {
        url = "https://api.github.com/users/DavidLangen/repos"
        , expect = Http.expectJson GotRepos repositoriesParser
     }

repositoryParser : JD.Decoder Repository
repositoryParser =
    JD.map6 Repository
        (JD.field "name" JD.string)
        (JD.field "url" JD.string)
        (JD.field "language" JD.string)
        (JD.field "description" (JD.maybe JD.string))
        (JD.field "size" JD.int)
        (JD.field "updated_at" JD.string)

repositoriesParser : JD.Decoder (List Repository)
repositoriesParser = JD.list repositoryParser

-- view Repositories

viewRepositories : RepoStatus -> Element msg
viewRepositories repoModel =
     case repoModel of
         ReposLoaded repositories->
             column [width fill] [wrappedRow[width fill, spacing 10] (List.map buildRepositoryCard repositories)]
         ReposLoadedFailed ->
            text  "Es ist ein Fehler beim Laden der Github Repos entstanden."
         ReposLoading ->
             text "Loading...."

buildRepositoryCard : Repository -> Element msg
buildRepositoryCard repository =
    column [padding 30, Border.width 1, Border.rounded 100, width <| px 500] [
            column [centerX, width fill] [
                row [centerX, width fill, spacingXY 80 0] [
                    el [moveRight 10] (languageWordToLogo repository.language)
                    ,el [centerX, width fill] (text repository.name)
                ]
            ]
            ,column [paddingXY 0 10, spacing 5, centerX] [
                    el [centerX] (image [width <|px 250, height <|px 250, Border.rounded 100, clip] {src = "images/github_dark.png", description = "Picture"})
                    ,el [Font.size 15, centerX] (text ("Size: " ++ String.fromInt repository.size ++ " Kb"))
            ]
            ,column [paddingXY 0 10, spacing 50, centerX] [
                    row [spacingXY 10 0] [
                            el [Font.color CustomColor.applegreen] (arrowIcon)
                            ,el [width fill] (text ("Last updated: " ++ repository.lastPush))
                        ]
                    ,el [Font.italic, height<| px 50] (descriptionOrDefaultText repository.description)
                    ,el [centerX, Border.rounded 10, padding 10, Background.color CustomColor.applegreen] (Element.newTabLink [] {url=repository.url, label=(text "Code")})
                ]
            ]

descriptionOrDefaultText : Maybe String -> Element msg
descriptionOrDefaultText desc = text <| Maybe.withDefault "" desc


languageWordToLogo : String -> Element msg
languageWordToLogo languageWord =
    let
        logoDic = Dict.fromList [
              ("Dockerfile", "https://raw.githubusercontent.com/gilbarbara/logos/master/logos/docker-icon.svg")
              , ("Shell", "https://raw.githubusercontent.com/gilbarbara/logos/master/logos/bash-icon.svg")
              , ("Java", "https://raw.githubusercontent.com/gilbarbara/logos/master/logos/java.svg")
              , ("Haskell", "https://raw.githubusercontent.com/gilbarbara/logos/master/logos/haskell-icon.svg")
              , ("C#", "https://raw.githubusercontent.com/gilbarbara/logos/master/logos/c-sharp.svg")
              , ("Elm", "https://raw.githubusercontent.com/gilbarbara/logos/master/logos/elm.svg")
             ]
    in
    Maybe.withDefault (text "Logo")
            <| Maybe.map
                    (\url -> image [width <| px 30, height <| px 30] {src= url, description = "Language Logo for " ++ languageWord})
                    (Dict.get languageWord logoDic)

