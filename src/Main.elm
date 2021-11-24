module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, li, text, ul)
import Html.Attributes exposing (class, classList, href, style)
import Html.Events exposing (onClick)
import Pages.Cities as Cities exposing (Model, Msg, init, view)
import Pages.City as City exposing (Model, Msg, init, update, view)
import Pages.Landing as Landing exposing (view)
import Svg exposing (svg)
import Svg.Attributes
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
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChanged
        }


type alias Model =
    { key : Nav.Key
    , page : Page
    , isMenuExpanded : Bool
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    updateUrl url
        { page = PageNotFound
        , key = key
        , isMenuExpanded = False
        }


type Msg
    = ClickedLink Browser.UrlRequest
    | UrlChanged Url.Url
    | GotCitiesMsg Cities.Msg
    | GotCityMsg City.Msg
      -- Navbar
    | ToggleMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ page } as model) =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            updateUrl url model

        ToggleMenu ->
            ( { model | isMenuExpanded = not model.isMenuExpanded }, Cmd.none )

        -- PAGES
        GotCitiesMsg citiesMsg ->
            case page of
                CitiesPage citiesModel ->
                    toCities model (Cities.update citiesMsg citiesModel)

                _ ->
                    ( model, Cmd.none )

        GotCityMsg cityMsg ->
            case page of
                CityPage cityModel ->
                    toCity model (City.update cityMsg cityModel)

                _ ->
                    ( model, Cmd.none )


view : Model -> Browser.Document Msg
view { page, isMenuExpanded } =
    case page of
        LandingPage ->
            { title = "Mytinerary"
            , body =
                [ mobileNavbar isMenuExpanded
                , div [ class "h-screen pt-12" ] [ Landing.view ]
                ]
            }

        CitiesPage citiesModel ->
            Cities.view citiesModel
                |> documentMap GotCitiesMsg
                |> addContentWrapper
                |> addNavbar isMenuExpanded

        CityPage cityModel ->
            City.view cityModel
                |> documentMap GotCityMsg
                |> addContentWrapper
                |> addNavbar isMenuExpanded

        PageNotFound ->
            { title = "Page not found"
            , body = [ div [] [ text "Page not found" ] ]
            }


addContentWrapper : Browser.Document msg -> Browser.Document msg
addContentWrapper { title, body } =
    { title = title
    , body =
        [ div [ class "h-screen pt-12" ] body
        ]
    }


addNavbar : Bool -> Browser.Document Msg -> Browser.Document Msg
addNavbar isMenuExpanded { title, body } =
    { title = title
    , body = mobileNavbar isMenuExpanded :: body
    }


mobileNavbar : Bool -> Html Msg
mobileNavbar isMenuExpanded =
    div [ class "bg-white fixed h-12 w-screen flex justify-between z-20" ]
        [ a
            [ href "/"
            , class "inline-block flex text-xl px-2 h-full font-semibold pb-1 text-red-600 focus:text-red-600 active:text-red-600"
            ]
            [ div [ class "self-center" ] [ text "Mytinerary" ] ]
        , div [ class "h-full" ]
            [ button
                [ class "px-4 h-full"
                , onClick ToggleMenu
                ]
                [ burgerSvg ]
            , button
                [ class "px-4 h-full"
                ]
                [ avatarSvg ]
            ]
        , mobileMenuContent isMenuExpanded
        ]


mobileMenuContent : Bool -> Html msg
mobileMenuContent isMenuExpanded =
    div
        [ class
            "w-screen h-auto z-20 bg-white absolute top-full text-lg text-center py-2"
        , classList [ ( "hidden", not isMenuExpanded ) ]
        ]
        [ ul []
            [ li [] [ a [ class "block", href "/cities" ] [ text "Cities" ] ]
            , li [] [ a [ class "block", href "/" ] [ text "Home" ] ]
            ]
        ]


burgerSvg : Html msg
burgerSvg =
    svg
        [ Svg.Attributes.class "h-6 w-6"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap
                "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M4 6h16M4 12h16M4 18h16"
            ]
            []
        ]


avatarSvg : Html msg
avatarSvg =
    svg
        [ Svg.Attributes.class "h-6 w-6"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
            ]
            []
        ]


documentMap : (msg -> Msg) -> Browser.Document msg -> Browser.Document Msg
documentMap msg { title, body } =
    { title = title
    , body = List.map (Html.map msg) body
    }
