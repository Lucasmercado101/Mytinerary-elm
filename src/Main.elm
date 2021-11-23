module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Attribute, Html, a, div, img, p, section, span, text)
import Html.Attributes exposing (attribute, class, href, src, style)
import Pages.Cities as Cities exposing (Model, Msg, init, view)
import Pages.City as City exposing (Model, Msg, init, update, view)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, int, s)


type Route
    = Landing
    | Cities
    | City Int


type Page
    = LandingPage
    | CitiesPage Cities.Model
    | CityPage City.Model
    | PageNotFound


urlParser : Parser (Route -> a) a
urlParser =
    Parser.oneOf
        [ Parser.map Landing Parser.top
        , Parser.map Cities (s "cities")
        , Parser.map City (s "cities" </> int)
        ]


toCities : Model -> ( Cities.Model, Cmd Cities.Msg ) -> ( Model, Cmd Msg )
toCities model ( cities, cmd ) =
    ( { model | page = CitiesPage cities }
    , Cmd.map GotCitiesMsg cmd
    )


toCity : Model -> ( City.Model, Cmd City.Msg ) -> ( Model, Cmd Msg )
toCity model ( cities, cmd ) =
    ( { model | page = CityPage cities }
    , Cmd.map GotCityMsg cmd
    )


updateUrl : Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse urlParser url of
        Just Landing ->
            ( { model | page = LandingPage }, Cmd.none )

        Just Cities ->
            toCities model Cities.init

        Just (City cityId) ->
            toCity model (City.init cityId)

        Nothing ->
            ( { model | page = PageNotFound }, Cmd.none )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChanged
        }


type alias Model =
    { key : Nav.Key
    , page : Page
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    updateUrl url { page = PageNotFound, key = key }


type Msg
    = ClickedLink Browser.UrlRequest
    | UrlChanged Url.Url
    | GotCitiesMsg Cities.Msg
    | GotCityMsg City.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            updateUrl url model

        GotCitiesMsg citiesMsg ->
            case model.page of
                CitiesPage citiesModel ->
                    toCities model (Cities.update citiesMsg citiesModel)

                _ ->
                    ( model, Cmd.none )

        GotCityMsg cityMsg ->
            case model.page of
                CityPage cityModel ->
                    toCity model (City.update cityMsg cityModel)

                _ ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    case model.page of
        LandingPage ->
            { title = "Mytinerary"
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
                                [ a [ href "/cities" ] [ img [ style "max-height" "180px", src "../assets/arrowRight.svg" ] [] ]
                                ]
                            ]
                        ]
                    ]
                ]
            }

        CitiesPage citiesModel ->
            { title = "Cities"
            , body =
                [ navbar [ class "has-background-white has-shadow" ]
                    [ mobileNavbar ]
                , div [ class "mt-2" ] [ Cities.view citiesModel ]
                ]
            }

        CityPage cityModel ->
            { -- TODO show city title here, move this to city.elm
              title = "City"
            , body =
                [ navbar [ class "has-background-white has-shadow" ]
                    [ mobileNavbar ]
                , div [ class "mt-2" ] [ City.view cityModel ]
                ]
            }

        PageNotFound ->
            { title = "Page not found", body = [ div [] [ text "Page not found" ] ] }


mobileNavbar : Html msg
mobileNavbar =
    div [ class "navbar-brand" ]
        [ a [ class "navbar-item", href "/" ]
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
