module Pages.Register exposing (Model, Msg, init, update, view)

import Browser
import Html exposing (div, text)


type alias Model =
    { username : String
    , password : String
    }


type Msg
    = Register


init : ( Model, Cmd msg )
init =
    ( { username = "", password = "" }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Browser.Document msg
view _ =
    { title = "Register"
    , body =
        [ div []
            [ text "On register!"
            ]
        ]
    }
