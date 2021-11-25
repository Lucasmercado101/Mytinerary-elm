module Api.Auth exposing (logOut)

import Http exposing (Expect, get)


logOut : Expect msg -> Cmd msg
logOut msg =
    get
        { url = baseUrl ++ "/auth/logout"
        , expect = msg
        }


baseUrl : String
baseUrl =
    "http://localhost:8001"
