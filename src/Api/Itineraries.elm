module Api.Itineraries exposing (NewItinerary, NewItineraryResponse, PatchItineraryResponse, deleteItinerary, patchItinerary, postItinerary)

import Api.City
import Api.Common exposing (deleteWithCredentials, endpoint, patchWithCredentials, postWithCredentials)
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


patchItineraryDataEncoder : PatchItineraryInputData -> JE.Value
patchItineraryDataEncoder { title, price, time, hashtags, activities } =
    JE.object
        [ ( "title", JE.string title )
        , ( "time", JE.int time )
        , ( "price", JE.int price )
        , ( "hashtags", JE.list JE.string hashtags )
        , ( "activities", JE.list JE.string activities )
        ]


type alias PatchItineraryInputData =
    { title : String
    , time : Int
    , price : Int
    , hashtags : List String
    , activities : List String
    }


type alias PatchItineraryResponse =
    { id : Int
    , title : String
    , time : Int
    , price : Int
    , hashtags : List String
    , activities : List String
    , comments : List Api.City.Comment
    }


patchItineraryDataDecoder : Decoder PatchItineraryResponse
patchItineraryDataDecoder =
    JD.map7 PatchItineraryResponse
        (JD.field "id" JD.int)
        (JD.field "title" JD.string)
        (JD.field "time" JD.int)
        (JD.field "price" JD.int)
        (JD.field "hashtags" (JD.list JD.string))
        (JD.field "activities" (JD.list JD.string))
        (JD.field "comments" (JD.list Api.City.commentDecoder))



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


patchItinerary : Int -> PatchItineraryInputData -> (Result Http.Error PatchItineraryResponse -> msg) -> Cmd msg
patchItinerary itineraryId data msg =
    patchWithCredentials
        (endpoint [ "itinerary", String.fromInt itineraryId ])
        (data
            |> patchItineraryDataEncoder
            |> jsonBody
        )
        (Http.expectJson msg patchItineraryDataDecoder)
