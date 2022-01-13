module GithubRepositories exposing (..)

import Element exposing (..)
import Http
import Json.Decode as JD

-- Model
type RepoStatus = ReposLoading | ReposLoaded Repositories| ReposLoadedFailed

type alias Repository = {
              name: String,
              url: String,
              language: String,
              description: Maybe String,
              lastPush: Maybe String
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
                Err _ -> (ReposLoadedFailed, Cmd.none)



loadRepos : Cmd RepoMsg
loadRepos = Http.get {
        url = "https://api.github.com/users/DavidLangen/repos"
        , expect = Http.expectJson GotRepos repositoriesParser
     }

repositoryParser : JD.Decoder Repository
repositoryParser =
    JD.map5 Repository
        (JD.field "name" JD.string)
        (JD.field "url" JD.string)
        (JD.field "language" JD.string)
        (JD.field "description" (JD.maybe JD.string))
        (JD.field "updated_at" (JD.maybe JD.string))

repositoriesParser : JD.Decoder (List Repository)
repositoriesParser = JD.list repositoryParser

-- view Repositories

viewRepositories : RepoStatus -> Element msg
viewRepositories repoModel =
     case repoModel of
         ReposLoaded repositories->
            text  "Repos konnten geladen werden. TODO: add Card Layout"
         ReposLoadedFailed ->
            text  "Es ist ein Fehler beim Laden der Github Repos entstanden."
         ReposLoading ->
             text "Loading...."


