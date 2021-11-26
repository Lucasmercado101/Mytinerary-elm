module Pages.Register exposing (Model, Msg, init, update, view)

import Api.Auth exposing (User)
import Browser
import Browser.Navigation as Nav
import Html exposing (Html, button, div, form, input, label, p, text)
import Html.Attributes exposing (class, classList, disabled, for, id, placeholder, required, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Http exposing (Error(..))
import Svg exposing (svg)
import Svg.Attributes


type alias Model =
    { username : String
    , password : String
    , registeringState : RegisteringState
    , key : Nav.Key
    }


type RegisteringState
    = Idle
    | Registering
    | Error Http.Error


type Msg
    = ChangeUsername String
    | ChangePassword String
    | SubmitForm
    | GotUserData (Result Http.Error User)


init : Nav.Key -> ( Model, Cmd msg )
init key =
    ( { username = ""
      , password = ""
      , registeringState = Idle
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
            ( { model | registeringState = Registering }, Api.Auth.registerUser model GotUserData )

        GotUserData res ->
            case res of
                Result.Ok _ ->
                    ( model, Nav.pushUrl model.key "/login" )

                Result.Err err ->
                    ( { model | registeringState = Error err }, Cmd.none )


view : Model -> Browser.Document Msg
view { password, username, registeringState } =
    { title = "Register"
    , body =
        let
            registerDisabled =
                password == "" || username == ""
        in
        [ form
            [ onSubmit SubmitForm
            , class
                "flex flex-col container mx-auto px-4 gap-y-4 pt-5"
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
                [ text "Register" ]
            , case registeringState of
                Idle ->
                    empty

                Registering ->
                    empty

                Error err ->
                    case err of
                        BadStatus int ->
                            if int == 409 then
                                error [ text ("Username \"" ++ username ++ "\" is already taken.") ]

                            else
                                error [ text ("Bad status code: " ++ String.fromInt int) ]

                        _ ->
                            error [ text "Unknown error" ]
            ]
        ]
    }


error : List (Html msg) -> Html msg
error content =
    -- design: https://mui.com/components/alert/
    div [ class "flex p-4 bg-red-100 rounded-md gap-x-2" ]
        [ errorSvg
        , div [ class "flex flex-col gap-y-1" ]
            [ p [ class "font-bold text-l" ] [ text "Error" ]
            , p [] content
            ]
        ]


errorSvg : Html msg
errorSvg =
    svg
        [ Svg.Attributes.class "h-6 w-6 text-red-500"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
            ]
            []
        ]


empty : Html msg
empty =
    text ""
