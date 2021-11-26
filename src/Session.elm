port module Session exposing (UserData, UserSession(..), clearUserFromLocalStorageMsg, getLocalStorageUserDataSender, localStorageUserSub)

import Json.Decode exposing (Decoder, Value, decodeValue, field, int, map3, maybe, string)


port receiveLocalStorageUser : (Value -> msg) -> Sub msg


port getLocalStorageUserDataSender : () -> Cmd msg


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


decodeUser : Value -> Maybe UserData
decodeUser val =
    case decodeValue userDecoder val of
        Ok v ->
            Just v

        Err _ ->
            Nothing



-- PUBLIC


localStorageUserSub : Sub (Maybe UserData)
localStorageUserSub =
    receiveLocalStorageUser
        decodeUser


clearUserFromLocalStorageMsg : Cmd msg
clearUserFromLocalStorageMsg =
    clearUserLocalStorageSender ()


type UserSession
    = LoggedOut
    | LoggedIn UserData
