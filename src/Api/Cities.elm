module Api.Cities exposing (City, getCities, postNewCity)

import Api.Common exposing (baseUrl)
import Http exposing (jsonBody, post)
import Json.Decode as JD exposing (Decoder)
import Json.Encode as JE


type alias City =
    { id : Int
    , name : String
    , country : String
    }


getCities : (Result Http.Error (List City) -> msg) -> Cmd msg
getCities msg =
    Http.get
        { url = baseUrl ++ "/cities"
        , expect = Http.expectJson msg (JD.list cityDecoder)
        }


postNewCity : (Result Http.Error City -> msg) -> City -> Cmd msg
postNewCity msg newCityData =
    post
        { url = baseUrl ++ "/cities"
        , body = jsonBody <| cityEncoder newCityData
        , expect = Http.expectJson msg cityDecoder
        }


cityDecoder : Decoder City
cityDecoder =
    JD.map3 City
        (JD.field "id" JD.int)
        (JD.field "name" JD.string)
        (JD.field "country" JD.string)


cityEncoder : City -> JE.Value
cityEncoder { country, id, name } =
    JE.object
        [ ( "id", JE.int id )
        , ( "name", JE.string name )
        , ( "country", JE.string country )
        ]
