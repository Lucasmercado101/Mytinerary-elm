module Pages.Cities exposing (Model, Msg, init, subscriptions, update, view)

import Api.Cities exposing (City)
import Browser
import Html exposing (Html, a, button, div, form, h1, h2, h3, img, input, label, li, p, span, text, ul)
import Html.Attributes exposing (class, classList, disabled, for, href, id, placeholder, required, src, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Platform.Cmd exposing (Cmd)
import Session


type alias Model =
    { citiesData : CitiesData
    , userData : Maybe Session.UserData

    -- new city data
    , isNewCityModalOpen : Bool
    , newCityName : String
    , newCityCountry : String
    }


type CitiesData
    = Loading
    | CitiesLoaded (List City)
    | Failed Http.Error


type Msg
    = GotCities (Result Http.Error (List City))
    | RetryFetchCities
    | GotUserData (Maybe Session.UserData)
      -- Modal
    | ToggleModal
    | ChangeCityName String
    | ChangeCountryName String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotCities res ->
            case res of
                Ok cities ->
                    ( { model | citiesData = CitiesLoaded cities }, Cmd.none )

                Err err ->
                    ( { model | citiesData = Failed err }, Cmd.none )

        RetryFetchCities ->
            ( { model | citiesData = Loading }, Api.Cities.getCities GotCities )

        GotUserData userData ->
            ( { model | userData = userData }, Cmd.none )

        -- Modal
        ToggleModal ->
            ( { model | isNewCityModalOpen = not model.isNewCityModalOpen }, Cmd.none )

        ChangeCityName newCityName ->
            ( { model | newCityName = newCityName }, Cmd.none )

        ChangeCountryName newCityCountry ->
            ( { model | newCityCountry = newCityCountry }, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( { citiesData = Loading
      , userData = Nothing
      , isNewCityModalOpen = False
      , newCityName = ""
      , newCityCountry = ""
      }
    , Cmd.batch
        [ Api.Cities.getCities GotCities
        , Session.getLocalStorageUserDataSender ()
        ]
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.map GotUserData Session.localStorageUserSub


view : Model -> Browser.Document Msg
view ({ citiesData, isNewCityModalOpen } as model) =
    { title = "Cities"
    , body =
        [ if isNewCityModalOpen then
            modal model

          else
            text ""
        , h1 [ class "text-center font-semibold text-3xl my-4" ] [ text "Cities" ]
        , div [ class "px-2 mb-2" ]
            [ button
                [ onClick ToggleModal
                , class "mx-auto w-full md:w-64 block bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                ]
                [ text "Add City" ]
            ]
        , case citiesData of
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


modal : Model -> Html Msg
modal { newCityName, newCityCountry } =
    let
        registerDisabled =
            newCityName == "" || newCityCountry == ""
    in
    div [ class "fixed z-50 inset-0 overflow-y-auto" ]
        [ div [ class "flex items-center justify-center min-h-screen px-4 text-center sm:block sm:p-0" ]
            [ div [ class "fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity", onClick ToggleModal ]
                []
            , span [ class "hidden sm:inline-block sm:align-middle sm:h-screen" ]
                [ text "\u{200B}" ]
            , div [ class "py-6 inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" ]
                [ h2 [ class "text-2xl text-center mb-4" ] [ text "New City" ]
                , form
                    [ -- onSubmit SubmitForm
                      -- ,
                      class
                        "flex flex-col container mx-auto px-4 gap-y-4"
                    ]
                    [ div []
                        [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "city-name" ]
                            [ text "Name" ]
                        , input
                            [ required True
                            , value newCityName
                            , onInput ChangeCityName
                            , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            , placeholder "name"
                            , id "city-name"
                            , type_ "text"
                            ]
                            []
                        ]
                    , div []
                        [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "country" ]
                            [ text "Country" ]
                        , input
                            [ required True
                            , value newCityCountry
                            , onInput ChangeCountryName
                            , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            , id "country"
                            , placeholder "country"
                            , type_ "text"
                            ]
                            []
                        ]
                    , div [ class "flex ml-auto gap-x-4" ]
                        [ button [ class "px-4 py-2", onClick ToggleModal ] [ text "Cancel" ]
                        , button
                            [ type_ "submit"
                            , class "font-bold py-2 px-4 rounded"
                            , classList
                                [ ( "bg-blue-700 hover:bg-blue-700 text-white", not registerDisabled )
                                , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", registerDisabled )
                                ]
                            , disabled registerDisabled
                            ]
                            [ text "Create" ]
                        ]
                    ]
                ]
            ]
        ]
