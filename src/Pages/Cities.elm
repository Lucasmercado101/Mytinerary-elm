module Pages.Cities exposing (Model, Msg, init, update, view)

import Html exposing (Html, div, h1, img, li, p, text, ul)
import Html.Attributes exposing (class, src, style)
import Http exposing (get)
import Json.Decode as Decode exposing (Decoder, field, int, list, string)
import Platform.Cmd exposing (Cmd)


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


type Msg
    = GotCities (Result Http.Error (List City))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotCities res ->
            case res of
                Ok cities ->
                    ( CitiesLoaded cities, Cmd.none )

                Err err ->
                    -- TODO
                    Debug.todo "handle error"


getCities : Cmd Msg
getCities =
    Http.get
        { url = baseUrl ++ "/cities"
        , expect = Http.expectJson GotCities (list cityDecoder)
        }


init : ( Model, Cmd Msg )
init =
    ( Loading, getCities )


view : Model -> Html msg
view model =
    div []
        [ h1 [ class "has-text-centered title" ] [ text "Cities" ]
        , case model of
            Loading ->
                div [] [ text "Loading..." ]

            CitiesLoaded cities ->
                ul [] (List.map (\c -> li [ class "my-2-desktop" ] [ city c ]) cities)
        ]


city : City -> Html msg
city cityData =
    div
        [ class "is-relative has-text-centered my-2 py-4" ]
        [ img [ class "city-bgr", src ("https://source.unsplash.com/featured/?" ++ cityData.name) ] []
        , p [ class "title has-text-white" ] [ text cityData.name ]
        , p [ class "subtitle has-text-white" ] [ text cityData.country ]
        ]
