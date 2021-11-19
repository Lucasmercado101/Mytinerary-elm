module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (attribute, class, src, style)
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
        , hero [ class "is-fullheight" ]
            [ heroHead []
                [ navbar [ class "has-background-white" ]
                    [ mobileNavbar ]
                ]
            , heroBody []
                [ columns [ class "is-3 is-variable is-fullwidth is-flex-tablet is-vcentered container mx-auto" ]
                    [ columns [ class "column is-multiline" ]
                        [ col [ class "is-full" ] [ img [ src "../assets/mytinerary_logo.svg" ] [] ]
                        , col [ class "is-full" ]
                            [ p [ class "has-text-white is-size-3-tablet is-size-4-mobile", style "line-height" "1.4" ]
                                [ text "Find your perfect trip, designed by insiders who know and love their\n          cities."
                                ]
                            ]
                        ]
                    , col [ class "has-text-centered" ]
                        [ img [ style "max-height" "180px", src "../assets/arrowRight.svg" ] []
                        ]
                    ]
                ]
            ]
        ]
    }


mobileNavbar : Html msg
mobileNavbar =
    div [ class "navbar-brand" ]
        [ a [ class "navbar-item" ]
            [ p [ style "color" "red", class "has-text-weight-semibold" ] [ text "Mytinerary" ]
            ]
        , div [ class "navbar-burger" ]
            [ span [ attribute "aria-hidden" "true" ]
                []
            , span [ attribute "aria-hidden" "true" ]
                []
            , span [ attribute "aria-hidden" "true" ]
                []
            ]
        ]



{-
   Bulma helpers
-}


col : List (Attribute msg) -> List (Html msg) -> Html msg
col attr html =
    div (List.append attr [ class "column" ]) html


columns : List (Attribute msg) -> List (Html msg) -> Html msg
columns attr html =
    div (List.append attr [ class "columns" ]) html


hero : List (Attribute msg) -> List (Html msg) -> Html msg
hero attr html =
    section (List.append attr [ class "hero" ]) html


heroBody : List (Attribute msg) -> List (Html msg) -> Html msg
heroBody attr html =
    div (List.append attr [ class "hero-body" ]) html


heroHead : List (Attribute msg) -> List (Html msg) -> Html msg
heroHead attr html =
    div (List.append attr [ class "hero-head" ]) html


navbar : List (Attribute msg) -> List (Html msg) -> Html msg
navbar attr html =
    div (List.append attr [ class "navbar" ]) html
