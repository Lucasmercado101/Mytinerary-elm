module Api.Auth exposing (logIn, logOut)

import Api.Common exposing (baseUrl)
import Http exposing (get, riskyRequest)
import Json.Decode as JD exposing (Decoder)
import Json.Encode as JE


logOut : a -> Cmd a
logOut a =
    get
        { url = baseUrl ++ "/auth/logout"
        , expect = Http.expectWhatever (\_ -> a)
        }


type alias UserData =
    { id : Int
    , username : String
    , profile_pic : Maybe String
    }


userDecoder : Decoder UserData
userDecoder =
    JD.map3 UserData
        (JD.field "id" JD.int)
        (JD.field "username" JD.string)
        (JD.field "profile_pic" (JD.maybe JD.string))


logIn :
    { a
        | username : String
        , password : String
    }
    -> (Result Http.Error UserData -> msg)
    -> Cmd msg
logIn { username, password } msg =
    riskyRequest
        { method = "POST"
        , url = baseUrl ++ "/auth/login"
        , body =
            Http.jsonBody <|
                JE.object
                    [ ( "username", JE.string username )
                    , ( "password", JE.string password )
                    ]
        , expect = Http.expectJson msg userDecoder
        , tracker = Nothing
        , timeout = Nothing
        , headers = []
        }
