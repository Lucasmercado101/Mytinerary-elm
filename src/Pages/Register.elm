module Pages.Register exposing (Model, Msg, init, update, view)

import Api.Auth exposing (User)
import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, form, img, input, label, p, text)
import Html.Attributes exposing (class, classList, disabled, for, href, id, placeholder, required, src, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Http exposing (Error(..))
import SvgIcons exposing (errorSvg)
import TailwindHelpers as TW exposing (..)


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



-- https://source.unsplash.com/featured/vacation


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
        [ div [ class "flex", TW.apply [ h_full ] ]
            [ div [ TW.apply [ w_full ], class "flex-1" ]
                [ div
                    [ TW.apply [ w_full, h_full, relative ]
                    , class "sm:block hidden"
                    ]
                    [ img
                        [ src "/assets/registerImage.jpg"
                        , class "object-cover object-left h-full sm:block hidden"
                        , TW.apply [ w_full, h_full ]
                        ]
                        []
                    , div
                        [ TW.apply
                            [ absolute
                            , bottom_0
                            , left_0
                            , bg_black
                            , w_full
                            , bg_opacity_75
                            ]
                        ]
                        [ div [ TW.apply [ p_2, text_white ] ]
                            [ text "Photo by "
                            , a [ TW.apply [ text_purple_400 ], href "https://unsplash.com/@seb_crdt?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" ]
                                [ text "sebastien cordat" ]
                            , text " on "
                            , a [ TW.apply [ text_purple_400 ], href "https://unsplash.com/s/photos/trip-city?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" ]
                                [ text "Unsplash" ]
                            ]
                        ]
                    ]
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
                    [ p
                        [ TW.apply
                            [ md [ text_4xl ]
                            , text_3xl
                            , font_semibold
                            ]
                        ]
                        [ text "Register a new account" ]
                    , form
                        [ onSubmit SubmitForm
                        , class
                            "flex flex-col shadow-sm"
                        , TW.apply [ gap_y_4 ]
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
                                , type_ "password"
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
                ]
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


empty : Html msg
empty =
    text ""
