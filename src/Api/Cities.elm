module Api.Cities exposing (City, getCities)

import Api.Common exposing (baseUrl)
import Http
import Json.Decode exposing (Decoder, field, int, list, map3, string)


getCities : (Result Http.Error (List City) -> msg) -> Cmd msg
getCities msg =
    Http.get
        { url = baseUrl ++ "/cities"
        , expect = Http.expectJson msg (list cityDecoder)
        }


cityDecoder : Decoder City
cityDecoder =
    map3 City
        (field "id" int)
        (field "name" string)
        (field "country" string)


type alias City =
    { id : Int
    , name : String
    , country : String
    }
