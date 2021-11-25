module Api.Auth exposing (logOut)

import Api.Common exposing (baseUrl)
import Http exposing (get)


logOut : a -> Cmd a
logOut a =
    get
        { url = baseUrl ++ "/auth/logout"
        , expect = Http.expectWhatever (\_ -> a)
        }
