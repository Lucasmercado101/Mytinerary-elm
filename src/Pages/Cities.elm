module Pages.Cities exposing (Model, Msg, init, update, view)

import Html exposing (div, h1, li, text, ul)
import Html.Attributes exposing (class)
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
                    ( model, Cmd.none )


getCities : Cmd Msg
getCities =
    Http.get
        { url = baseUrl ++ "/cities"
        , expect = Http.expectJson GotCities (list cityDecoder)
        }


init : ( Model, Cmd Msg )
init =
    ( Loading, getCities )


view : Model -> Html.Html msg
view model =
    div []
        [ h1 [ class "has-text-centered title" ] [ text "Cities" ]
        , case model of
            Loading ->
                div [] [ text "Loading..." ]

            CitiesLoaded cities ->
                ul []
                    (List.map
                        (\city ->
                            li [] [ text city.name ]
                        )
                        cities
                    )
        ]
