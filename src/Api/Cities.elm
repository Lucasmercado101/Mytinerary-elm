module Api.Cities exposing (City, getCities, postNewCity)

import Api.Common exposing (endpoint, postWithCredentials)
import Http exposing (jsonBody)
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
        { url = endpoint [ "cities" ]
        , expect = Http.expectJson msg (JD.list cityDecoder)
        }


cityDecoder : Decoder City
cityDecoder =
    JD.map3 City
        (JD.field "id" JD.int)
        (JD.field "name" JD.string)
        (JD.field "country" JD.string)



-- NEW CITY


type alias NewCity =
    { name : String
    , country : String
    }


newCityEncoder : NewCity -> JE.Value
newCityEncoder { country, name } =
    JE.object
        [ ( "name", JE.string name )
        , ( "country", JE.string country )
        ]


postNewCity : (Result Http.Error City -> msg) -> NewCity -> Cmd msg
postNewCity msg newCityData =
    postWithCredentials
        (endpoint [ "cities" ])
        (newCityData
            |> newCityEncoder
            |> jsonBody
        )
        (Http.expectJson msg cityDecoder)
