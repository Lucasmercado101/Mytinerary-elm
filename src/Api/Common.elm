module Api.Common exposing (baseUrl, endpoint, postWithCredentials)

import Http exposing (Body, Expect, Header, riskyRequest)


requestBody :
    Body
    -> Expect msg
    ->
        { method : String
        , headers : List Header
        , url : String
        , body : Body
        , expect : Expect msg
        , timeout : Maybe Float
        , tracker : Maybe String
        }
requestBody body expect =
    { method = "POST"
    , url = baseUrl ++ "/cities"
    , body = body
    , expect = expect
    , timeout = Nothing
    , tracker = Nothing
    , headers = []
    }



-- PUBLIC


baseUrl : String
baseUrl =
    "http://localhost:8001"


postWithCredentials : Body -> Expect msg -> Cmd msg
postWithCredentials body expect =
    riskyRequest (requestBody body expect)


endpoint : List String -> String
endpoint strs =
    baseUrl ++ "/" ++ String.join "/" strs
