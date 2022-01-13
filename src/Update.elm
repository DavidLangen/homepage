module Update exposing (..)

import GithubRepositories exposing (updateRepos)
import Model exposing (Model, Msg)
import Tuple exposing (first, second)
import Typewriter
import Animator
import Subscriptions exposing (animator)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Model.Tick newTime ->
      ( Animator.update newTime animator { model | time = newTime, checked = model.checked |> Animator.go (Animator.millis 300) (not (Animator.current model.checked)) }
      , Cmd.none
      )

    Model.AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )

    Model.Check newChecked ->
                ( { model
                    | checked =
                        -- (6) - Here we're adding a new state to our timeline.
                        model.checked
                            |> Animator.go Animator.quickly newChecked
                  }
                , Cmd.none
                )

    Model.RepositoriesMsg repoMsg -> let
                                        updatedRepoStatus : (GithubRepositories.RepoStatus, Cmd GithubRepositories.RepoMsg)
                                        updatedRepoStatus = (updateRepos repoMsg model.repoStatus)
                                     in
                                     (
                                          { model | repoStatus = (first updatedRepoStatus)}
                                        , Cmd.map (\a -> Model.RepositoriesMsg a) (second updatedRepoStatus)
                                     )
    Model.TypewriterMsg twMsg ->
                    let
                        typeWriterTuple : (Typewriter.Model, Cmd Typewriter.Msg)
                        typeWriterTuple = (Typewriter.update twMsg model.writer)
                        typeWriterModel : Typewriter.Model
                        typeWriterModel =Tuple.first typeWriterTuple
                        typeWriterCmd : Cmd Typewriter.Msg
                        typeWriterCmd = (Tuple.second typeWriterTuple)
                    in
                    (
                    {
                      model | writer = typeWriterModel}
                    , Cmd.map (\ a -> Model.TypewriterMsg a) typeWriterCmd
                    )
