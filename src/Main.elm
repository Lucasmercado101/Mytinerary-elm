module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (attribute, class, src)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url, Cmd.none )


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view _ =
    { title = "Application Title"
    , body =
        [ img [ src "../assets/heroBgr.jpg", class "landing-bg" ] []
        , navbar

        --  div []
        -- [ text "New Application" ]
        ]
    }


navbar : Html msg
navbar =
    nav [ attribute "aria-label" "main navigation", class "navbar", attribute "role" "navigation" ]
        [ div [ class "navbar-brand" ]
            [ a
                [ class "navbar-item" ]
                [ img [ attribute "height" "28", src "https://bulma.io/images/bulma-logo.png", attribute "width" "112" ]
                    []
                ]
            , a [ attribute "aria-expanded" "false", attribute "aria-label" "menu", class "navbar-burger", attribute "data-target" "navbarBasicExample", attribute "role" "button" ]
                [ span [ attribute "aria-hidden" "true" ]
                    []
                , span [ attribute "aria-hidden" "true" ]
                    []
                , span [ attribute "aria-hidden" "true" ]
                    []
                ]
            ]
        , div [ class "navbar-menu" ]
            [ div [ class "navbar-start" ]
                [ a [ class "navbar-item" ]
                    [ text "Home      " ]
                , a [ class "navbar-item" ]
                    [ text "Documentation      " ]
                , div [ class "navbar-item has-dropdown is-hoverable" ]
                    [ a [ class "navbar-link" ]
                        [ text "More        " ]
                    , div [ class "navbar-dropdown" ]
                        [ a [ class "navbar-item" ]
                            [ text "About          " ]
                        , a [ class "navbar-item" ]
                            [ text "Jobs          " ]
                        , a [ class "navbar-item" ]
                            [ text "Contact          " ]
                        , hr [ class "navbar-divider" ]
                            []
                        , a [ class "navbar-item" ]
                            [ text "Report an issue          " ]
                        ]
                    ]
                ]
            , div [ class "navbar-end" ]
                [ div [ class "navbar-item" ]
                    [ div [ class "buttons" ]
                        [ a [ class "button is-primary" ]
                            [ strong []
                                [ text "Sign up" ]
                            ]
                        , a [ class "button is-light" ]
                            [ text "Log in          " ]
                        ]
                    ]
                ]
            ]
        ]
