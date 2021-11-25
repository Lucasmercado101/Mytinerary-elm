module Pages.Cities exposing (Model, Msg, init, update, view)

import Api.Cities exposing (City)
import Browser
import Html exposing (Html, a, button, div, h1, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Http
import Platform.Cmd exposing (Cmd)


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
            ( Loading, Api.Cities.getCities GotCities )


init : ( Model, Cmd Msg )
init =
    ( Loading, Api.Cities.getCities GotCities )


view : Model -> Browser.Document Msg
view model =
    { title = "Cities"
    , body =
        [ h1 [ class "text-center font-semibold text-3xl my-4" ] [ text "Cities" ]
        , case model of
            Loading ->
                div [ class "text-xl text-center" ] [ text "Loading..." ]

            CitiesLoaded cities ->
                ul [ class "flex flex-wrap flex-col md:flex-row" ]
                    (List.map
                        (\c ->
                            li [ class "md:w-1/2 xl:w-1/3 p-2 md:h-40" ]
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
        , class "block relative text-white text-center py-4 flex flex-col gap-y-2 md:gap-y-0 justify-evenly h-full"
        ]
        [ img [ class "city-bgr bg-black", src ("https://source.unsplash.com/featured/?" ++ cityData.name) ] []
        , p [ class "text-2xl font-semibold" ] [ text cityData.name ]
        , p [ class "text-xl" ] [ text cityData.country ]
        ]
