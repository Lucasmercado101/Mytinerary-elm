module Pages.Cities exposing (Model, Msg, init, subscriptions, update, view)

import Api.Cities exposing (City)
import Browser
import Html exposing (Html, a, button, div, h1, h3, img, li, p, span, text, ul)
import Html.Attributes exposing (class, href, src, type_)
import Html.Events exposing (onClick)
import Http
import Platform.Cmd exposing (Cmd)
import Session


type alias Model =
    { citiesData : CitiesData
    , userData : Maybe Session.UserData
    }


type CitiesData
    = Loading
    | CitiesLoaded (List City)
    | Failed Http.Error


type Msg
    = GotCities (Result Http.Error (List City))
    | RetryFetchCities
    | GotUserData (Maybe Session.UserData)


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


init : ( Model, Cmd Msg )
init =
    ( { citiesData = Loading
      , userData = Nothing
      }
    , Cmd.batch
        [ Api.Cities.getCities GotCities
        , Session.getLocalStorageUserDataSender ()
        ]
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map GotUserData Session.localStorageUserSub


view : Model -> Browser.Document Msg
view model =
    { title = "Cities"
    , body =
        [ -- modal
          -- ,
          h1 [ class "text-center font-semibold text-3xl my-4" ] [ text "Cities" ]

        -- , button
        --     [ class "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" ]
        --     [ text "Retry" ]
        , case model.citiesData of
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


modal : Html msg
modal =
    div [ class "fixed z-50 inset-0 overflow-y-auto" ]
        [ div [ class "flex items-center justify-center min-h-screen px-4 text-center sm:block sm:p-0" ]
            [ div [ class "fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" ]
                []
            , span [ class "hidden sm:inline-block sm:align-middle sm:h-screen" ]
                [ text "\u{200B}" ]
            , div [ class "inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" ]
                [ div [ class "bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4" ]
                    [ div [ class "sm:flex sm:items-start" ]
                        [ div [ class "mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left" ]
                            [ h3 [ class "text-lg leading-6 font-medium text-gray-900" ]
                                [ text "Deactivate account" ]
                            , div [ class "mt-2" ]
                                [ p [ class "text-sm text-gray-500" ]
                                    [ text "Are you sure you want to deactivate your account? All of your data will be permanently removed. This action cannot be undone.              " ]
                                ]
                            ]
                        ]
                    ]
                , div [ class "bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse" ]
                    [ button [ class "w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm", type_ "button" ]
                        [ text "Deactivate        " ]
                    , button [ class "mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm", type_ "button" ]
                        [ text "Cancel        " ]
                    ]
                ]
            ]
        ]
