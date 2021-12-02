module Common exposing (Request)


type Request a b
    = Loading
    | Loaded a
    | Error b
