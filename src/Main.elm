module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Attribute, Html, a, div, img, p, section, span, text)
import Html.Attributes exposing (attribute, class, href, src, style)
import Pages.Cities as Cities exposing (Model, Msg, init, view)
import Pages.City as City exposing (Model, Msg, init, update, view)
import Pages.Landing as Landing exposing (Model, Msg, init, update, view)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, int, s)


type Route
    = Landing
    | Cities
    | City Int


type Page
    = LandingPage Landing.Model
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


toLanding : Model -> ( Landing.Model, Cmd Landing.Msg ) -> ( Model, Cmd Msg )
toLanding model ( cities, cmd ) =
    ( { model | page = LandingPage cities }
    , Cmd.map GotLandingMsg cmd
    )


updateUrl : Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse urlParser url of
        Just Landing ->
            toLanding model Landing.init

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
    | GotLandingMsg Landing.Msg


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

        GotLandingMsg landingMsg ->
            case model.page of
                LandingPage landingModel ->
                    toLanding model (Landing.update landingMsg landingModel)

                _ ->
                    ( model, Cmd.none )

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
view { page } =
    case page of
        LandingPage landingModel ->
            Landing.view landingModel
                |> documentMap GotLandingMsg

        CitiesPage citiesModel ->
            { title = "Cities"
            , body =
                [ div [ class "mt-2" ]
                    [ Cities.view citiesModel |> Html.map GotCitiesMsg ]
                ]
            }

        CityPage cityModel ->
            City.view cityModel
                |> documentMap GotCityMsg

        PageNotFound ->
            { title = "Page not found", body = [ div [] [ text "Page not found" ] ] }


documentMap : (msg -> Msg) -> Browser.Document msg -> Browser.Document Msg
documentMap msg { title, body } =
    { title = title
    , body = List.map (Html.map msg) body
    }
