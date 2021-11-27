module Pages.City exposing (Model, Msg, init, subscriptions, update, view)

import Api.City exposing (City, Itinerary)
import Browser
import Html exposing (Html, button, div, form, h1, h2, h3, img, input, label, li, p, span, text, ul)
import Html.Attributes exposing (class, classList, disabled, for, id, placeholder, required, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http
import Session exposing (UserData)
import Svg exposing (svg)
import Svg.Attributes exposing (d, fill, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


subscriptions : Sub Msg
subscriptions =
    Sub.map GotUser Session.localStorageUserSub


type CityDataRequest
    = Loading
    | Loaded City
    | Error Http.Error


type alias Model =
    { cityId : Int
    , cityData : CityDataRequest
    , userSession : Maybe UserData

    -- New itinerary
    , isNewItineraryModalOpen : Bool
    , newItineraryName : String
    , newItineraryActivities : List String
    , newItineraryTags :
        { t1 : String
        , t2 : String
        , t3 : String
        }
    , newItineraryTime : Int
    , newItineraryPrice : Int
    , isCreatingNewItinerary : Bool
    }


type Msg
    = GotCity (Result Http.Error City)
    | GotUser (Maybe UserData)
      -- New Itinerary
    | ToggleModal
    | ChangeNewItineraryName String
      -- | ChangeNewItineraryActivities List String
    | ChangeTag1 String
    | ChangeTag2 String
    | ChangeTag3 String
    | ChangeNewItineraryTime String
    | ChangeNewItineraryPrice String
    | SubmitForm


init : Int -> ( Model, Cmd Msg )
init cityId =
    ( { cityId = cityId
      , cityData = Loading
      , userSession = Nothing
      , newItineraryName = ""
      , newItineraryActivities = []
      , newItineraryTags =
            { t1 = ""
            , t2 = ""
            , t3 = ""
            }
      , newItineraryTime = 0
      , newItineraryPrice = 0
      , isNewItineraryModalOpen = False
      , isCreatingNewItinerary = False
      }
    , Cmd.batch
        [ Api.City.getCity cityId GotCity
        , Session.getLocalStorageUserDataSender ()
        ]
    )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        GotCity res ->
            case res of
                Ok data ->
                    ( { model | cityData = Loaded data }, Cmd.none )

                Err err ->
                    ( { model | cityData = Error err }, Cmd.none )

        GotUser userSession ->
            ( { model | userSession = userSession }, Cmd.none )

        -- New Itinerary
        SubmitForm ->
            Debug.todo "Submit form"

        ToggleModal ->
            ( { model | isNewItineraryModalOpen = not model.isNewItineraryModalOpen }, Cmd.none )

        ChangeNewItineraryName newItineraryName ->
            ( { model | newItineraryName = newItineraryName }, Cmd.none )

        ChangeNewItineraryTime newItineraryTime ->
            ( { model | newItineraryTime = Maybe.withDefault 0 (String.toInt newItineraryTime) }, Cmd.none )

        ChangeNewItineraryPrice newItineraryPrice ->
            ( { model | newItineraryPrice = Maybe.withDefault 0 (String.toInt newItineraryPrice) }, Cmd.none )

        ChangeTag1 newTag ->
            let
                tags =
                    model.newItineraryTags
            in
            ( { model | newItineraryTags = { tags | t1 = newTag } }, Cmd.none )

        ChangeTag2 newTag ->
            let
                tags =
                    model.newItineraryTags
            in
            ( { model | newItineraryTags = { tags | t2 = newTag } }, Cmd.none )

        ChangeTag3 newTag ->
            let
                tags =
                    model.newItineraryTags
            in
            ( { model | newItineraryTags = { tags | t3 = newTag } }, Cmd.none )


view : Model -> Browser.Document Msg
view ({ cityData } as model) =
    let
        cityName =
            case cityData of
                Loading ->
                    "Loading city..."

                Loaded { name } ->
                    name

                Error _ ->
                    "Failed to load city"
    in
    { title = cityName
    , body =
        [ case cityData of
            Loading ->
                text "Loading"

            Loaded { country, itineraries, name } ->
                div [ class "h-full flex flex-col" ]
                    [ div
                        [ class "block relative py-8 text-white text-center"
                        ]
                        [ img [ class "city-bgr bg-black", src ("https://source.unsplash.com/featured/?" ++ name) ] []
                        , h1 [ class "text-3xl font-semibold mb-2" ] [ text name ]
                        , p [ class "text-2xl" ] [ text country ]
                        ]
                    , div [ class "bg-gray-200 flex-grow" ]
                        [ h2
                            [ class "pt-2 text-center text-2xl" ]
                            [ text "Itineraries" ]
                        , div [ class "px-2 my-2" ]
                            [ button
                                [ onClick ToggleModal
                                , class "mx-auto w-full md:w-64 block bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                                ]
                                [ text "Create Itinerary"
                                ]
                            ]
                        , if List.length itineraries == 0 then
                            p [ class "text-xl text-center mt-5" ] [ text "There are no itineraries" ]

                          else
                            ul [ class "container mx-auto px-4 pb-4 flex flex-col md:flex-row items-stretch" ]
                                (List.map (\l -> li [ class "md:w-1/2 xl:w-1/3 w-full p-2" ] [ itinerary l ]) itineraries)
                        ]
                    ]

            Error err ->
                case err of
                    Http.BadStatus int ->
                        if int == 404 then
                            div [ class "flex flex-col text-center mt-12" ]
                                [ p [ class "text-6xl font-bold" ] [ text "404" ]
                                , p [ class "text-3xl" ] [ text "City not found" ]
                                ]

                        else
                            p [ class "text-center text-xl mt-5" ] [ text "An unknown error ocurred, please refresh the page and try again." ]

                    _ ->
                        p [ class "text-center text-xl mt-5" ] [ text "An unknown error ocurred, please refresh the page and try again." ]
        , if model.isNewItineraryModalOpen then
            modal model

          else
            text ""
        ]
    }


itinerary : Itinerary -> Html msg
itinerary data =
    div [ class "mt-3 flex flex-col rounded shadow-sm p-3 bg-white md:h-full md:justify-between" ]
        [ div [ class "flex flex-row mb-2" ]
            [ if data.creator.profilePic == Nothing then
                div [ class "pointer-events-none w-12 h-12 bg-red-500 text-white capitalize rounded-full flex" ]
                    [ p [ class "m-auto text-xl" ] [ text (String.left 1 data.creator.username) ]
                    ]

              else
                img [ class "pointer-events-none w-12 h-12 rounded-full" ] []
            , h3 [ class "ml-3 self-center text-lg" ] [ text data.title ]
            ]
        , div [ class "flex flex-grow" ]
            [ div [ class "flex-grow" ]
                [ p [ class "font-semibold" ] [ text "Activities:" ]
                , ul [ class "list-disc list-inside" ]
                    (List.map (\l -> li [] [ text l ]) data.activities)
                ]

            -- vertical line
            , div [ class "w-px h-auto bg-gray-300" ] []
            , div [ class "w-16 flex flex-col pl-2" ]
                [ p [ class "flex items-center" ] [ p [ class "text-xl" ] [ text "$" ], text (String.fromInt data.price) ]
                , div [ class "flex items-center" ]
                    [ clockSvg
                    , p [] [ text (String.fromInt data.time) ]
                    ]
                ]
            ]
        , div [ class "flex capitalize mt-3 gap-x-2 flex-wrap" ]
            (List.map
                (\l -> div [ class "rounded-full py-1 px-2 bg-red-200" ] [ text ("#" ++ l) ])
                data.hashtags
            )

        -- TODO comments
        ]


clockSvg : Html msg
clockSvg =
    svg
        [ Svg.Attributes.class "h-5 w-5"
        , fill "none"
        , viewBox "0 0 24 24"
        , stroke "currentColor"
        ]
        [ Svg.path
            [ strokeLinecap "round"
            , strokeLinejoin "round"
            , strokeWidth "2"
            , d "M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
            ]
            []
        ]


modal : Model -> Html Msg
modal { newItineraryActivities, newItineraryName, newItineraryPrice, newItineraryTags, newItineraryTime, isCreatingNewItinerary } =
    let
        registerDisabled =
            newItineraryName
                == ""
                || newItineraryPrice
                == 0
                || newItineraryTime
                == 0
                || List.length newItineraryActivities
                == 0
                || newItineraryTags.t1
                == ""
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
                    [ onSubmit SubmitForm
                    , class
                        "flex flex-col container mx-auto px-4 gap-y-4"
                    ]
                    [ div []
                        [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "itinerary-name" ]
                            [ text "Name*" ]
                        , input
                            [ required True
                            , value newItineraryName
                            , onInput ChangeNewItineraryName
                            , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            , placeholder "name"
                            , id "itinerary-name"
                            , type_ "text"
                            ]
                            []
                        ]
                    , div []
                        [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "price" ]
                            [ text "Price*" ]
                        , input
                            [ required True
                            , value (String.fromInt newItineraryPrice)
                            , onInput ChangeNewItineraryPrice
                            , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            , id "price"
                            , type_ "number"
                            , Html.Attributes.min "1"
                            ]
                            []
                        ]
                    , div []
                        [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "time" ]
                            [ text "Time*" ]
                        , input
                            [ required True
                            , value (String.fromInt newItineraryTime)
                            , onInput ChangeNewItineraryTime
                            , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            , id "time"
                            , type_ "number"
                            , Html.Attributes.min "1"
                            ]
                            []
                        ]
                    , div []
                        [ p [ class "block text-gray-700 text-xl mb-2" ]
                            [ text "Tags" ]
                        , div [ class "flex flex-col gap-y-4" ]
                            [ div []
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-1"
                                    ]
                                    [ text "Tag #1" ]
                                , input
                                    [ required True
                                    , value newItineraryTags.t1
                                    , onInput ChangeTag1
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-1"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            , div []
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-2"
                                    ]
                                    [ text "Tag #2" ]
                                , input
                                    [ required True
                                    , value newItineraryTags.t2
                                    , onInput ChangeTag2
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-2"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            , div []
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-3"
                                    ]
                                    [ text "Tag #3" ]
                                , input
                                    [ required True
                                    , value newItineraryTags.t3
                                    , onInput ChangeTag3
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-3"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            ]
                        ]
                    , div [ class "flex flex-col" ]
                        [ p [ class "block text-gray-700 text-xl mb-2" ]
                            [ text "Activities" ]
                        , div
                            [ class "flex flex-col" ]
                            []
                        ]
                    , div [ class "flex ml-auto gap-x-4" ]
                        [ button [ class "px-4 py-2", type_ "button", onClick ToggleModal ] [ text "Cancel" ]
                        , button
                            [ type_ "submit"
                            , class "font-bold py-2 px-4 rounded"
                            , classList
                                [ ( "bg-blue-700 hover:bg-blue-700 text-white", not registerDisabled )
                                , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", registerDisabled )
                                ]
                            , disabled (registerDisabled || isCreatingNewItinerary)
                            ]
                            [ text
                                (if isCreatingNewItinerary then
                                    "Creating..."

                                 else
                                    "Create"
                                )
                            ]
                        ]
                    ]
                ]
            ]
        ]
