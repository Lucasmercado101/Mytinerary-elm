module Api.Auth exposing (logOut)

import Http exposing (get)


logOut : a -> Cmd a
logOut a =
    get
        { url = baseUrl ++ "/auth/logout"
        , expect = Http.expectWhatever (\_ -> a)
        }


baseUrl : String
baseUrl =
    "http://localhost:8001"
