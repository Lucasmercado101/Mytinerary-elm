module Pages.City exposing (Model, Msg, init, update, view)

import Html exposing (Html, div, h1, h2, h3, img, p, text)
import Html.Attributes exposing (class)
import Http
import Json.Decode as Decode exposing (Decoder, field, int, list, string)


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
    div []
        (case model of
            Model _ Loading ->
                [ text "Loading" ]

            Model _ (Loaded cityData) ->
                [ h1 [ class "title" ] [ text cityData.name ]
                , h2 [ class "subtitle" ] [ text cityData.country ]
                , div [ class "container mx-auto px-4" ] (List.map itinerary cityData.itineraries)
                ]

            Model _ _ ->
                [ text "Error" ]
        )


itinerary : ItineraryData -> Html msg
itinerary data =
    div [ class "mt-3 flex flex-col rounded shadow-sm bg-gray-50" ]
        [ div [ class "flex flex-row" ]
            [ if data.creator.profilePic == Nothing then
                div [ class "pointer-events-none w-12 h-12 bg-red-500 text-white capitalize rounded-full flex " ]
                    [ p [ class "m-auto text-xl" ] [ text (String.left 1 data.creator.username) ]
                    ]

              else
                img [] []
            , h3 [] [ text data.title ]
            ]
        , p [] [ text ("$" ++ String.fromInt data.price) ]
        , p [] [ text (String.fromInt data.time) ]
        , div [ class "flex justify-evenly capitalize" ]
            (List.map
                (\l -> div [] [ text ("#" ++ l) ])
                data.hashtags
            )
        ]
