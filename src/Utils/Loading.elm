module Utils.Loading exposing (Loading(..))


type Loading a
    = NotLoaded
    | Loaded a
    | Error String