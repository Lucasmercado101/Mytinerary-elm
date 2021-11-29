module Api.Common exposing (deleteWithCredentials, endpoint, postWithCredentials)

import Http exposing (Body, Expect, Header, emptyBody, riskyRequest)


requestBody :
    Body
    -> Expect msg
    -> String
    ->
        { method : String
        , headers : List Header
        , url : String
        , body : Body
        , expect : Expect msg
        , timeout : Maybe Float
        , tracker : Maybe String
        }
requestBody body expect endpointStr =
    { method = "POST"
    , url = endpointStr
    , body = body
    , expect = expect
    , timeout = Nothing
    , tracker = Nothing
    , headers = []
    }


deleteBody :
    Expect msg
    -> String
    ->
        { method : String
        , headers : List Header
        , url : String
        , body : Body
        , expect : Expect msg
        , timeout : Maybe Float
        , tracker : Maybe String
        }
deleteBody expect endpointStr =
    { method = "DELETE"
    , url = endpointStr
    , body = emptyBody
    , expect = expect
    , timeout = Nothing
    , tracker = Nothing
    , headers = []
    }



-- PUBLIC


baseUrl : String
baseUrl =
    "http://localhost:8001"


postWithCredentials : String -> Body -> Expect msg -> Cmd msg
postWithCredentials endpointStr body expect =
    riskyRequest (requestBody body expect endpointStr)


deleteWithCredentials : String -> Expect msg -> Cmd msg
deleteWithCredentials endpointStr expect =
    riskyRequest (deleteBody expect endpointStr)


endpoint : List String -> String
endpoint strs =
    baseUrl ++ "/" ++ String.join "/" strs
