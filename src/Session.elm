port module Session exposing (UserData, clearUserFromLocalStorageMsg, localStorageUserSub)

import Json.Decode exposing (Decoder, Value, decodeValue, field, int, map3, maybe, string)


port receiveLocalStorageUser : (Value -> msg) -> Sub msg


port clearUserLocalStorageSender : () -> Cmd msg


type alias UserData =
    { id : Int
    , username : String
    , profile_pic : Maybe String
    }


userDecoder : Decoder UserData
userDecoder =
    map3 UserData
        (field "id" int)
        (field "username" string)
        (field "profile_pic" (maybe string))



-- PUBLIC


localStorageUserSub : Sub (Maybe UserData)
localStorageUserSub =
    receiveLocalStorageUser
        (\l ->
            case decodeValue userDecoder l of
                Ok v ->
                    Just v

                Err _ ->
                    Nothing
        )


clearUserFromLocalStorageMsg : Cmd msg
clearUserFromLocalStorageMsg =
    clearUserLocalStorageSender ()
