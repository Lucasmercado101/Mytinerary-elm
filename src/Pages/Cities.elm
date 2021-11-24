module Pages.Cities exposing (Model, Msg, init, update, view)

import Browser
import Html exposing (Html, a, button, div, h1, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)
import Http exposing (get)
import Json.Decode as Decode exposing (Decoder, field, int, list, string)
import Platform.Cmd exposing (Cmd)


baseUrl : String
baseUrl =
    "http://localhost:8001"


type alias City =
    { id : Int
    , name : String
    , country : String
    }


cityDecoder : Decoder City
cityDecoder =
    Decode.map3 City
        (field "id" int)
        (field "name" string)
        (field "country" string)


type Model
    = Loading
    | CitiesLoaded (List City)
    | Failed Http.Error


type Msg
    = GotCities (Result Http.Error (List City))
    | RetryFetchCities


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotCities res ->
            case res of
                Ok cities ->
                    ( CitiesLoaded cities, Cmd.none )

                Err err ->
                    ( Failed err, Cmd.none )

        RetryFetchCities ->
            ( Loading, getCities )


getCities : Cmd Msg
getCities =
    Http.get
        { url = baseUrl ++ "/cities"
        , expect = Http.expectJson GotCities (list cityDecoder)
        }


init : ( Model, Cmd Msg )
init =
    ( Loading, getCities )


view : Model -> Browser.Document Msg
view model =
    { title = "Cities"
    , body =
        [ h1 [ class "has-text-centered title" ] [ text "Cities" ]
        , case model of
            Loading ->
                div [ class "has-text-centered subtitle mt-3" ] [ text "Loading..." ]

            CitiesLoaded cities ->
                ul [] (List.map (\c -> li [ class "my-2-desktop" ] [ city c ]) cities)

            Failed _ ->
                div [ class "has-text-centered subtitle mt-3 columns is-multiline" ]
                    [ p [ class "column is-12" ] [ text "Something went wrong, please try again." ]
                    , div [ class "column is-12" ]
                        [ button [ class "button is-primary", onClick RetryFetchCities ] [ text "Retry" ]
                        ]
                    ]
        ]
    }


city : City -> Html msg
city cityData =
    a
        [ href ("/cities/" ++ String.fromInt cityData.id)
        , class "is-relative has-text-centered my-2 py-4 is-block"
        ]
        [ img [ class "city-bgr", src ("https://source.unsplash.com/featured/?" ++ cityData.name) ] []
        , p [ class "title has-text-white" ] [ text cityData.name ]
        , p [ class "subtitle has-text-white" ] [ text cityData.country ]
        ]
