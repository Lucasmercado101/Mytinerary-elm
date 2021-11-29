module Api.Itineraries exposing (NewItinerary, NewItineraryResponse, postItinerary)

import Api.Common exposing (endpoint, postWithCredentials)
import Http exposing (jsonBody)
import Json.Decode as JD exposing (Decoder)
import Json.Encode as JE


type alias NewItinerary =
    { title : String
    , creator : Int
    , time : Int
    , price : Int
    , hashtags : List String
    , activities : List String
    }


newItineraryEncoder : NewItinerary -> JE.Value
newItineraryEncoder { title, creator, price, time, hashtags, activities } =
    JE.object
        [ ( "title", JE.string title )
        , ( "creator", JE.int creator )
        , ( "time", JE.int time )
        , ( "price", JE.int price )
        , ( "hashtags", JE.list JE.string hashtags )
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


newItinerayDecoder : Decoder NewItineraryResponse
newItinerayDecoder =
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
        (Http.expectJson msg newItinerayDecoder)
