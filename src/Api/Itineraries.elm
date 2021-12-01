module Api.Itineraries exposing (NewItinerary, NewItineraryResponse, deleteItinerary, postItinerary)

import Api.Common exposing (deleteWithCredentials, endpoint, postWithCredentials)
import Http exposing (jsonBody)
import Json.Decode as JD exposing (Decoder)
import Json.Encode as JE


type alias NewItinerary =
    { title : String
    , duration : Int
    , price : Int
    , tags : List String
    , activities : List String
    }


newItineraryEncoder : NewItinerary -> JE.Value
newItineraryEncoder { title, price, duration, tags, activities } =
    JE.object
        [ ( "title", JE.string title )
        , ( "duration", JE.int duration )
        , ( "price", JE.int price )
        , ( "tags", JE.list JE.string tags )
        , ( "activities", JE.list JE.string activities )
        ]


type alias NewItineraryResponse =
    { activities : List String
    , city : Int
    , creator : Int
    , hashtags : List String
    , price : Int
    , title : String
    , time : Int
    , id : Int
    }


newItineraryDecoder : Decoder NewItineraryResponse
newItineraryDecoder =
    JD.map8 NewItineraryResponse
        (JD.field "activities" (JD.list JD.string))
        (JD.field "city" JD.int)
        (JD.field "creator" JD.int)
        (JD.field "hashtags" (JD.list JD.string))
        (JD.field "price" JD.int)
        (JD.field "title" JD.string)
        (JD.field "time" JD.int)
        (JD.field "id" JD.int)



-- Public


postItinerary : Int -> NewItinerary -> (Result Http.Error NewItineraryResponse -> msg) -> Cmd msg
postItinerary cityId data msg =
    postWithCredentials
        (endpoint [ "cities", String.fromInt cityId, "itinerary" ])
        (data
            |> newItineraryEncoder
            |> jsonBody
        )
        (Http.expectJson msg newItineraryDecoder)


deleteItinerary : Int -> (Result Http.Error () -> msg) -> Cmd msg
deleteItinerary itineraryId a =
    deleteWithCredentials
        (endpoint [ "itinerary", String.fromInt itineraryId ])
        (Http.expectWhatever a)
