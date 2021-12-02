module Pages.City exposing (Model, Msg, init, subscriptions, update, view)

import Api.City
import Api.Itineraries
import Browser
import Browser.Events
import Dict exposing (Dict)
import Html exposing (Html, button, div, form, h1, h2, h3, img, input, label, li, p, span, text, textarea, ul)
import Html.Attributes exposing (class, classList, disabled, for, id, name, placeholder, required, rows, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http
import Json.Decode as Decode
import Session exposing (UserData)
import Svg.Attributes
import SvgIcons exposing (chevronDownSvg, clockSvg, errorSvg, verticalDotsSvg, xSvg)
import Tuple exposing (first)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map GotUser Session.localStorageUserSub
        , case model.itineraryMenuOpen of
            Just idx ->
                Browser.Events.onMouseDown (outsideTarget ("itinerary-menu-" ++ String.fromInt idx) CloseItineraryMenu)

            Nothing ->
                Sub.none
        , case model.commentMenuOpen of
            Just idx ->
                Browser.Events.onMouseDown (outsideTarget ("comment-menu-" ++ String.fromInt idx) CloseCommentMenu)

            Nothing ->
                Sub.none
        ]


type alias City =
    { id : Int
    , name : String
    , country : String
    , itineraries : List Itinerary
    }


type CityDataRequest
    = Loading
    | Loaded City
    | Error Http.Error


type alias Model =
    { cityId : Int
    , cityData : CityDataRequest
    , userSession : Maybe UserData
    , commentMenuOpen : Maybe Int

    -- New itinerary
    , isNewItineraryModalOpen : Bool
    , newItineraryName : String
    , newItineraryFirstActivity : String
    , newItineraryRestActivities : List ( Int, String )
    , newItineraryActivitiesIdx : Int
    , tag1 : String
    , tag2 : String
    , tag3 : String
    , newItineraryTime : Int
    , newItineraryPrice : Int
    , isCreatingNewItinerary : Bool
    , itineraryMenuOpen : Maybe Int
    , creatingNewItineraryError : String

    -- Edit Itinerary
    , isEditItineraryModalOpen : Bool
    , editItineraryId : Int
    , editItineraryName : String
    , editItineraryFirstActivity : String
    , editItineraryRestActivities : List ( Int, String )
    , editItineraryActivitiesIdx : Int
    , editItineraryTime : Int
    , editItineraryPrice : Int
    , editItineraryTag1 : String
    , editItineraryTag2 : String
    , editItineraryTag3 : String
    }


type alias ItineraryFormData =
    { name : String
    , firstActivity : String
    , restActivities : List ( Int, String )
    , tag1 : String
    , tag2 : String
    , tag3 : String
    , time : Int
    , price : Int
    }


clearModalData : Model -> Model
clearModalData model =
    { model
        | newItineraryName = ""
        , newItineraryFirstActivity = ""
        , newItineraryRestActivities = []
        , newItineraryActivitiesIdx = 0
        , tag1 = ""
        , tag2 = ""
        , tag3 = ""
        , newItineraryTime = 0
        , newItineraryPrice = 0
    }


type alias Itinerary =
    { data :
        { id : Int
        , title : String
        , time : Int
        , price : Int
        , activities : List String
        , hashtags : List String
        , comments : List Comment
        , creator : Api.City.Author
        }
    , action : Maybe Action
    , areCommentsExpanded : Bool
    , newComment : Maybe NewComment
    }


type alias NewComment =
    { text : String
    , isCreating : Bool
    , error : Maybe String
    }


type alias Comment =
    { id : Int
    , author : Api.City.Author
    , comment : String
    , action : Maybe Action
    }


type Action
    = Deleting
    | FailedToDelete String
    | Editing
    | FailedToEdit String


type Msg
    = GotCity (Result Http.Error Api.City.City)
    | GotUser (Maybe UserData)
      ----------- Comment -----------
    | GotDeleteCommentResp (Maybe Http.Error) Int
    | DeleteComment Int
    | OpenCommentMenu Int
    | CloseCommentMenu
      -- New Comment
    | StartWritingComment Int
    | ChangeNewComment String Int
      ----------- Itinerary -----------
    | DeletedItinerary (Maybe Http.Error) Int
    | GotNewItinerary (Result Http.Error Api.Itineraries.NewItineraryResponse)
    | GotPatchItineraryResp (Result Http.Error Api.Itineraries.PatchItineraryResponse) Int
    | CloseItineraryMenu
    | DeleteItinerary Int
    | OpenItineraryMenu Int
    | ToggleItineraryComments Int
      -- New Itinerary
    | OpenModal
    | CloseModal
    | ChangeNewItineraryName String
    | ChangeTag1 String
    | ChangeTag2 String
    | ChangeTag3 String
    | ChangeNewItineraryTime String
    | ChangeNewItineraryPrice String
    | ChangeFirstActivity String
    | AddActivity
    | ChangeActivity Int String
    | RemoveActivity Int
    | SubmitForm
      -- Edit Itinerary
    | OpenEditItineraryModal Int
    | CloseEditItineraryModal
    | ChangeEditItineraryName String
    | ChangeEditTag1 String
    | ChangeEditTag2 String
    | ChangeEditTag3 String
    | ChangeEditItineraryTime String
    | ChangeEditItineraryPrice String
    | ChangeEditItineraryFirstActivity String
    | AddEditItineraryActivity
    | ChangeEditItineraryActivity Int String
    | RemoveEditItineraryActivity Int
    | SubmitEditItineraryForm


init : Int -> ( Model, Cmd Msg )
init cityId =
    ( { cityId = cityId
      , cityData = Loading
      , userSession = Nothing
      , commentMenuOpen = Nothing

      -- New itinerary
      , newItineraryName = ""
      , newItineraryFirstActivity = ""
      , newItineraryRestActivities = []
      , newItineraryActivitiesIdx = 0
      , tag1 = ""
      , tag2 = ""
      , tag3 = ""
      , newItineraryTime = 0
      , newItineraryPrice = 0
      , isNewItineraryModalOpen = False
      , isCreatingNewItinerary = False
      , itineraryMenuOpen = Nothing
      , creatingNewItineraryError = ""

      -- Edit itinerary
      , isEditItineraryModalOpen = False
      , editItineraryId = -1
      , editItineraryName = ""
      , editItineraryFirstActivity = ""
      , editItineraryRestActivities = []
      , editItineraryActivitiesIdx = 0
      , editItineraryTime = 0
      , editItineraryPrice = 0
      , editItineraryTag1 = ""
      , editItineraryTag2 = ""
      , editItineraryTag3 = ""
      }
    , Cmd.batch
        [ Api.City.getCity cityId GotCity
        , Session.getLocalStorageUserDataSender ()
        ]
    )


toComment : Api.City.Comment -> Comment
toComment c =
    { author = c.author
    , comment = c.comment
    , id = c.id
    , action = Nothing
    }


toItinerary : Api.City.Itinerary -> Itinerary
toItinerary i =
    { data =
        { id = i.id
        , title = i.title
        , time = i.time
        , price = i.price
        , activities = i.activities
        , hashtags = i.hashtags
        , comments = List.map toComment i.comments
        , creator = i.creator
        }
    , action = Nothing
    , areCommentsExpanded = False
    , newComment = Nothing
    }


toCity : Api.City.City -> City
toCity data =
    { name = data.name
    , country = data.country
    , id = data.id
    , itineraries = List.map toItinerary data.itineraries
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotCity res ->
            case res of
                Ok cityData ->
                    ( { model
                        | cityData =
                            Loaded (toCity cityData)
                      }
                    , Cmd.none
                    )

                Err err ->
                    ( { model | cityData = Error err }, Cmd.none )

        GotUser userSession ->
            ( { model | userSession = userSession }, Cmd.none )

        OpenItineraryMenu idx ->
            ( { model | itineraryMenuOpen = Just idx }
            , Cmd.none
            )

        CloseItineraryMenu ->
            ( { model | itineraryMenuOpen = Nothing }
            , Cmd.none
            )

        DeleteItinerary idx ->
            case model.cityData of
                Loaded cityData ->
                    let
                        newCityData =
                            { cityData
                                | itineraries =
                                    List.map
                                        (\({ data } as itineraryData) ->
                                            if data.id == idx then
                                                { itineraryData | action = Just Deleting }

                                            else
                                                itineraryData
                                        )
                                        cityData.itineraries
                            }
                    in
                    ( { model
                        | itineraryMenuOpen = Nothing
                        , cityData = Loaded newCityData
                      }
                    , Api.Itineraries.deleteItinerary idx
                        (\l ->
                            case l of
                                Ok _ ->
                                    DeletedItinerary Nothing idx

                                Err err ->
                                    DeletedItinerary (Just err) idx
                        )
                    )

                _ ->
                    ( model, Cmd.none )

        DeletedItinerary err idx ->
            case model.cityData of
                Loaded cityData ->
                    case err of
                        Nothing ->
                            ( { model
                                | cityData =
                                    Loaded
                                        { cityData
                                            | itineraries =
                                                List.filter (\{ data } -> data.id /= idx)
                                                    cityData.itineraries
                                        }
                              }
                            , Cmd.none
                            )

                        Just val ->
                            let
                                errorMessage : String
                                errorMessage =
                                    case val of
                                        Http.BadStatus code ->
                                            case code of
                                                400 ->
                                                    "Bad request"

                                                401 ->
                                                    "Unauthorized"

                                                404 ->
                                                    "Not found"

                                                _ ->
                                                    "An unknown error ocurred: code " ++ String.fromInt code

                                        _ ->
                                            "An unknown error ocurred"

                                newCityData =
                                    { cityData
                                        | itineraries =
                                            List.map
                                                (\({ data } as itineraryData) ->
                                                    if data.id == idx then
                                                        { itineraryData | action = Just (FailedToDelete errorMessage) }

                                                    else
                                                        itineraryData
                                                )
                                                cityData.itineraries
                                    }
                            in
                            ( { model | cityData = Loaded newCityData }
                            , Cmd.none
                            )

                _ ->
                    ( model, Cmd.none )

        ToggleItineraryComments idx ->
            case model.cityData of
                Loaded cityData ->
                    let
                        newCityData =
                            { cityData
                                | itineraries =
                                    List.map
                                        (\({ data } as itineraryData) ->
                                            if data.id == idx then
                                                { itineraryData
                                                    | areCommentsExpanded =
                                                        if itineraryData.areCommentsExpanded then
                                                            False

                                                        else
                                                            True
                                                }

                                            else
                                                itineraryData
                                        )
                                        cityData.itineraries
                            }
                    in
                    ( { model | cityData = Loaded newCityData }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

        OpenCommentMenu idx ->
            ( { model | commentMenuOpen = Just idx }
            , Cmd.none
            )

        CloseCommentMenu ->
            ( { model | commentMenuOpen = Nothing }, Cmd.none )

        DeleteComment id ->
            case model.userSession of
                Just _ ->
                    case model.cityData of
                        Loaded cityData ->
                            let
                                itineraries =
                                    cityData.itineraries
                            in
                            ( { model
                                | commentMenuOpen = Nothing
                                , cityData =
                                    Loaded
                                        { cityData
                                            | itineraries =
                                                List.map
                                                    (\({ data } as itineraryData) ->
                                                        let
                                                            iData =
                                                                itineraryData.data
                                                        in
                                                        { itineraryData
                                                            | data =
                                                                { iData
                                                                    | comments =
                                                                        List.map
                                                                            (\c ->
                                                                                if c.id == id then
                                                                                    { c | action = Just Deleting }

                                                                                else
                                                                                    c
                                                                            )
                                                                            iData.comments
                                                                }
                                                        }
                                                    )
                                                    itineraries
                                        }
                              }
                            , Api.Itineraries.deleteComment id
                                (\l ->
                                    case l of
                                        Ok _ ->
                                            GotDeleteCommentResp Nothing id

                                        Err v ->
                                            GotDeleteCommentResp (Just v) id
                                )
                            )

                        _ ->
                            ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        GotDeleteCommentResp resp idx ->
            case model.cityData of
                Loaded cityData ->
                    let
                        itineraries =
                            cityData.itineraries
                    in
                    case resp of
                        Just err ->
                            ( { model
                                | cityData =
                                    Loaded
                                        { cityData
                                            | itineraries =
                                                List.map
                                                    (\({ data } as itineraryData) ->
                                                        let
                                                            iData =
                                                                itineraryData.data
                                                        in
                                                        { itineraryData
                                                            | data =
                                                                { iData
                                                                    | comments =
                                                                        List.map
                                                                            (\c ->
                                                                                if c.id == idx then
                                                                                    { c
                                                                                        | action =
                                                                                            Just
                                                                                                (FailedToDelete
                                                                                                    (case err of
                                                                                                        Http.BadStatus code ->
                                                                                                            case code of
                                                                                                                400 ->
                                                                                                                    "Bad request"

                                                                                                                401 ->
                                                                                                                    "Unauthorized"

                                                                                                                404 ->
                                                                                                                    "Not found"

                                                                                                                _ ->
                                                                                                                    "An unknown error ocurred: code " ++ String.fromInt code

                                                                                                        _ ->
                                                                                                            "An unknown error ocurred"
                                                                                                    )
                                                                                                )
                                                                                    }

                                                                                else
                                                                                    c
                                                                            )
                                                                            iData.comments
                                                                }
                                                        }
                                                    )
                                                    itineraries
                                        }
                              }
                            , Cmd.none
                            )

                        Nothing ->
                            ( { model
                                | cityData =
                                    Loaded
                                        { cityData
                                            | itineraries =
                                                List.map
                                                    (\({ data } as itineraryData) ->
                                                        let
                                                            iData =
                                                                itineraryData.data
                                                        in
                                                        { itineraryData
                                                            | data =
                                                                { iData
                                                                    | comments =
                                                                        List.filter
                                                                            (\c -> c.id /= idx)
                                                                            iData.comments
                                                                }
                                                        }
                                                    )
                                                    itineraries
                                        }
                              }
                            , Cmd.none
                            )

                _ ->
                    ( model, Cmd.none )

        -- New Itinerary
        OpenModal ->
            ( { model | isNewItineraryModalOpen = True }, Cmd.none )

        CloseModal ->
            ( { model | isNewItineraryModalOpen = False } |> clearModalData, Cmd.none )

        SubmitForm ->
            case model.userSession of
                Just _ ->
                    ( { model | isCreatingNewItinerary = True, isNewItineraryModalOpen = False, creatingNewItineraryError = "" }
                    , Api.Itineraries.postItinerary model.cityId
                        { title = model.newItineraryName
                        , activities =
                            model.newItineraryFirstActivity
                                :: (model.newItineraryRestActivities
                                        |> List.filter (\( _, l ) -> l /= "")
                                        |> List.map Tuple.second
                                   )
                        , price = model.newItineraryPrice
                        , tags = [ model.tag1, model.tag2, model.tag3 ]
                        , duration = model.newItineraryTime
                        }
                        GotNewItinerary
                    )

                Nothing ->
                    ( model, Cmd.none )

        GotNewItinerary res ->
            case model.userSession of
                Just userData ->
                    case res of
                        Ok newItinerary ->
                            case model.cityData of
                                Loaded cityData ->
                                    let
                                        itineraries =
                                            cityData.itineraries
                                    in
                                    ( { model
                                        | isCreatingNewItinerary = False
                                        , cityData =
                                            let
                                                newIt : Api.City.Itinerary
                                                newIt =
                                                    { id = newItinerary.id
                                                    , title = newItinerary.title
                                                    , time = newItinerary.time
                                                    , price = newItinerary.price
                                                    , activities = newItinerary.activities
                                                    , hashtags = newItinerary.hashtags
                                                    , comments = []
                                                    , creator =
                                                        { id = userData.id
                                                        , username = userData.username
                                                        , profilePic = userData.profile_pic
                                                        }
                                                    }
                                            in
                                            Loaded
                                                { cityData
                                                    | itineraries = toItinerary newIt :: itineraries
                                                }
                                      }
                                    , Cmd.none
                                    )

                                _ ->
                                    ( model, Cmd.none )

                        Err err ->
                            let
                                errorMessage : String
                                errorMessage =
                                    case err of
                                        Http.BadStatus code ->
                                            case code of
                                                400 ->
                                                    "Bad request"

                                                401 ->
                                                    "Unauthorized"

                                                404 ->
                                                    "Not found"

                                                _ ->
                                                    "An unknown error ocurred: code " ++ String.fromInt code

                                        _ ->
                                            "An unknown error ocurred"
                            in
                            ( { model
                                | isCreatingNewItinerary = False
                                , creatingNewItineraryError = errorMessage
                              }
                            , Cmd.none
                            )

                Nothing ->
                    ( model, Cmd.none )

        GotPatchItineraryResp res idx ->
            case model.cityData of
                Loaded cityData ->
                    case res of
                        Ok patchedItinerary ->
                            ( { model
                                | cityData =
                                    Loaded
                                        { cityData
                                            | itineraries =
                                                List.map
                                                    (\({ data } as itineraryData) ->
                                                        if data.id == idx then
                                                            { itineraryData
                                                                | data =
                                                                    { id = data.id
                                                                    , title = patchedItinerary.title
                                                                    , activities = patchedItinerary.activities
                                                                    , price = patchedItinerary.price
                                                                    , time = patchedItinerary.time
                                                                    , hashtags = patchedItinerary.hashtags
                                                                    , comments = data.comments
                                                                    , creator = data.creator
                                                                    }
                                                                , action = Nothing
                                                            }

                                                        else
                                                            itineraryData
                                                    )
                                                    cityData.itineraries
                                        }
                              }
                            , Cmd.none
                            )

                        Err err ->
                            let
                                errorMessage : String
                                errorMessage =
                                    case err of
                                        Http.BadStatus code ->
                                            case code of
                                                400 ->
                                                    "Bad request"

                                                401 ->
                                                    "Unauthorized"

                                                404 ->
                                                    "Not found"

                                                _ ->
                                                    "An unknown error ocurred: code " ++ String.fromInt code

                                        _ ->
                                            "An unknown error ocurred"

                                newCityData =
                                    { cityData
                                        | itineraries =
                                            List.map
                                                (\({ data } as itineraryData) ->
                                                    if data.id == idx then
                                                        { itineraryData | action = Just (FailedToEdit errorMessage) }

                                                    else
                                                        itineraryData
                                                )
                                                cityData.itineraries
                                    }
                            in
                            ( { model | cityData = Loaded newCityData }
                            , Cmd.none
                            )

                _ ->
                    ( model, Cmd.none )

        ChangeNewItineraryName newItineraryName ->
            ( { model | newItineraryName = newItineraryName }, Cmd.none )

        ChangeNewItineraryTime newItineraryTime ->
            ( { model | newItineraryTime = Maybe.withDefault 0 (String.toInt newItineraryTime) }, Cmd.none )

        ChangeNewItineraryPrice newItineraryPrice ->
            ( { model | newItineraryPrice = Maybe.withDefault 0 (String.toInt newItineraryPrice) }, Cmd.none )

        ChangeTag1 newTag ->
            ( { model | tag1 = newTag }, Cmd.none )

        ChangeTag2 newTag ->
            ( { model | tag2 = newTag }, Cmd.none )

        ChangeTag3 newTag ->
            ( { model | tag3 = newTag }, Cmd.none )

        ChangeFirstActivity newFirstActivity ->
            ( { model | newItineraryFirstActivity = newFirstActivity }, Cmd.none )

        RemoveActivity idx ->
            let
                restActivities =
                    List.filter (\( i, _ ) -> i /= idx) model.newItineraryRestActivities
            in
            ( { model | newItineraryRestActivities = restActivities }, Cmd.none )

        AddActivity ->
            let
                newIdx =
                    model.newItineraryActivitiesIdx + 1
            in
            ( { model
                | newItineraryRestActivities = model.newItineraryRestActivities ++ [ ( newIdx, "" ) ]
                , newItineraryActivitiesIdx = newIdx
              }
            , Cmd.none
            )

        ChangeActivity idx newActivity ->
            let
                activities =
                    model.newItineraryRestActivities
            in
            ( { model
                | newItineraryRestActivities =
                    List.map
                        (\( id, act ) ->
                            if idx == id then
                                ( id, newActivity )

                            else
                                ( id, act )
                        )
                        activities
              }
            , Cmd.none
            )

        -- Edit Itinerary
        OpenEditItineraryModal id ->
            case model.cityData of
                Loaded cityData ->
                    let
                        itineraryData =
                            List.filter (\{ data } -> data.id == id) cityData.itineraries
                                |> List.head
                    in
                    case itineraryData of
                        Just { data } ->
                            let
                                ( firstActivity, otherActivities ) =
                                    case data.activities of
                                        first :: other ->
                                            ( first, other )

                                        _ ->
                                            ( "", [] )

                                restActivities =
                                    List.indexedMap Tuple.pair otherActivities

                                ( tag1, tag2, tag3 ) =
                                    case data.hashtags of
                                        t1 :: t2 :: t3 :: _ ->
                                            ( t1, t2, t3 )

                                        _ ->
                                            ( "", "", "" )
                            in
                            ( { model
                                | isEditItineraryModalOpen = True
                                , editItineraryId = id
                                , editItineraryName = data.title
                                , editItineraryTime = data.time
                                , editItineraryPrice = data.price
                                , editItineraryFirstActivity = firstActivity
                                , editItineraryRestActivities = restActivities
                                , editItineraryActivitiesIdx = List.length restActivities
                                , editItineraryTag1 = tag1
                                , editItineraryTag2 = tag2
                                , editItineraryTag3 = tag3
                              }
                            , Cmd.none
                            )

                        Nothing ->
                            ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        CloseEditItineraryModal ->
            ( { model | isEditItineraryModalOpen = False }, Cmd.none )

        ChangeEditItineraryName newEditItineraryName ->
            ( { model | editItineraryName = newEditItineraryName }, Cmd.none )

        ChangeEditItineraryTime newEditItineraryTime ->
            ( { model | editItineraryTime = Maybe.withDefault 0 (String.toInt newEditItineraryTime) }, Cmd.none )

        ChangeEditItineraryPrice newEditItineraryPrice ->
            ( { model | editItineraryPrice = Maybe.withDefault 0 (String.toInt newEditItineraryPrice) }, Cmd.none )

        ChangeEditTag1 newEditTag ->
            ( { model | editItineraryTag1 = newEditTag }, Cmd.none )

        ChangeEditTag2 newEditTag ->
            ( { model | editItineraryTag2 = newEditTag }, Cmd.none )

        ChangeEditTag3 newEditTag ->
            ( { model | editItineraryTag3 = newEditTag }, Cmd.none )

        ChangeEditItineraryFirstActivity newEditFirstActivity ->
            ( { model | editItineraryFirstActivity = newEditFirstActivity }, Cmd.none )

        RemoveEditItineraryActivity idx ->
            let
                restActivities =
                    List.filter (\( i, _ ) -> i /= idx) model.editItineraryRestActivities
            in
            ( { model | editItineraryRestActivities = restActivities }, Cmd.none )

        AddEditItineraryActivity ->
            let
                newIdx =
                    model.editItineraryActivitiesIdx + 1
            in
            ( { model
                | editItineraryRestActivities = model.editItineraryRestActivities ++ [ ( newIdx, "" ) ]
                , editItineraryActivitiesIdx = newIdx
              }
            , Cmd.none
            )

        ChangeEditItineraryActivity idx newActivity ->
            let
                activities =
                    model.editItineraryRestActivities
            in
            ( { model
                | editItineraryRestActivities =
                    List.map
                        (\( id, act ) ->
                            if idx == id then
                                ( id, newActivity )

                            else
                                ( id, act )
                        )
                        activities
              }
            , Cmd.none
            )

        SubmitEditItineraryForm ->
            case model.cityData of
                Loaded cityData ->
                    let
                        itineraries =
                            cityData.itineraries
                    in
                    case model.userSession of
                        Just _ ->
                            let
                                itineraryBeingEditedId =
                                    model.editItineraryId
                            in
                            ( { model
                                | isEditItineraryModalOpen = False
                                , cityData =
                                    Loaded
                                        { cityData
                                            | itineraries =
                                                List.map
                                                    (\({ data } as itineraryData) ->
                                                        if data.id == itineraryBeingEditedId then
                                                            { itineraryData | action = Just Editing }

                                                        else
                                                            itineraryData
                                                    )
                                                    itineraries
                                        }
                              }
                            , Api.Itineraries.patchItinerary model.editItineraryId
                                { title = model.editItineraryName
                                , activities =
                                    model.editItineraryFirstActivity
                                        :: (model.editItineraryRestActivities
                                                |> List.filter (\( _, l ) -> l /= "")
                                                |> List.map Tuple.second
                                           )
                                , price = model.editItineraryPrice
                                , hashtags = [ model.editItineraryTag1, model.editItineraryTag2, model.editItineraryTag3 ]
                                , time = model.editItineraryTime
                                }
                                (\l -> GotPatchItineraryResp l model.editItineraryId)
                            )

                        Nothing ->
                            ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        -- New Itinerary Comment
        StartWritingComment itineraryId ->
            case model.cityData of
                Loaded cityData ->
                    ( { model
                        | cityData =
                            Loaded
                                { cityData
                                    | itineraries =
                                        List.map
                                            (\i ->
                                                if i.data.id == itineraryId then
                                                    { i
                                                        | newComment =
                                                            Just
                                                                { text = ""
                                                                , isCreating = False
                                                                , error = Nothing
                                                                }
                                                    }

                                                else
                                                    i
                                            )
                                            cityData.itineraries
                                }
                      }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

        ChangeNewComment newComment id ->
            case model.cityData of
                Loaded cityData ->
                    ( { model
                        | cityData =
                            Loaded
                                { cityData
                                    | itineraries =
                                        List.map
                                            (\i ->
                                                if i.data.id == id then
                                                    let
                                                        c =
                                                            i.newComment
                                                    in
                                                    { i
                                                        | newComment =
                                                            case c of
                                                                Just commentData ->
                                                                    Just
                                                                        { commentData
                                                                            | text = newComment
                                                                        }

                                                                Nothing ->
                                                                    c
                                                    }

                                                else
                                                    i
                                            )
                                            cityData.itineraries
                                }
                      }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )


view : Model -> Browser.Document Msg
view ({ cityData, isCreatingNewItinerary } as model) =
    let
        cityName =
            case cityData of
                Loading ->
                    "Loading city..."

                Loaded { name } ->
                    name

                Error _ ->
                    "Failed to load city"
    in
    { title = cityName
    , body =
        [ case cityData of
            Loading ->
                text "Loading"

            Loaded { country, itineraries, name } ->
                div [ class "h-full flex flex-col" ]
                    [ div
                        [ class "block relative py-8 text-white text-center"
                        ]
                        [ img [ class "city-bgr bg-black", src ("https://source.unsplash.com/featured/?" ++ name) ] []
                        , h1 [ class "text-3xl font-semibold mb-2" ] [ text name ]
                        , p [ class "text-2xl" ] [ text country ]
                        ]
                    , div [ class "bg-gray-200 flex-grow" ]
                        [ h2
                            [ class "pt-2 text-center text-2xl" ]
                            [ text "Itineraries" ]
                        , div [ class "px-4 my-2 flex flex-col gap-y-4" ]
                            [ if model.creatingNewItineraryError /= "" then
                                div [ class "mx-auto w-full md:w-72 block font-bold rounded" ]
                                    [ div [ class "bg-red-100 p-2 font-semibold flex gap-x-2" ]
                                        [ errorSvg
                                        , p [ class "text-red-700" ] [ text model.creatingNewItineraryError ]
                                        ]
                                    ]

                              else
                                text ""
                            , button
                                [ onClick OpenModal
                                , class "mx-auto w-full md:w-64 block font-bold py-2 px-4 rounded"
                                , classList
                                    [ ( "bg-blue-700 hover:bg-blue-700 text-white", not isCreatingNewItinerary )
                                    , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", isCreatingNewItinerary )
                                    ]
                                ]
                                [ if isCreatingNewItinerary then
                                    text "Creating itinerary..."

                                  else
                                    text "Create Itinerary"
                                ]
                            ]
                        , if List.length itineraries == 0 then
                            p [ class "text-xl text-center mt-5" ] [ text "There are no itineraries" ]

                          else
                            ul [ class "container mx-auto px-4 pb-4 flex flex-col md:flex-row md:flex-wrap items-stretch" ]
                                (List.map (\l -> li [ class "md:w-1/2 xl:w-1/3 w-full p-2" ] [ itinerary l model ]) itineraries)
                        ]
                    ]

            Error err ->
                case err of
                    Http.BadStatus int ->
                        if int == 404 then
                            div [ class "flex flex-col text-center mt-12" ]
                                [ p [ class "text-6xl font-bold" ] [ text "404" ]
                                , p [ class "text-3xl" ] [ text "City not found" ]
                                ]

                        else
                            p [ class "text-center text-xl mt-5" ] [ text "An unknown error ocurred, please refresh the page and try again." ]

                    _ ->
                        p [ class "text-center text-xl mt-5" ] [ text "An unknown error ocurred, please refresh the page and try again." ]
        , if model.isNewItineraryModalOpen then
            modal
                { name = model.newItineraryName
                , time = model.newItineraryTime
                , price = model.newItineraryPrice
                , tag1 = model.tag1
                , tag2 = model.tag2
                , tag3 = model.tag3
                , firstActivity = model.newItineraryFirstActivity
                , restActivities = model.newItineraryRestActivities
                }
                model.isCreatingNewItinerary

          else
            text ""
        , case cityData of
            Loaded loadedCityData ->
                if model.isEditItineraryModalOpen then
                    editItineraryModal
                        { name = model.editItineraryName
                        , time = model.editItineraryTime
                        , price = model.editItineraryPrice
                        , tag1 = model.editItineraryTag1
                        , tag2 = model.editItineraryTag2
                        , tag3 = model.editItineraryTag3
                        , firstActivity = model.editItineraryFirstActivity
                        , restActivities = model.editItineraryRestActivities
                        }
                        (loadedCityData.itineraries
                            |> List.any
                                (\{ data, action } ->
                                    if data.id == model.editItineraryId then
                                        case action of
                                            Just Editing ->
                                                True

                                            _ ->
                                                False

                                    else
                                        False
                                )
                        )

                else
                    text ""

            _ ->
                text ""
        ]
    }


itinerary : Itinerary -> Model -> Html Msg
itinerary { data, action, areCommentsExpanded, newComment } model =
    let
        thisItineraryIsBeingDeleted : Bool
        thisItineraryIsBeingDeleted =
            case action of
                Just status ->
                    case status of
                        Deleting ->
                            True

                        _ ->
                            False

                _ ->
                    False

        infoHtml : String -> Html msg
        infoHtml err =
            div [ class "bg-blue-100 p-2 font-semibold" ]
                [ p [ class "text-blue-700" ] [ text err ]
                ]

        errorHtml : String -> Html msg
        errorHtml err =
            div [ class "bg-red-100 p-2 font-semibold" ]
                [ p [ class "text-red-700" ] [ text err ]
                ]

        newCommentHtml : Html Msg
        newCommentHtml =
            case newComment of
                Just newCommentData ->
                    div [ class "p-4" ]
                        [ div []
                            [ label
                                [ class "block text-sm font-medium text-gray-700"
                                , for "new-comment"
                                ]
                                [ text "New Comment" ]
                            ]
                        , div [ class "mt-1" ]
                            [ textarea
                                [ class "shadow-sm mt-1 block w-full sm:text-sm border border-gray-300 rounded-md p-1"
                                , id "new-comment"
                                , placeholder "Leave a comment..."
                                , rows 3
                                , onInput (\l -> ChangeNewComment l data.id)
                                ]
                                []
                            ]
                        , p [ class "mt-2 text-sm text-gray-500" ]
                            [ text
                                ((newCommentData.text
                                    |> String.length
                                    |> String.fromInt
                                 )
                                    ++ "/300"
                                )
                            ]
                        ]

                Nothing ->
                    text ""
    in
    div [ class "mt-3 flex flex-col rounded shadow-sm bg-white md:h-full md:justify-between" ]
        ([ case action of
            Just status ->
                case status of
                    Deleting ->
                        errorHtml "Deleting itinerary..."

                    FailedToDelete err ->
                        errorHtml err

                    Editing ->
                        infoHtml "Editing itinerary..."

                    FailedToEdit err ->
                        errorHtml err

            Nothing ->
                text ""
         , div [ class "p-3" ]
            [ div [ class "flex flex-row mb-2" ]
                ([ if data.creator.profilePic == Nothing then
                    div [ class "pointer-events-none w-12 h-12 bg-red-500 text-white capitalize rounded-full flex" ]
                        [ div [ class "flex w-12 h-12" ] [ p [ class "m-auto text-xl" ] [ text (String.left 1 data.creator.username) ] ]
                        ]

                   else
                    img [ class "pointer-events-none w-12 h-12 rounded-full" ] []
                 , h3 [ class "ml-3 self-center text-lg truncate" ] [ text data.title ]
                 ]
                    ++ (case model.userSession of
                            Just userData ->
                                if userData.id == data.creator.id then
                                    [ div [ class "ml-auto relative" ]
                                        [ button [ onClick (OpenItineraryMenu data.id), class "w-12 h-12", disabled thisItineraryIsBeingDeleted ]
                                            [ div [ class "flex w-12 h-12", classList [ ( "text-gray-400", thisItineraryIsBeingDeleted ) ] ] [ verticalDotsSvg ]
                                            ]
                                        , div
                                            [ classList
                                                [ ( "hidden"
                                                  , not (Maybe.withDefault -1 model.itineraryMenuOpen == data.id)
                                                  )
                                                ]
                                            , id ("itinerary-menu-" ++ String.fromInt data.id)
                                            ]
                                            [ ul [ class "flex flex-col gap-y-2 absolute top-0 right-0 bg-white shadow-md" ]
                                                [ li []
                                                    [ button [ class "w-full px-2 py-1", onClick (DeleteItinerary data.id) ] [ text "Delete" ]
                                                    ]
                                                , li []
                                                    [ button [ class "w-full px-2 py-1", onClick (OpenEditItineraryModal data.id) ] [ text "Edit" ]
                                                    ]
                                                ]
                                            ]
                                        ]
                                    ]

                                else
                                    []

                            Nothing ->
                                []
                       )
                )
            , div [ class "flex flex-grow" ]
                [ div [ class "flex-grow" ]
                    [ p [ class "font-semibold" ] [ text "Activities:" ]
                    , ul [ class "list-disc list-inside" ]
                        (List.map (\l -> li [] [ text l ]) data.activities)
                    ]

                -- vertical line
                , div [ class "w-px h-auto bg-gray-300" ] []
                , div [ class "w-16 flex flex-col pl-2" ]
                    [ p [ class "flex items-center" ] [ p [ class "text-xl" ] [ text "$" ], text (String.fromInt data.price) ]
                    , div [ class "flex items-center" ]
                        [ clockSvg
                        , p [] [ text (String.fromInt data.time) ]
                        ]
                    ]
                ]
            , div [ class "flex capitalize mt-3 gap-x-2 flex-wrap" ]
                (data.hashtags
                    |> List.filter ((/=) "")
                    |> List.map
                        (\l -> div [ class "rounded-full py-1 px-2 bg-red-200" ] [ text ("#" ++ l) ])
                )
            ]
         , button [ onClick (ToggleItineraryComments data.id), class "p-2 flex text-l font-semibold" ]
            [ p [ class "flex-grow" ]
                [ text
                    ("Comments ("
                        ++ (data.comments
                                |> List.length
                                |> String.fromInt
                           )
                        ++ ")"
                    )
                ]
            , div [ class "pr-2" ]
                [ chevronDownSvg
                    [ Svg.Attributes.class "transform-gpu h-6 w-6"
                    , Svg.Attributes.class
                        (if areCommentsExpanded then
                            ""

                         else
                            "rotate-180 origin-center"
                        )
                    ]
                ]
            ]
         ]
            ++ (if areCommentsExpanded then
                    [ div [ class "w-full h-px bg-gray-200" ] [] ]
                        ++ [ newCommentHtml ]
                        ++ [ div [ class "p-4 flex gap-x-4 justify-between" ]
                                (case model.userSession of
                                    Just userData ->
                                        let
                                            myCommentsAmount =
                                                data.comments
                                                    |> List.filter (\c -> c.author.id == userData.id)
                                                    |> List.length
                                        in
                                        [ button
                                            [ type_ "submit"
                                            , class "font-bold py-2 px-4 rounded"
                                            , classList
                                                [ ( "bg-blue-700 hover:bg-blue-700 text-white", myCommentsAmount > 0 )
                                                , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", myCommentsAmount == 0 )
                                                ]
                                            , disabled (myCommentsAmount == 0)
                                            ]
                                            [ text
                                                ("My comments ("
                                                    ++ (myCommentsAmount |> String.fromInt)
                                                    ++ ")"
                                                )
                                            ]
                                        , button
                                            [ type_ "submit"
                                            , onClick (StartWritingComment data.id)
                                            , class "font-bold py-2 px-4 rounded bg-blue-700 hover:bg-blue-700 text-white"
                                            ]
                                            [ text "Post comment" ]
                                        ]

                                    Nothing ->
                                        []
                                )
                           , ul [ class "flex flex-col" ]
                                (List.map
                                    (\comment ->
                                        itineraryComment comment
                                            (case model.commentMenuOpen of
                                                Just commentId ->
                                                    commentId == comment.id

                                                Nothing ->
                                                    False
                                            )
                                    )
                                    data.comments
                                )
                           ]

                else
                    [ text "" ]
               )
        )


itineraryComment : Comment -> Bool -> Html Msg
itineraryComment ({ author, comment, action } as commentData) isMenuOpen =
    let
        isBeingDeleted =
            case action of
                Just Deleting ->
                    True

                _ ->
                    False

        errorHtml : String -> Html msg
        errorHtml err =
            div [ class "bg-red-100 p-2 font-semibold" ]
                [ p [ class "text-red-700" ] [ text err ]
                ]

        infoHtml : String -> Html msg
        infoHtml err =
            div [ class "bg-blue-100 p-2 font-semibold" ]
                [ p [ class "text-blue-700" ] [ text err ]
                ]
    in
    li []
        [ case action of
            Just status ->
                case status of
                    Deleting ->
                        infoHtml "Deleting..."

                    FailedToDelete errMsg ->
                        errorHtml errMsg

                    Editing ->
                        infoHtml "Editing..."

                    FailedToEdit errMsg ->
                        errorHtml errMsg

            Nothing ->
                text ""
        , div [ class "p-4" ]
            [ div [ class "flex items-center" ]
                [ div [ class "pointer-events-none w-10 h-10 bg-red-500 text-white capitalize rounded-full flex" ]
                    [ div [ class "flex w-10 h-10" ] [ p [ class "m-auto text-xl" ] [ text (String.left 1 author.username) ] ]
                    ]
                , p [ class "ml-3 capitalize" ] [ text author.username ]
                , div
                    [ class "ml-auto relative" ]
                    [ button [ onClick (OpenCommentMenu commentData.id), class "w-12 h-12", disabled isBeingDeleted ]
                        [ div [ class "flex w-12 h-12", classList [ ( "text-gray-400", isBeingDeleted ) ] ] [ verticalDotsSvg ]
                        ]
                    , div
                        [ classList
                            [ ( "hidden"
                              , not isMenuOpen
                              )
                            ]
                        , id ("comment-menu-" ++ String.fromInt commentData.id)
                        ]
                        [ ul [ class "flex flex-col gap-y-2 absolute top-0 right-0 bg-white shadow-md" ]
                            [ li []
                                [ button [ class "w-full px-2 py-1", onClick (DeleteComment commentData.id) ] [ text "Delete" ]
                                ]

                            -- TODO
                            -- , li []
                            --     [ button [ class "w-full px-2 py-1", onClick (OpenEditItineraryModal data.id) ] [ text "Edit" ]
                            --     ]
                            ]
                        ]
                    ]
                ]
            , text comment
            ]
        ]


modal : ItineraryFormData -> Bool -> Html Msg
modal ({ name, price, tag1, tag2, tag3, time } as data) isCreatingNewItinerary =
    let
        canCreate =
            validateFormData data && not isCreatingNewItinerary
    in
    div [ class "fixed z-50 inset-0 overflow-y-auto" ]
        [ div [ class "flex items-center justify-center min-h-screen px-4 text-center sm:block sm:p-0" ]
            [ div [ class "fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity", onClick CloseModal ]
                []
            , span [ class "hidden sm:inline-block sm:align-middle sm:h-screen" ]
                [ text "\u{200B}" ]
            , div [ class "py-6 w-11/12 inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" ]
                [ h2 [ class "text-2xl text-center mb-4" ] [ text "New Itinerary" ]
                , form
                    [ onSubmit SubmitForm
                    , class
                        "flex flex-col container mx-auto px-4 gap-y-4"
                    ]
                    [ div []
                        [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "itinerary-name" ]
                            [ text "Name*" ]
                        , input
                            [ required True
                            , value name
                            , onInput ChangeNewItineraryName
                            , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            , placeholder "name"
                            , id "itinerary-name"
                            , type_ "text"
                            ]
                            []
                        ]
                    , div [ class "flex flex-col gap-y-4 md:flex-row md:gap-x-4 md:justify-between" ]
                        [ div [ class "md:w-full" ]
                            [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "price" ]
                                [ text "Price*" ]
                            , input
                                [ required True
                                , value (String.fromInt price)
                                , onInput ChangeNewItineraryPrice
                                , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , id "price"
                                , type_ "number"
                                , Html.Attributes.min "1"
                                ]
                                []
                            ]
                        , div [ class "md:w-full" ]
                            [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "time" ]
                                [ text "Time*" ]
                            , input
                                [ required True
                                , value (String.fromInt time)
                                , onInput ChangeNewItineraryTime
                                , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , id "time"
                                , type_ "number"
                                , Html.Attributes.min "1"
                                ]
                                []
                            ]
                        ]
                    , div []
                        [ p [ class "block text-gray-700 text-xl mb-2" ]
                            [ text "Tags" ]
                        , div [ class "flex flex-col gap-y-4 md:gap-x-4 md:flex-row" ]
                            [ div [ class "md:w-1/3" ]
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-1"
                                    ]
                                    [ text "Tag #1" ]
                                , input
                                    [ value tag1
                                    , onInput ChangeTag1
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-1"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            , div [ class "md:w-1/3" ]
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-2"
                                    ]
                                    [ text "Tag #2" ]
                                , input
                                    [ value tag2
                                    , onInput ChangeTag2
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-2"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            , div [ class "md:w-1/3" ]
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-3"
                                    ]
                                    [ text "Tag #3" ]
                                , input
                                    [ value tag3
                                    , onInput ChangeTag3
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-3"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            ]
                        ]
                    , formActivities data isCreatingNewItinerary
                    , div [ class "flex ml-auto gap-x-4" ]
                        [ button [ class "px-4 py-2", type_ "button", onClick CloseModal ] [ text "Cancel" ]
                        , button
                            [ type_ "submit"
                            , class "font-bold py-2 px-4 rounded"
                            , classList
                                [ ( "bg-blue-700 hover:bg-blue-700 text-white", canCreate )
                                , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", not canCreate )
                                ]
                            , disabled (not canCreate)
                            ]
                            [ text
                                (if isCreatingNewItinerary then
                                    "Creating..."

                                 else
                                    "Create"
                                )
                            ]
                        ]
                    ]
                ]
            ]
        ]


formActivities : ItineraryFormData -> Bool -> Html Msg
formActivities { firstActivity, restActivities } isCreatingNewItinerary =
    let
        otherActivities =
            List.indexedMap
                (\i ( idxNumber, content ) ->
                    let
                        idx =
                            String.fromInt idxNumber
                    in
                    div
                        [ class "flex flex-col" ]
                        [ label
                            [ class "block text-gray-700 text-sm font-bold mb-2"
                            , for ("activity-" ++ idx)
                            ]
                            [ text ("Activity #" ++ String.fromInt (i + 2))
                            ]
                        , div [ class "flex rounded w-full shadow border" ]
                            [ input
                                [ value content
                                , onInput (ChangeActivity idxNumber)
                                , class "appearance-none w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , id ("activity-" ++ idx)
                                , type_ "text"
                                ]
                                []
                            , button
                                [ type_ "button"
                                , onClick (RemoveActivity idxNumber)
                                , class "bg-red-100 px-2 flex h-auto items-center ml-auto"
                                ]
                                [ div [ class "text-red-500" ] [ xSvg ]
                                ]
                            ]
                        ]
                )
                restActivities

        maxAmountOfActivitiesReached =
            (List.length restActivities + 1) == 50

        canCreate =
            not maxAmountOfActivitiesReached && not isCreatingNewItinerary
    in
    div [ class "flex flex-col" ]
        [ p [ class "block text-gray-700 text-xl mb-2" ]
            [ text "Activities" ]
        , div
            [ class "flex flex-col gap-y-4" ]
            (div [ class "flex flex-col" ]
                [ label
                    [ class "block text-gray-700 text-sm font-bold mb-2"
                    , for "activity-0"
                    ]
                    [ text "Activity #1*" ]
                , input
                    [ required True
                    , value firstActivity
                    , onInput ChangeFirstActivity
                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    , id "activity-0"
                    , type_ "text"
                    ]
                    []
                ]
                :: otherActivities
                ++ [ button
                        [ class "font-bold py-2 px-4 rounded"
                        , classList
                            [ ( "bg-blue-700 hover:bg-blue-700 text-white", canCreate )
                            , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", not canCreate )
                            ]
                        , type_ "button"
                        , onClick AddActivity
                        , disabled (not canCreate)
                        ]
                        [ if maxAmountOfActivitiesReached then
                            text "Max activities reached!"

                          else
                            text "Add Activity"
                        ]
                   ]
            )
        ]


editItineraryModal : ItineraryFormData -> Bool -> Html Msg
editItineraryModal ({ name, price, tag1, tag2, tag3, time } as data) isEditingItinerary =
    let
        canEdit =
            validateFormData data && not isEditingItinerary
    in
    div [ class "fixed z-50 inset-0 overflow-y-auto" ]
        [ div [ class "flex items-center justify-center min-h-screen px-4 text-center sm:block sm:p-0" ]
            [ div [ class "fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity", onClick CloseEditItineraryModal ]
                []
            , span [ class "hidden sm:inline-block sm:align-middle sm:h-screen" ]
                [ text "\u{200B}" ]
            , div [ class "py-6 w-11/12 inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" ]
                [ h2 [ class "text-2xl text-center mb-4" ] [ text "Edit Itinerary" ]
                , form
                    [ onSubmit SubmitEditItineraryForm
                    , class
                        "flex flex-col container mx-auto px-4 gap-y-4"
                    ]
                    [ div []
                        [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "itinerary-name" ]
                            [ text "Name*" ]
                        , input
                            [ required True
                            , value name
                            , onInput ChangeEditItineraryName
                            , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            , placeholder "name"
                            , id "itinerary-name"
                            , type_ "text"
                            ]
                            []
                        ]
                    , div [ class "flex flex-col gap-y-4 md:flex-row md:gap-x-4 md:justify-between" ]
                        [ div [ class "md:w-full" ]
                            [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "price" ]
                                [ text "Price*" ]
                            , input
                                [ required True
                                , value (String.fromInt price)
                                , onInput ChangeEditItineraryPrice
                                , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , id "price"
                                , type_ "number"
                                , Html.Attributes.min "1"
                                ]
                                []
                            ]
                        , div [ class "md:w-full" ]
                            [ label [ class "block text-gray-700 text-sm font-bold mb-2", for "time" ]
                                [ text "Time*" ]
                            , input
                                [ required True
                                , value (String.fromInt time)
                                , onInput ChangeEditItineraryTime
                                , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , id "time"
                                , type_ "number"
                                , Html.Attributes.min "1"
                                ]
                                []
                            ]
                        ]
                    , div []
                        [ p [ class "block text-gray-700 text-xl mb-2" ]
                            [ text "Tags" ]
                        , div [ class "flex flex-col gap-y-4 md:gap-x-4 md:flex-row" ]
                            [ div [ class "md:w-1/3" ]
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-1"
                                    ]
                                    [ text "Tag #1" ]
                                , input
                                    [ value tag1
                                    , onInput ChangeEditTag1
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-1"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            , div [ class "md:w-1/3" ]
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-2"
                                    ]
                                    [ text "Tag #2" ]
                                , input
                                    [ value tag2
                                    , onInput ChangeEditTag2
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-2"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            , div [ class "md:w-1/3" ]
                                [ label
                                    [ class "block text-gray-700 text-sm font-bold mb-2"
                                    , for "tag-3"
                                    ]
                                    [ text "Tag #3" ]
                                , input
                                    [ value tag3
                                    , onInput ChangeEditTag3
                                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    , id "tag-3"
                                    , type_ "text"
                                    ]
                                    []
                                ]
                            ]
                        ]
                    , editFormActivities data isEditingItinerary
                    , div [ class "flex ml-auto gap-x-4" ]
                        [ button [ class "px-4 py-2", type_ "button", onClick CloseEditItineraryModal ] [ text "Cancel" ]
                        , button
                            [ type_ "submit"
                            , class "font-bold py-2 px-4 rounded"
                            , classList
                                [ ( "bg-blue-700 hover:bg-blue-700 text-white", canEdit )
                                , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", not canEdit )
                                ]
                            , disabled (not canEdit)
                            ]
                            [ text
                                (if isEditingItinerary then
                                    "Editing..."

                                 else
                                    "Edit"
                                )
                            ]
                        ]
                    ]
                ]
            ]
        ]


editFormActivities : ItineraryFormData -> Bool -> Html Msg
editFormActivities { firstActivity, restActivities } isEditingItinerary =
    let
        otherActivities =
            List.indexedMap
                (\i ( idxNumber, content ) ->
                    let
                        idx =
                            String.fromInt idxNumber
                    in
                    div
                        [ class "flex flex-col" ]
                        [ label
                            [ class "block text-gray-700 text-sm font-bold mb-2"
                            , for ("activity-" ++ idx)
                            ]
                            [ text ("Activity #" ++ String.fromInt (i + 2))
                            ]
                        , div [ class "flex rounded w-full shadow border" ]
                            [ input
                                [ value content
                                , onInput (ChangeEditItineraryActivity idxNumber)
                                , class "appearance-none w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , id ("activity-" ++ idx)
                                , type_ "text"
                                ]
                                []
                            , button
                                [ type_ "button"
                                , onClick (RemoveEditItineraryActivity idxNumber)
                                , class "bg-red-100 px-2 flex h-auto items-center ml-auto"
                                ]
                                [ div [ class "text-red-500" ] [ xSvg ]
                                ]
                            ]
                        ]
                )
                restActivities

        maxAmountOfActivitiesReached =
            (List.length restActivities + 1) == 50

        canCreate =
            not maxAmountOfActivitiesReached && not isEditingItinerary
    in
    div [ class "flex flex-col" ]
        [ p [ class "block text-gray-700 text-xl mb-2" ]
            [ text "Activities" ]
        , div
            [ class "flex flex-col gap-y-4" ]
            (div [ class "flex flex-col" ]
                [ label
                    [ class "block text-gray-700 text-sm font-bold mb-2"
                    , for "activity-0"
                    ]
                    [ text "Activity #1*" ]
                , input
                    [ required True
                    , value firstActivity
                    , onInput ChangeEditItineraryFirstActivity
                    , class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    , id "activity-0"
                    , type_ "text"
                    ]
                    []
                ]
                :: otherActivities
                ++ [ button
                        [ class "font-bold py-2 px-4 rounded"
                        , classList
                            [ ( "bg-blue-700 hover:bg-blue-700 text-white", canCreate )
                            , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", not canCreate )
                            ]
                        , type_ "button"
                        , onClick AddEditItineraryActivity
                        , disabled (not canCreate)
                        ]
                        [ if maxAmountOfActivitiesReached then
                            text "Max activities reached!"

                          else
                            text "Add Activity"
                        ]
                   ]
            )
        ]


validateFormData : ItineraryFormData -> Bool
validateFormData { name, firstActivity, tag1, tag2, tag3, time, price } =
    let
        nameIsValid : Bool
        nameIsValid =
            name
                |> String.trim
                |> (/=) ""

        firstActivityIsValid : Bool
        firstActivityIsValid =
            firstActivity
                |> String.trim
                |> (/=) ""

        atLeastOneTagIsNotEmpty : Bool
        atLeastOneTagIsNotEmpty =
            [ tag1, tag2, tag3 ]
                |> List.map String.trim
                |> List.filter ((/=) "")
                |> List.length
                |> (<) 0

        timeIsValid : Bool
        timeIsValid =
            time > 0

        priceIsValid : Bool
        priceIsValid =
            price > 0
    in
    nameIsValid
        && firstActivityIsValid
        && atLeastOneTagIsNotEmpty
        && timeIsValid
        && priceIsValid



-- https://dev.to/margaretkrutikova/elm-dom-node-decoder-to-detect-click-outside-3ioh


isOutsideDropdown : String -> Decode.Decoder Bool
isOutsideDropdown dropdownId =
    Decode.oneOf
        [ Decode.field "id" Decode.string
            |> Decode.andThen
                (\id ->
                    if dropdownId == id then
                        -- found match by id
                        Decode.succeed False

                    else
                        -- try next decoder
                        Decode.fail "continue"
                )
        , Decode.lazy (\_ -> isOutsideDropdown dropdownId |> Decode.field "parentNode")

        -- fallback if all previous decoders failed
        , Decode.succeed True
        ]


outsideTarget : String -> Msg -> Decode.Decoder Msg
outsideTarget dropdownId msg =
    Decode.field "target" (isOutsideDropdown dropdownId)
        |> Decode.andThen
            (\isOutside ->
                if isOutside then
                    Decode.succeed msg

                else
                    Decode.fail "inside dropdown"
            )
