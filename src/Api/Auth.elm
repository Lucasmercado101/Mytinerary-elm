module Api.Auth exposing (logIn, logOut)

import Api.Common exposing (endpoint, postWithCredentials)
import Http exposing (get)
import Json.Decode as JD exposing (Decoder)
import Json.Encode as JE


logOut : a -> Cmd a
logOut a =
    get
        { url = endpoint [ "auth", "logout" ]
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



-- logIn : (Result Http.Error City -> msg) -> NewCity -> Cmd msg


logIn :
    { a | username : String, password : String }
    -> (Result Http.Error UserData -> msg)
    -> Cmd msg
logIn { username, password } msg =
    postWithCredentials
        (Http.jsonBody <|
            JE.object
                [ ( "username", JE.string username )
                , ( "password", JE.string password )
                ]
        )
        (Http.expectJson msg userDecoder)
