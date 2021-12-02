port module Pages.Login exposing (Model, Msg, init, update, view)

import Api.Auth
import Browser
import Browser.Navigation as Nav
import Html exposing (br, button, div, form, input, label, p, text)
import Html.Attributes exposing (class, classList, disabled, for, id, placeholder, required, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Http
import SvgIcons exposing (errorSvg)


port saveUserToLocalStorage : UserData -> Cmd msg


type alias Model =
    { username : String
    , password : String
    , logInState : LogInState
    , key : Nav.Key
    }


type LogInState
    = Idle
    | LoggingIn
    | Error Http.Error


type Msg
    = ChangeUsername String
    | ChangePassword String
    | SubmitForm
    | GotUserData (Result Http.Error UserData)


type alias UserData =
    { id : Int
    , username : String
    , profile_pic : Maybe String
    }


init : Nav.Key -> ( Model, Cmd msg )
init key =
    ( { username = ""
      , password = ""
      , logInState = Idle
      , key = key
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeUsername username ->
            ( { model | username = username }, Cmd.none )

        ChangePassword password ->
            ( { model | password = password }, Cmd.none )

        SubmitForm ->
            ( { model | logInState = LoggingIn }, Api.Auth.logIn model GotUserData )

        GotUserData res ->
            case res of
                Result.Ok data ->
                    ( model, Cmd.batch [ saveUserToLocalStorage data, Nav.pushUrl model.key "/" ] )

                Result.Err err ->
                    ( { model | logInState = Error err }, Cmd.none )


view : Model -> Browser.Document Msg
view { password, username, logInState } =
    { title = "Log In"
    , body =
        let
            registerDisabled =
                password
                    == ""
                    || username
                    == ""
                    || (case logInState of
                            LoggingIn ->
                                True

                            _ ->
                                False
                       )
        in
        [ form
            [ onSubmit SubmitForm
            , class
                "flex flex-col container mx-auto px-4 gap-y-4"
            ]
            [ div []
                [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "username" ]
                    [ text "Username" ]
                , input
                    [ required True
                    , value username
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
                    [ required True
                    , value password
                    , onInput ChangePassword
                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    , id "password"
                    , placeholder "Password"
                    , type_ "text"
                    ]
                    []
                ]
            , button
                [ type_ "submit"
                , class "font-bold py-2 px-4 rounded"
                , classList
                    [ ( "bg-blue-700 hover:bg-blue-700 text-white", not registerDisabled )
                    , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", registerDisabled )
                    ]
                , disabled registerDisabled
                ]
                [ case logInState of
                    Idle ->
                        text "Log In"

                    LoggingIn ->
                        text "Logging In.."

                    Error _ ->
                        text "Log In"
                ]
            , case logInState of
                Error err ->
                    div [ class "mx-auto w-full md:w-72 block font-bold rounded" ]
                        [ div [ class "bg-red-100 p-2 font-semibold flex gap-x-2" ]
                            [ errorSvg
                            , p [ class "text-red-700" ]
                                [ text
                                    (case err of
                                        Http.BadStatus code ->
                                            case code of
                                                400 ->
                                                    "Bad request"

                                                401 ->
                                                    "Unauthorized"

                                                404 ->
                                                    "Not found"

                                                _ ->
                                                    "An unknown error ocurred: code " ++ String.fromInt code

                                        _ ->
                                            "An unknown error ocurred"
                                    )
                                ]
                            ]
                        ]

                _ ->
                    text ""
            ]
        ]
    }
