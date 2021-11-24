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
update msg _ =
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
        [ h1 [ class "text-center font-semibold text-3xl my-4" ] [ text "Cities" ]
        , case model of
            Loading ->
                div [ class "text-xl text-center" ] [ text "Loading..." ]

            CitiesLoaded cities ->
                ul [ class "flex flex-col gap-y-2" ]
                    (List.map
                        (\c ->
                            li []
                                [ city c ]
                        )
                        cities
                    )

            Failed _ ->
                div [ class "text-center px-4" ]
                    [ p [ class "text-xl mb-4" ] [ text "Something went wrong, please try again." ]
                    , div []
                        [ button
                            [ onClick RetryFetchCities
                            , class "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                            ]
                            [ text "Retry" ]
                        ]
                    ]
        ]
    }


city : City -> Html msg
city cityData =
    a
        [ href ("/cities/" ++ String.fromInt cityData.id)
        , class "block relative text-white text-center py-4 flex flex-col gap-y-2"
        ]
        [ img [ class "city-bgr bg-black", src ("https://source.unsplash.com/featured/?" ++ cityData.name) ] []
        , p [ class "text-2xl font-semibold" ] [ text cityData.name ]
        , p [ class "text-xl" ] [ text cityData.country ]
        ]
