module Pages.City exposing (Model, Msg, init, update, view)

import Html exposing (Html, div, h1, h2, h3, img, li, p, text, ul)
import Html.Attributes exposing (class, src)
import Http
import Json.Decode as Decode exposing (Decoder, field, int, list, string)
import Svg exposing (svg)
import Svg.Attributes exposing (d, fill, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


type alias CityData =
    { id : Int
    , name : String
    , country : String
    , itineraries : List ItineraryData
    }


type alias ItineraryData =
    { id : Int
    , title : String
    , time : Int
    , price : Int
    , activities : List String
    , hashtags : List String
    , comments : List Comment
    , creator : Author
    }


type alias Comment =
    { id : Int
    , comment : String
    , author : Author
    }


type alias Author =
    { id : Int
    , profilePic : Maybe String
    , username : String
    }


cityDataDecoder : Decoder CityData
cityDataDecoder =
    Decode.map4 CityData
        (field "id" int)
        (field "name" string)
        (field "country" string)
        (field "itineraries" (list itineraryDataDecoder))


itineraryDataDecoder : Decoder ItineraryData
itineraryDataDecoder =
    Decode.map8 ItineraryData
        (field "id" int)
        (field "title" string)
        (field "time" int)
        (field "price" int)
        (field "activities" (list string))
        (field "hashtags" (list string))
        (field "comments" (list commentDecoder))
        (field "creator" authorDecoder)


commentDecoder : Decoder Comment
commentDecoder =
    Decode.map3 Comment
        (field "id" int)
        (field "comment" string)
        (field "author" authorDecoder)


authorDecoder : Decoder Author
authorDecoder =
    Decode.map3 Author
        (field "id" int)
        (field "profilePic" (Decode.maybe string))
        (field "username" string)


type CityDataRequest
    = Loading
    | Loaded CityData
    | Error Http.Error


type Model
    = Model Int CityDataRequest


type Msg
    = GotCity (Result Http.Error CityData)


getCity : Int -> Cmd Msg
getCity cityId =
    Http.get
        { url = baseUrl ++ "/cities/" ++ String.fromInt cityId
        , expect = Http.expectJson GotCity cityDataDecoder
        }


baseUrl =
    "http://localhost:8001"


init : Int -> ( Model, Cmd Msg )
init cityId =
    ( Model cityId Loading, getCity cityId )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        GotCity res ->
            case model of
                Model cityId _ ->
                    case res of
                        Ok cityData ->
                            ( Model cityId (Loaded cityData), Cmd.none )

                        Err err ->
                            ( Model cityId (Error err), Cmd.none )


view : Model -> Html msg
view model =
    div [ class "bg-gray-200 flex-grow" ]
        (case model of
            Model _ Loading ->
                [ text "Loading" ]

            Model _ (Loaded cityData) ->
                [ div
                    [ class "is-relative has-text-centered py-4 pb-5 is-block z-10 bg-black"
                    ]
                    [ img [ class "city-bgr", src ("https://source.unsplash.com/featured/?" ++ cityData.name) ] []
                    , h1 [ class "title has-text-white" ] [ text cityData.name ]
                    , p [ class "subtitle has-text-white" ] [ text cityData.country ]
                    ]
                , h2
                    [ class "mt-2 text-center text-2xl" ]
                    [ text "Itineraries" ]
                , div [ class "container mx-auto px-4 pb-4" ] (List.map itinerary cityData.itineraries)
                ]

            Model _ _ ->
                [ text "Error" ]
        )


itinerary : ItineraryData -> Html msg
itinerary data =
    div [ class "mt-3 flex flex-col rounded shadow-sm p-3 bg-white" ]
        [ div [ class "flex flex-row mb-2" ]
            [ if data.creator.profilePic == Nothing then
                div [ class "pointer-events-none w-12 h-12 bg-red-500 text-white capitalize rounded-full flex" ]
                    [ p [ class "m-auto text-xl" ] [ text (String.left 1 data.creator.username) ]
                    ]

              else
                img [ class "pointer-events-none w-12 h-12 rounded-full" ] []
            , h3 [ class "ml-3 self-center text-lg" ] [ text data.title ]
            ]
        , div [ class "flex" ]
            [ div [ class "flex-grow" ]
                [ text "Activities:"
                , ul [ class "list-disc list-inside" ]
                    (List.map (\l -> li [] [ text l ]) data.activities)
                ]
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
        ]


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
