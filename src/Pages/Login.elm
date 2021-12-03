port module Pages.Login exposing (Model, Msg, init, saveUserToLocalStorage, update, view)

import Api.Auth
import Browser
import Browser.Navigation as Nav
import Html exposing (br, button, div, form, img, input, label, p, text)
import Html.Attributes exposing (class, classList, disabled, for, id, placeholder, required, src, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Http
import SvgIcons exposing (errorSvg)
import TailwindHelpers as TW exposing (..)


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



-- https://source.unsplash.com/featured/vacationing


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
        [ div [ class "flex", TW.apply [ h_full ] ]
            [ div [ TW.apply [ w_full ], class "flex-1" ]
                [ img
                    [ src "/assets/loginImage.jpg"
                    , class "object-cover object-left h-full sm:block hidden"
                    , TW.apply [ w_full ]
                    ]
                    []
                ]
            , div
                [ TW.apply
                    [ w_full
                    , h_full
                    , sm [ max_w_xl, px_16 ]
                    , md [ max_w_2xl ]
                    , lg [ max_w_3xl ]
                    ]
                , class "flex"
                ]
                [ div
                    [ class "flex flex-col"
                    , TW.apply
                        [ w_full
                        , m_auto
                        , gap_y_4
                        , p_6
                        ]
                    ]
                    [ img [ src "/assets/mytinerary_logo.svg", TW.apply [ w_64 ] ] []
                    , p
                        [ TW.apply
                            [ md [ text_4xl ]
                            , text_3xl
                            , font_semibold
                            ]
                        ]
                        [ text "Sign in to your account" ]
                    , form
                        [ onSubmit SubmitForm
                        , class
                            "flex flex-col shadow-sm"
                        , TW.apply [ gap_y_4 ]
                        ]
                        [ div []
                            [ label
                                [ class "block text-gray-700"
                                , TW.apply
                                    [ font_bold
                                    , mb_2
                                    , text_sm
                                    ]
                                , for "username"
                                ]
                                [ text "Username" ]
                            , input
                                [ required True
                                , value username
                                , onInput ChangeUsername
                                , class "shadow appearance-none border rounded text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , TW.apply
                                    [ py_2
                                    , px_3
                                    , w_full
                                    ]
                                , id "username"
                                , placeholder "Username"
                                , type_ "text"
                                ]
                                []
                            ]
                        , div []
                            [ label
                                [ class "block text-gray-700"
                                , TW.apply [ font_bold, text_sm, mb_2 ]
                                , for "password"
                                ]
                                [ text "Password" ]
                            , input
                                [ required True
                                , value password
                                , onInput ChangePassword
                                , class "shadow appearance-none border rounded text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , TW.apply
                                    [ py_2
                                    , px_3
                                    , w_full
                                    ]
                                , id "password"
                                , placeholder "Password"
                                , type_ "text"
                                ]
                                []
                            ]
                        , button
                            [ type_ "submit"
                            , class "rounded"
                            , TW.apply [ font_bold, py_2, px_4 ]
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
                                div
                                    [ class "bg-red-100 flex rounded shadow-sm"
                                    , TW.apply [ w_full, gap_x_2, font_semibold, p_2 ]
                                    ]
                                    [ errorSvg
                                    , p [ class "text-red-700 flex" ]
                                        [ text
                                            (case err of
                                                Http.BadStatus code ->
                                                    case code of
                                                        404 ->
                                                            "A User with that username or password was not found"

                                                        _ ->
                                                            "An unknown error ocurred: code " ++ String.fromInt code

                                                _ ->
                                                    "An unknown error ocurred"
                                            )
                                        ]
                                    ]

                            _ ->
                                text ""
                        ]
                    ]
                ]
            ]
        ]
    }
