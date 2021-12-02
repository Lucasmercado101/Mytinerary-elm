module Api.City exposing (Author, City, Comment, Itinerary, commentDecoder, getCity)

import Api.Common exposing (endpoint)
import Http
import Json.Decode as JD exposing (Decoder)


type alias City =
    { id : Int
    , name : String
    , country : String
    , itineraries : List Itinerary
    }


cityDecoder : JD.Decoder City
cityDecoder =
    JD.map4 City
        (JD.field "id" JD.int)
        (JD.field "name" JD.string)
        (JD.field "country" JD.string)
        (JD.field "itineraries" (JD.list itineraryDecoder))


type alias Itinerary =
    { id : Int
    , title : String
    , time : Int
    , price : Int
    , activities : List String
    , hashtags : List String
    , comments : List Comment
    , creator : Author
    }


itineraryDecoder : Decoder Itinerary
itineraryDecoder =
    JD.map8 Itinerary
        (JD.field "id" JD.int)
        (JD.field "title" JD.string)
        (JD.field "time" JD.int)
        (JD.field "price" JD.int)
        (JD.field "activities" (JD.list JD.string))
        (JD.field "hashtags" (JD.list JD.string))
        (JD.field "comments" (JD.list commentDecoder))
        (JD.field "creator" authorDecoder)


type alias Comment =
    { id : Int
    , author : Author
    , comment : String
    }


commentDecoder : Decoder Comment
commentDecoder =
    JD.map3 Comment
        (JD.field "id" JD.int)
        (JD.field "author" authorDecoder)
        (JD.field "comment" JD.string)


type alias Author =
    { id : Int
    , username : String
    , profilePic : Maybe String
    }


authorDecoder : Decoder Author
authorDecoder =
    JD.map3 Author
        (JD.field "id" JD.int)
        (JD.field "username" JD.string)
        (JD.field "profilePic" (JD.maybe JD.string))



-- Public


getCity : Int -> (Result Http.Error City -> msg) -> Cmd msg
getCity cityId msg =
    Http.get
        { url = endpoint [ "cities", String.fromInt cityId ]
        , expect = Http.expectJson msg cityDecoder
        }
