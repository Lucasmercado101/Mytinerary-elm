module Api.Auth exposing (User, logIn, logOut, registerUser)

import Api.Common exposing (endpoint, postWithCredentials)
import Http exposing (get, jsonBody)
import Json.Decode as JD exposing (Decoder)
import Json.Encode as JE


logOut : a -> Cmd a
logOut a =
    get
        { url = endpoint [ "auth", "logout" ]
        , expect = Http.expectWhatever (\_ -> a)
        }


type alias User =
    { id : Int
    , username : String
    , profile_pic : Maybe String
    }


userDecoder : Decoder User
userDecoder =
    JD.map3 User
        (JD.field "id" JD.int)
        (JD.field "username" JD.string)
        (JD.field "profile_pic" (JD.maybe JD.string))


loginUserEncoder :
    { extends
        | username : String
        , password : String
    }
    -> JE.Value
loginUserEncoder { username, password } =
    JE.object
        [ ( "username", JE.string username )
        , ( "password", JE.string password )
        ]


registerUserEncoder :
    { extends
        | username : String
        , password : String
    }
    -> JE.Value
registerUserEncoder { username, password } =
    JE.object
        [ ( "username", JE.string username )
        , ( "password", JE.string password )
        ]



-- PUBLIC


logIn :
    { extends
        | username : String
        , password : String
    }
    -> (Result Http.Error User -> msg)
    -> Cmd msg
logIn user msg =
    postWithCredentials
        (endpoint [ "auth", "login" ])
        (user
            |> loginUserEncoder
            |> Http.jsonBody
        )
        (Http.expectJson msg userDecoder)


registerUser :
    { extends
        | username : String
        , password : String
    }
    -> (Result Http.Error User -> msg)
    -> Cmd msg
registerUser newUser msg =
    Http.post
        { url = endpoint [ "auth", "register" ]
        , body =
            newUser
                |> registerUserEncoder
                |> jsonBody
        , expect = Http.expectJson msg userDecoder
        }
