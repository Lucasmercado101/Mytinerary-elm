module Pages.Register exposing (Model, Msg, init, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (button, div, form, input, label, text)
import Html.Attributes exposing (class, classList, disabled, for, id, placeholder, required, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Http exposing (expectJson, post)
import Json.Decode exposing (Decoder, field, int, map2, string)
import Json.Encode as Encode exposing (object)


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
    | GotUserData (Result Http.Error UserData)


init : Nav.Key -> ( Model, Cmd msg )
init key =
    ( { username = ""
      , password = ""
      , registeringState = Idle
      , key = key
      }
    , Cmd.none
    )


type alias UserData =
    { id : Int
    , username : String
    }


userDecoder : Decoder UserData
userDecoder =
    map2 UserData
        (field "id" int)
        (field "username" string)


baseUrl =
    "http://localhost:8001"


registerPost : Model -> Cmd Msg
registerPost model =
    Http.post
        { url = baseUrl ++ "/auth/register"
        , body =
            Http.jsonBody <|
                object
                    [ ( "username", Encode.string model.username )
                    , ( "password", Encode.string model.password )
                    ]
        , expect = Http.expectJson GotUserData userDecoder
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeUsername username ->
            ( { model | username = username }, Cmd.none )

        ChangePassword password ->
            ( { model | password = password }, Cmd.none )

        SubmitForm ->
            ( { model | registeringState = Registering }, registerPost model )

        GotUserData res ->
            case res of
                Result.Ok _ ->
                    ( { model | username = "" }, Nav.pushUrl model.key "/login" )

                Result.Err err ->
                    ( { model | registeringState = Error err }, Cmd.none )


view : Model -> Browser.Document Msg
view { password, username } =
    { title = "Register"
    , body =
        let
            registerDisabled =
                password == "" || username == ""
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
                [ text "Register" ]
            ]
        ]
    }