module Model exposing (..)
import Time
import Animator
import Typewriter
import GithubRepositories exposing (..)

type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  , writer: Typewriter.Model
  , checked : Animator.Timeline Bool
  , repoStatus : GithubRepositories.RepoStatus
  }

type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone
  | TypewriterMsg Typewriter.Msg
  | Check Bool
  | RepositoriesMsg GithubRepositories.RepoMsg


