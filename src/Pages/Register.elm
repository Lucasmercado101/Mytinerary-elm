module Pages.Register exposing (Model, Msg, init, update, view)

import Browser
import Html exposing (div, form, input, label, text)
import Html.Attributes exposing (class, for, id, placeholder, type_, value)
import Html.Events exposing (onInput)


type alias Model =
    { username : String
    , password : String
    }


type Msg
    = ChangeUsername String
    | ChangePassword String


init : ( Model, Cmd msg )
init =
    ( { username = "", password = "" }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ChangeUsername username ->
            ( { model | username = username }, Cmd.none )

        ChangePassword password ->
            ( { model | password = password }, Cmd.none )


view : Model -> Browser.Document Msg
view { password, username } =
    { title = "Register"
    , body =
        [ form [ class "flex flex-col container mx-auto px-4 gap-y-4" ]
            [ div []
                [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "username" ]
                    [ text "Username" ]
                , input
                    [ value username
                    , onInput ChangeUsername
                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    , id "username"
                    , placeholder "Username"
                    , type_ "text"
                    ]
                    []
                ]
            , div []
                [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "password" ]
                    [ text "Password" ]
                , input
                    [ value password
                    , onInput ChangePassword
                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    , id "password"
                    , placeholder "Password"
                    , type_ "text"
                    ]
                    []
                ]
            ]
        ]
    }
