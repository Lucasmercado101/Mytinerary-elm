module Pages.City exposing (Model, Msg, init, update, view)

import Html exposing (Html, div, text)
import Http
import Json.Decode as Decode exposing (Decoder, field, int, list, string)


type alias CityData =
    { id : Int
    , title : String
    , time : Int
    , price : Int
    , activities : List String
    , hashtags : List String
    , comments : List Comment
    }


type alias Comment =
    { id : Int
    , comment : String
    , author : Author
    }


type alias Author =
    { id : Int
    , profilePic : Maybe String
    , username : String
    }


cityDataDecoder : Decoder CityData
cityDataDecoder =
    Decode.map7 CityData
        (field "id" int)
        (field "title" string)
        (field "time" int)
        (field "price" int)
        (field "activities" (list string))
        (field "hashtags" (list string))
        (field "comments" (list commentDecoder))


commentDecoder : Decoder Comment
commentDecoder =
    Decode.map3 Comment
        (field "id" int)
        (field "comment" string)
        (field "author" authorDecoder)


authorDecoder : Decoder Author
authorDecoder =
    Decode.map3 Author
        (field "id" int)
        (field "profilePic" (Decode.maybe string))
        (field "username" string)


type CityDataRequest
    = Loading
    | Loaded (List CityData)
    | Error Http.Error


type Model
    = Model Int CityDataRequest


type Msg
    = GotCity (Result Http.Error (List CityData))


getCity : Int -> Cmd Msg
getCity cityId =
    Http.get
        { url = baseUrl ++ "/cities/" ++ String.fromInt cityId
        , expect = Http.expectJson GotCity (list cityDataDecoder)
        }


baseUrl =
    "http://localhost:8001"


init : Int -> ( Model, Cmd Msg )
init cityId =
    ( Model cityId Loading, getCity cityId )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        GotCity res ->
            case model of
                Model cityId _ ->
                    case res of
                        Ok cityData ->
                            ( Model cityId (Loaded cityData), Cmd.none )

                        Err err ->
                            ( Model cityId (Error err), Cmd.none )


view : Model -> Html msg
view model =
    div [] [ text "City", text (Debug.toString model) ]
