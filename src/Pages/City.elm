module Pages.City exposing (Model, Msg, init, subscriptions, update, view)

import Api.City
import Api.Itineraries exposing (putComment)
import Browser
import Browser.Events
import Common exposing (Request(..))
import Dict exposing (Dict)
import Html exposing (Html, a, button, div, form, h1, h2, h3, img, input, label, li, p, span, text, textarea, ul)
import Html.Attributes exposing (class, classList, disabled, for, href, id, name, placeholder, required, rows, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import HtmlComponents
import Http
import Json.Decode as Decode
import Session exposing (UserData)
import Svg.Attributes
import SvgIcons exposing (annotationSvg, chevronDownSvg, clockSvg, errorSvg, mapMarkerOutlineSvg, plusSvg, verticalDotsSvg, xSvg)
import TailwindHelpers as TW exposing (..)
import Tuple exposing (first)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map GotUser Session.localStorageUserSub
        , case model.commentMenuOpen of
            Just idx ->
                Browser.Events.onMouseDown (outsideTarget ("comment-menu-" ++ String.fromInt idx) (GotLoadedCityMsg CloseCommentMenu))

            Nothing ->
                Sub.none
        , case model.cityData of
            Loaded val ->
                case val.itineraryMenuOpen of
                    Just idx ->
                        Browser.Events.onMouseDown (outsideTarget ("itinerary-menu-" ++ String.fromInt idx) (GotLoadedCityMsg CloseItineraryMenu))

                    Nothing ->
                        Sub.none

            _ ->
                Sub.none
        ]


type alias Model =
    { cityId : Int
    , cityData :
        Request
            CityRequest
            Http.Error
    , userSession : Maybe UserData
    , commentMenuOpen : Maybe Int
    }


type alias CityRequest =
    { data : City
    , itineraries : List Itinerary
    , newItineraryModal :
        { isOpen : ModalState
        , isCreating : Creating

        -- If failed can retry with previous data
        , retryData : Maybe ItineraryFormData
        }
    , itineraryMenuOpen : Maybe Int

    -- New itinerary
    -- , isNewItineraryModalOpen : Bool
    -- , newItineraryName : String
    -- , newItineraryFirstActivity : String
    -- , newItineraryRestActivities : List ( Int, String )
    -- , newItineraryActivitiesIdx : Int
    -- , tag1 : String
    -- , tag2 : String
    -- , tag3 : String
    -- , newItineraryTime : Int
    -- , newItineraryPrice : Int
    -- , isCreatingNewItinerary : Bool
    -- , creatingNewItineraryError : String
    -- Edit Itinerary
    , isEditItineraryModalOpen : Bool
    , editItineraryId : Int
    , editItineraryName : String
    , editItineraryFirstActivity : String
    , editItineraryRestActivities : List ( Int, String )
    , editItineraryTime : Int
    , editItineraryPrice : Int
    , editItineraryTag1 : String
    , editItineraryTag2 : String
    , editItineraryTag3 : String
    , editItineraryActivitiesId : Int
    }


type ModalState
    = Closed
    | Open ItineraryFormData


type Creating
    = Idle
    | Creating
    | Succeeded
    | Failed String


type alias ItineraryFormData =
    { name : String
    , firstActivity : String
    , restActivities : List ( Int, String )
    , activitiesId : Int
    , tag1 : String
    , tag2 : String
    , tag3 : String
    , time : Int
    , price : Int
    }


emptyItineraryFormData : ItineraryFormData
emptyItineraryFormData =
    { name = ""
    , firstActivity = ""
    , restActivities = []
    , activitiesId = 0
    , tag1 = ""
    , tag2 = ""
    , tag3 = ""
    , time = 0
    , price = 0
    }


clearEditItineraryModalData : Model -> Model
clearEditItineraryModalData model =
    { model
        | cityData =
            case model.cityData of
                Loaded val ->
                    Loaded
                        { val
                            | editItineraryId = -1
                            , editItineraryName = ""
                            , editItineraryFirstActivity = ""
                            , editItineraryRestActivities = []
                            , editItineraryActivitiesId = -1
                            , editItineraryTime = 0
                            , editItineraryPrice = 0
                            , editItineraryTag1 = ""
                            , editItineraryTag2 = ""
                            , editItineraryTag3 = ""
                        }

                _ ->
                    model.cityData
    }


type alias City =
    { id : Int
    , name : String
    , country : String
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
    , showOnlyMyComments : Bool
    , editingComment : Maybe EditingComment
    }


type alias NewComment =
    { text : String
    , isCreating : Bool
    , error : Maybe String
    }


type alias EditingComment =
    { text : String
    , isEditing : Bool
    , error : Maybe String
    , commentId : Int
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
    | GotLoadedCityMsg LoadedCityMsg


type LoadedCityMsg {- The city data has been loaded so... -}
    = ----------- Comment -----------
      ToggleMyComments Int
    | GotDeleteCommentResp (Maybe Http.Error) Int
    | EditComment Int Int
    | DeleteComment Int
    | OpenCommentMenu Int
    | CloseCommentMenu
      -- New Comment
    | StartWritingComment Int
    | ChangeNewComment String Int
    | CancelComment Int
    | PostNewComment Int
    | GotNewCommentResp (Result Http.Error Api.City.Comment) Int
      -- Edit Comment
    | ChangeEditComment String Int
    | CancelEditComment Int
    | PostEditComment Int
    | GotPutCommentResp (Result Http.Error String) Int Int
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
    | RetryCreatingNewItinerary
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
    , showOnlyMyComments = False
    , editingComment = Nothing
    }


toCity : Api.City.City -> City
toCity data =
    { name = data.name
    , country = data.country
    , id = data.id
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotCity res ->
            case res of
                Ok cityData ->
                    ( { model
                        | cityData =
                            Loaded
                                { data = toCity cityData
                                , itineraries = List.map toItinerary cityData.itineraries
                                , newItineraryModal =
                                    { isCreating = Idle
                                    , retryData = Nothing
                                    , isOpen = Closed
                                    }
                                , itineraryMenuOpen = Nothing

                                -- Edit itinerary
                                , isEditItineraryModalOpen = False
                                , editItineraryId = -1
                                , editItineraryName = ""
                                , editItineraryFirstActivity = ""
                                , editItineraryRestActivities = []
                                , editItineraryTime = 0
                                , editItineraryPrice = 0
                                , editItineraryTag1 = ""
                                , editItineraryTag2 = ""
                                , editItineraryTag3 = ""
                                , editItineraryActivitiesId = 0
                                }
                      }
                    , Cmd.none
                    )

                Err err ->
                    ( { model | cityData = Error err }, Cmd.none )

        GotUser userSession ->
            let
                cityReq =
                    model.cityData
            in
            case userSession of
                Nothing ->
                    ( { model
                        | userSession = userSession
                        , cityData =
                            case cityReq of
                                Loaded val ->
                                    Loaded
                                        { val
                                            | newItineraryModal =
                                                { isOpen = Closed
                                                , isCreating = val.newItineraryModal.isCreating
                                                , retryData = Nothing
                                                }
                                            , itineraries =
                                                List.map
                                                    (\l ->
                                                        let
                                                            newComment =
                                                                l.newComment
                                                        in
                                                        { l | newComment = Nothing }
                                                    )
                                                    val.itineraries
                                        }

                                _ ->
                                    cityReq
                      }
                        |> clearEditItineraryModalData
                    , Cmd.none
                    )

                Just val ->
                    ( { model | userSession = Just val }, Cmd.none )

        GotLoadedCityMsg loadedCityMsg ->
            case model.cityData of
                Loaded val ->
                    let
                        cityData =
                            val.data

                        toLoaded : ( CityRequest, Cmd msg ) -> ( Model, Cmd msg )
                        toLoaded ( a, b ) =
                            ( { model | cityData = Loaded a }, b )
                    in
                    case loadedCityMsg of
                        OpenItineraryMenu id ->
                            ( { val | itineraryMenuOpen = Just id }
                            , Cmd.none
                            )
                                |> toLoaded

                        CloseItineraryMenu ->
                            ( { val | itineraryMenuOpen = Nothing }
                            , Cmd.none
                            )
                                |> toLoaded

                        DeleteItinerary id ->
                            ( { val
                                | itineraries =
                                    List.map
                                        (\({ data } as itineraryData) ->
                                            if data.id == id then
                                                { itineraryData | action = Just Deleting }

                                            else
                                                itineraryData
                                        )
                                        val.itineraries
                                , itineraryMenuOpen = Nothing
                              }
                            , Api.Itineraries.deleteItinerary id
                                (\l ->
                                    case l of
                                        Ok _ ->
                                            GotLoadedCityMsg (DeletedItinerary Nothing id)

                                        Err err ->
                                            GotLoadedCityMsg (DeletedItinerary (Just err) id)
                                )
                            )
                                |> toLoaded

                        DeletedItinerary err idx ->
                            (case err of
                                Nothing ->
                                    ( { val
                                        | itineraries =
                                            List.filter (\{ data } -> data.id /= idx)
                                                val.itineraries
                                      }
                                    , Cmd.none
                                    )

                                Just error ->
                                    let
                                        errorMessage : String
                                        errorMessage =
                                            case error of
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
                                    ( { val
                                        | itineraries =
                                            List.map
                                                (\({ data } as itineraryData) ->
                                                    if data.id == idx then
                                                        { itineraryData | action = Just (FailedToDelete errorMessage) }

                                                    else
                                                        itineraryData
                                                )
                                                val.itineraries
                                      }
                                    , Cmd.none
                                    )
                            )
                                |> toLoaded

                        ToggleItineraryComments idx ->
                            ( { val
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
                                        val.itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        DeleteComment id ->
                            case model.userSession of
                                Just _ ->
                                    let
                                        itineraries =
                                            val.itineraries
                                    in
                                    ( { model
                                        | commentMenuOpen = Nothing
                                        , cityData =
                                            Loaded
                                                { val
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
                                                                    , editingComment =
                                                                        case itineraryData.editingComment of
                                                                            Just commentVal ->
                                                                                if commentVal.commentId == id then
                                                                                    Nothing

                                                                                else
                                                                                    itineraryData.editingComment

                                                                            Nothing ->
                                                                                Nothing
                                                                }
                                                            )
                                                            itineraries
                                                }
                                      }
                                    , Api.Itineraries.deleteComment id
                                        (\l ->
                                            case l of
                                                Ok _ ->
                                                    GotLoadedCityMsg (GotDeleteCommentResp Nothing id)

                                                Err v ->
                                                    GotLoadedCityMsg (GotDeleteCommentResp (Just v) id)
                                        )
                                    )

                                Nothing ->
                                    ( model, Cmd.none )

                        GotDeleteCommentResp resp idx ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            case resp of
                                Just err ->
                                    ( { val
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
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Nothing ->
                                    ( { val
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
                                    , Cmd.none
                                    )
                                        |> toLoaded

                        ToggleMyComments id ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
                                | itineraries =
                                    List.map
                                        (\({ data } as itineraryData) ->
                                            if data.id == id then
                                                { itineraryData
                                                    | showOnlyMyComments =
                                                        if itineraryData.showOnlyMyComments then
                                                            False

                                                        else
                                                            True
                                                }

                                            else
                                                itineraryData
                                        )
                                        itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        -- New Itinerary
                        OpenModal ->
                            case model.userSession of
                                Just _ ->
                                    ( { val
                                        | newItineraryModal =
                                            { isOpen = Open emptyItineraryFormData
                                            , isCreating = Idle
                                            , retryData = Nothing
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Nothing ->
                                    ( model, Cmd.none )

                        CloseModal ->
                            ( { val
                                | newItineraryModal =
                                    { isOpen = Closed
                                    , isCreating = val.newItineraryModal.isCreating
                                    , retryData = val.newItineraryModal.retryData
                                    }
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        SubmitForm ->
                            case model.userSession of
                                Just _ ->
                                    case val.newItineraryModal.isOpen of
                                        Open formData ->
                                            ( { val
                                                | newItineraryModal =
                                                    { isOpen = Closed
                                                    , isCreating = Creating
                                                    , retryData = Just formData
                                                    }
                                              }
                                            , Api.Itineraries.postItinerary cityData.id
                                                { title = formData.name
                                                , activities =
                                                    formData.firstActivity
                                                        :: (formData.restActivities
                                                                |> List.filter (\( _, l ) -> l /= "")
                                                                |> List.map Tuple.second
                                                           )
                                                , price = formData.price
                                                , tags = [ formData.tag1, formData.tag2, formData.tag3 ]
                                                , duration = formData.time
                                                }
                                                GotNewItinerary
                                                |> Cmd.map GotLoadedCityMsg
                                            )
                                                |> toLoaded

                                        Closed ->
                                            ( model, Cmd.none )

                                Nothing ->
                                    ( model, Cmd.none )

                        RetryCreatingNewItinerary ->
                            case val.newItineraryModal.retryData of
                                Just retryData ->
                                    let
                                        newItineraryModalData =
                                            val.newItineraryModal
                                    in
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isCreating = Creating
                                            }
                                      }
                                    , Api.Itineraries.postItinerary cityData.id
                                        { title = retryData.name
                                        , activities =
                                            retryData.firstActivity
                                                :: (retryData.restActivities
                                                        |> List.filter (\( _, l ) -> l /= "")
                                                        |> List.map Tuple.second
                                                   )
                                        , price = retryData.price
                                        , tags = [ retryData.tag1, retryData.tag2, retryData.tag3 ]
                                        , duration = retryData.time
                                        }
                                        GotNewItinerary
                                        |> Cmd.map GotLoadedCityMsg
                                    )
                                        |> toLoaded

                                Nothing ->
                                    ( model, Cmd.none )

                        GotNewItinerary res ->
                            case model.userSession of
                                Just userData ->
                                    case res of
                                        Ok newItinerary ->
                                            let
                                                itineraries =
                                                    val.itineraries

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
                                            ( { val
                                                | itineraries = toItinerary newIt :: itineraries
                                                , newItineraryModal =
                                                    { isOpen = val.newItineraryModal.isOpen
                                                    , isCreating = Succeeded
                                                    , retryData = Nothing
                                                    }
                                              }
                                            , Cmd.none
                                            )
                                                |> toLoaded

                                        Err err ->
                                            let
                                                errorMessage : String
                                                errorMessage =
                                                    case err of
                                                        Http.BadStatus code ->
                                                            case code of
                                                                401 ->
                                                                    "Unauthorized"

                                                                400 ->
                                                                    "Bad request"

                                                                404 ->
                                                                    "Not found"

                                                                _ ->
                                                                    "An unknown error ocurred: code " ++ String.fromInt code

                                                        _ ->
                                                            "An unknown error ocurred"

                                                itineraryModalData =
                                                    val.newItineraryModal
                                            in
                                            ( { val
                                                | newItineraryModal =
                                                    { itineraryModalData
                                                        | isCreating = Failed errorMessage
                                                    }
                                              }
                                            , Cmd.none
                                            )
                                                |> toLoaded

                                Nothing ->
                                    ( model, Cmd.none )

                        GotPatchItineraryResp res idx ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            case res of
                                Ok patchedItinerary ->
                                    ( { val
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
                                                itineraries
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

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
                                    ( { val
                                        | itineraries =
                                            List.map
                                                (\({ data } as itineraryData) ->
                                                    if data.id == idx then
                                                        { itineraryData | action = Just (FailedToEdit errorMessage) }

                                                    else
                                                        itineraryData
                                                )
                                                itineraries
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                        ChangeNewItineraryName newName ->
                            let
                                newItineraryModalData =
                                    val.newItineraryModal
                            in
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData | isOpen = Open { formData | name = newName } }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        ChangeNewItineraryTime newTime ->
                            let
                                newItineraryModalData =
                                    val.newItineraryModal
                            in
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen =
                                                    Open
                                                        { formData
                                                            | time =
                                                                newTime
                                                                    |> String.toInt
                                                                    |> Maybe.withDefault 0
                                                        }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        ChangeNewItineraryPrice newPrice ->
                            let
                                newItineraryModalData =
                                    val.newItineraryModal
                            in
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen =
                                                    Open
                                                        { formData
                                                            | price =
                                                                newPrice
                                                                    |> String.toInt
                                                                    |> Maybe.withDefault 0
                                                        }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        ChangeTag1 newTag ->
                            let
                                newItineraryModalData =
                                    val.newItineraryModal
                            in
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen =
                                                    Open
                                                        { formData
                                                            | tag1 = newTag
                                                        }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        ChangeTag2 newTag ->
                            let
                                newItineraryModalData =
                                    val.newItineraryModal
                            in
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen = Open { formData | tag2 = newTag }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        ChangeTag3 newTag ->
                            let
                                newItineraryModalData =
                                    val.newItineraryModal
                            in
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen = Open { formData | tag3 = newTag }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        ChangeFirstActivity newFirstActivity ->
                            let
                                newItineraryModalData =
                                    val.newItineraryModal
                            in
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen = Open { formData | firstActivity = newFirstActivity }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        RemoveActivity activityId ->
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    let
                                        restActivities =
                                            List.filter (\( i, _ ) -> i /= activityId) formData.restActivities

                                        newItineraryModalData =
                                            val.newItineraryModal
                                    in
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen = Open { formData | restActivities = restActivities }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        AddActivity ->
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    let
                                        newId =
                                            formData.activitiesId + 1

                                        newItineraryModalData =
                                            val.newItineraryModal
                                    in
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen =
                                                    Open
                                                        { formData
                                                            | restActivities = formData.restActivities ++ [ ( newId, "" ) ]
                                                            , activitiesId = newId
                                                        }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        ChangeActivity idx newActivity ->
                            case val.newItineraryModal.isOpen of
                                Open formData ->
                                    let
                                        activities =
                                            formData.restActivities

                                        newItineraryModalData =
                                            val.newItineraryModal
                                    in
                                    ( { val
                                        | newItineraryModal =
                                            { newItineraryModalData
                                                | isOpen =
                                                    Open
                                                        { formData
                                                            | restActivities =
                                                                List.map
                                                                    (\( id, act ) ->
                                                                        if idx == id then
                                                                            ( id, newActivity )

                                                                        else
                                                                            ( id, act )
                                                                    )
                                                                    activities
                                                        }
                                            }
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Closed ->
                                    ( model, Cmd.none )

                        -- Edit Itinerary
                        OpenEditItineraryModal id ->
                            let
                                itineraryData =
                                    List.filter (\{ data } -> data.id == id) val.itineraries
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
                                    ( { val
                                        | isEditItineraryModalOpen = True
                                        , editItineraryId = id
                                        , editItineraryName = data.title
                                        , editItineraryTime = data.time
                                        , editItineraryPrice = data.price
                                        , editItineraryFirstActivity = firstActivity
                                        , editItineraryRestActivities = restActivities
                                        , editItineraryActivitiesId = List.length restActivities
                                        , editItineraryTag1 = tag1
                                        , editItineraryTag2 = tag2
                                        , editItineraryTag3 = tag3
                                      }
                                    , Cmd.none
                                    )
                                        |> toLoaded

                                Nothing ->
                                    ( model, Cmd.none )

                        CloseEditItineraryModal ->
                            ( { val | isEditItineraryModalOpen = False }, Cmd.none )
                                |> toLoaded

                        ChangeEditItineraryName newEditItineraryName ->
                            ( { val | editItineraryName = newEditItineraryName }, Cmd.none )
                                |> toLoaded

                        ChangeEditItineraryTime newEditItineraryTime ->
                            ( { val | editItineraryTime = Maybe.withDefault 0 (String.toInt newEditItineraryTime) }, Cmd.none )
                                |> toLoaded

                        ChangeEditItineraryPrice newEditItineraryPrice ->
                            ( { val | editItineraryPrice = Maybe.withDefault 0 (String.toInt newEditItineraryPrice) }, Cmd.none )
                                |> toLoaded

                        ChangeEditTag1 newEditTag ->
                            ( { val | editItineraryTag1 = newEditTag }, Cmd.none )
                                |> toLoaded

                        ChangeEditTag2 newEditTag ->
                            ( { val | editItineraryTag2 = newEditTag }, Cmd.none )
                                |> toLoaded

                        ChangeEditTag3 newEditTag ->
                            ( { val | editItineraryTag3 = newEditTag }, Cmd.none )
                                |> toLoaded

                        ChangeEditItineraryFirstActivity newEditFirstActivity ->
                            ( { val | editItineraryFirstActivity = newEditFirstActivity }, Cmd.none )
                                |> toLoaded

                        RemoveEditItineraryActivity idx ->
                            let
                                restActivities =
                                    List.filter (\( i, _ ) -> i /= idx) val.editItineraryRestActivities
                            in
                            ( { val | editItineraryRestActivities = restActivities }, Cmd.none )
                                |> toLoaded

                        AddEditItineraryActivity ->
                            let
                                newId =
                                    val.editItineraryActivitiesId + 1
                            in
                            ( { val
                                | editItineraryRestActivities = val.editItineraryRestActivities ++ [ ( newId, "" ) ]
                                , editItineraryActivitiesId = newId
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        ChangeEditItineraryActivity idx newActivity ->
                            let
                                activities =
                                    val.editItineraryRestActivities
                            in
                            ( { val
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
                                |> toLoaded

                        SubmitEditItineraryForm ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            case model.userSession of
                                Just _ ->
                                    let
                                        itineraryBeingEditedId =
                                            val.editItineraryId
                                    in
                                    ( { val
                                        | itineraries =
                                            List.map
                                                (\({ data } as itineraryData) ->
                                                    if data.id == itineraryBeingEditedId then
                                                        { itineraryData | action = Just Editing }

                                                    else
                                                        itineraryData
                                                )
                                                itineraries
                                        , isEditItineraryModalOpen = False
                                      }
                                    , Api.Itineraries.patchItinerary val.editItineraryId
                                        { title = val.editItineraryName
                                        , activities =
                                            val.editItineraryFirstActivity
                                                :: (val.editItineraryRestActivities
                                                        |> List.filter (\( _, l ) -> l /= "")
                                                        |> List.map Tuple.second
                                                   )
                                        , price = val.editItineraryPrice
                                        , hashtags = [ val.editItineraryTag1, val.editItineraryTag2, val.editItineraryTag3 ]
                                        , time = val.editItineraryTime
                                        }
                                        (\l -> GotPatchItineraryResp l val.editItineraryId)
                                        |> Cmd.map GotLoadedCityMsg
                                    )
                                        |> toLoaded

                                Nothing ->
                                    ( model, Cmd.none )

                        -- New Itinerary Comment
                        StartWritingComment itineraryId ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
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
                                                    , editingComment = Nothing
                                                }

                                            else
                                                i
                                        )
                                        itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        ChangeNewComment newComment id ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
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
                                        itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        CancelComment id ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
                                | itineraries =
                                    List.map
                                        (\i ->
                                            if i.data.id == id then
                                                { i
                                                    | newComment =
                                                        Nothing
                                                }

                                            else
                                                i
                                        )
                                        itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        PostNewComment id ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
                                | itineraries =
                                    List.map
                                        (\i ->
                                            if i.data.id == id then
                                                { i
                                                    | newComment =
                                                        case i.newComment of
                                                            Just commentData ->
                                                                Just
                                                                    { text = commentData.text
                                                                    , isCreating = True
                                                                    , error = Nothing
                                                                    }

                                                            Nothing ->
                                                                i.newComment
                                                }

                                            else
                                                i
                                        )
                                        itineraries
                              }
                            , case
                                itineraries
                                    |> List.filter (\l -> l.data.id == id)
                                    |> List.head
                              of
                                Just i ->
                                    case i.newComment of
                                        Just newComment ->
                                            Api.Itineraries.postComment id
                                                newComment.text
                                                (\l -> GotNewCommentResp l id)
                                                |> Cmd.map GotLoadedCityMsg

                                        Nothing ->
                                            Cmd.none

                                Nothing ->
                                    Cmd.none
                            )
                                |> toLoaded

                        GotNewCommentResp resp itineraryId ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            case model.userSession of
                                Just userData ->
                                    case resp of
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
                                            ( { val
                                                | itineraries =
                                                    List.map
                                                        (\l ->
                                                            if l.data.id == itineraryId then
                                                                { l
                                                                    | newComment =
                                                                        case l.newComment of
                                                                            Just v ->
                                                                                Just
                                                                                    { text = v.text
                                                                                    , error = Just errorMessage
                                                                                    , isCreating = False
                                                                                    }

                                                                            Nothing ->
                                                                                l.newComment
                                                                }

                                                            else
                                                                l
                                                        )
                                                        itineraries
                                              }
                                            , Cmd.none
                                            )
                                                |> toLoaded

                                        Ok comment ->
                                            let
                                                newComment =
                                                    toComment comment
                                            in
                                            ( { val
                                                | itineraries =
                                                    List.map
                                                        (\l ->
                                                            let
                                                                data =
                                                                    l.data
                                                            in
                                                            if l.data.id == itineraryId then
                                                                { l
                                                                    | newComment =
                                                                        Nothing
                                                                    , data =
                                                                        { data
                                                                            | comments =
                                                                                newComment
                                                                                    :: data.comments
                                                                        }
                                                                }

                                                            else
                                                                l
                                                        )
                                                        itineraries
                                              }
                                            , Cmd.none
                                            )
                                                |> toLoaded

                                Nothing ->
                                    ( model, Cmd.none )

                        EditComment itineraryId commentId ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { model
                                | cityData =
                                    Loaded
                                        { val
                                            | itineraries =
                                                List.map
                                                    (\i ->
                                                        if i.data.id == itineraryId then
                                                            { i
                                                                | editingComment =
                                                                    Just
                                                                        { text =
                                                                            i.data.comments
                                                                                |> List.filter (\o -> o.id == commentId)
                                                                                |> List.head
                                                                                |> (\o ->
                                                                                        case o of
                                                                                            Just value ->
                                                                                                value.comment

                                                                                            Nothing ->
                                                                                                ""
                                                                                   )
                                                                        , error = Nothing
                                                                        , isEditing = False
                                                                        , commentId = commentId
                                                                        }
                                                                , newComment = Nothing
                                                            }

                                                        else
                                                            i
                                                    )
                                                    itineraries
                                        }
                                , commentMenuOpen = Nothing
                              }
                            , Cmd.none
                            )

                        ChangeEditComment newComment itineraryId ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
                                | itineraries =
                                    List.map
                                        (\i ->
                                            if i.data.id == itineraryId then
                                                { i
                                                    | editingComment =
                                                        case i.editingComment of
                                                            Just commentData ->
                                                                Just
                                                                    { commentData
                                                                        | text = newComment
                                                                    }

                                                            Nothing ->
                                                                i.editingComment
                                                }

                                            else
                                                i
                                        )
                                        itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        CancelEditComment itineraryId ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
                                | itineraries =
                                    List.map
                                        (\i ->
                                            if i.data.id == itineraryId then
                                                { i
                                                    | editingComment =
                                                        Nothing
                                                }

                                            else
                                                i
                                        )
                                        itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        PostEditComment itineraryId ->
                            let
                                itineraries =
                                    val.itineraries

                                ( newComment, commentId ) =
                                    itineraries
                                        |> List.filter (\o -> o.data.id == itineraryId)
                                        |> List.head
                                        |> (\l ->
                                                case l of
                                                    Just v ->
                                                        case v.editingComment of
                                                            Just commentData ->
                                                                ( commentData.text, commentData.commentId )

                                                            Nothing ->
                                                                ( "", -1 )

                                                    Nothing ->
                                                        ( "", -1 )
                                           )
                            in
                            ( { val
                                | itineraries =
                                    List.map
                                        (\i ->
                                            if i.data.id == itineraryId then
                                                { i
                                                    | editingComment =
                                                        case i.editingComment of
                                                            Just eComment ->
                                                                Just
                                                                    { eComment
                                                                        | isEditing = True
                                                                        , error = Nothing
                                                                    }

                                                            Nothing ->
                                                                i.editingComment
                                                }

                                            else
                                                i
                                        )
                                        itineraries
                              }
                            , putComment newComment
                                commentId
                                (\l ->
                                    case l of
                                        Ok _ ->
                                            GotLoadedCityMsg (GotPutCommentResp (Ok newComment) itineraryId commentId)

                                        Err err ->
                                            GotLoadedCityMsg (GotPutCommentResp (Err err) itineraryId commentId)
                                )
                            )
                                |> toLoaded

                        GotPutCommentResp resp itineraryId commentId ->
                            let
                                itineraries =
                                    val.itineraries
                            in
                            ( { val
                                | itineraries =
                                    List.map
                                        (\i ->
                                            if i.data.id == itineraryId then
                                                let
                                                    data =
                                                        i.data

                                                    comments =
                                                        i.data.comments
                                                in
                                                case resp of
                                                    Ok newComment ->
                                                        { i
                                                            | editingComment = Nothing
                                                            , data =
                                                                { data
                                                                    | comments =
                                                                        comments
                                                                            |> List.map
                                                                                (\o ->
                                                                                    if o.id == commentId then
                                                                                        { o | comment = newComment }

                                                                                    else
                                                                                        o
                                                                                )
                                                                }
                                                        }

                                                    Err err ->
                                                        { i
                                                            | editingComment =
                                                                case i.editingComment of
                                                                    Just eComment ->
                                                                        Just
                                                                            { eComment
                                                                                | error =
                                                                                    case err of
                                                                                        Http.BadStatus code ->
                                                                                            case code of
                                                                                                400 ->
                                                                                                    Just "Bad request"

                                                                                                401 ->
                                                                                                    Just "Unauthorized"

                                                                                                404 ->
                                                                                                    Just "Not found"

                                                                                                _ ->
                                                                                                    Just ("An unknown error ocurred: code " ++ String.fromInt code)

                                                                                        _ ->
                                                                                            Just "An unknown error ocurred"
                                                                                , isEditing = False
                                                                            }

                                                                    Nothing ->
                                                                        i.editingComment
                                                        }

                                            else
                                                i
                                        )
                                        itineraries
                              }
                            , Cmd.none
                            )
                                |> toLoaded

                        OpenCommentMenu idx ->
                            ( { model | commentMenuOpen = Just idx }
                            , Cmd.none
                            )

                        CloseCommentMenu ->
                            ( { model | commentMenuOpen = Nothing }, Cmd.none )

                _ ->
                    ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view ({ cityData } as model) =
    let
        cityName =
            case cityData of
                Loading ->
                    "Loading city..."

                Loaded { data } ->
                    data.name

                Error _ ->
                    "Failed to load city"

        isCreatingNewItinerary =
            case cityData of
                Loaded data ->
                    case data.newItineraryModal.isCreating of
                        Creating ->
                            True

                        _ ->
                            False

                _ ->
                    False
    in
    { title = cityName
    , body =
        [ case cityData of
            Loading ->
                div [ class "w-full h-full flex justify-center items-center" ] [ p [ class "text-4xl block md:text-6xl" ] [ text "Loading..." ] ]

            Loaded { data, newItineraryModal, itineraries } ->
                let
                    { country, name } =
                        data

                    creatingNewItineraryError =
                        case newItineraryModal.isCreating of
                            Failed err ->
                                err

                            _ ->
                                ""
                in
                div [ class "h-full flex flex-col" ]
                    [ div
                        [ class "block relative py-8 text-white text-center"
                        ]
                        [ img [ class "city-bgr bg-black", src ("https://source.unsplash.com/featured/?" ++ name) ] []
                        , h1 [ class "text-3xl font-semibold mb-2" ] [ text name ]
                        , p [ class "text-2xl" ] [ text country ]
                        ]
                    , div [ TW.apply [ bg_gray_200, flex, flex_grow, flex_col ] ]
                        (if List.length itineraries == 0 then
                            let
                                isLoggedIn =
                                    case model.userSession of
                                        Just _ ->
                                            True

                                        Nothing ->
                                            False
                            in
                            [ div [ TW.apply [ w_full, flex, flex_grow ] ]
                                [ div
                                    [ TW.apply
                                        [ m_auto
                                        , text_center
                                        , flex
                                        , flex_col
                                        , gap_y_3
                                        ]
                                    ]
                                    [ mapMarkerOutlineSvg
                                        [ [ w_12, h_12, opacity_40, mx_auto ]
                                            |> String.join " "
                                            |> Svg.Attributes.class
                                        ]
                                    , div []
                                        [ p
                                            [ TW.apply
                                                [ text_black
                                                , font_semibold
                                                ]
                                            ]
                                            [ text "No itineraries" ]
                                        , p
                                            [ TW.apply
                                                [ text_black
                                                , font_semibold
                                                , opacity_50
                                                ]
                                            ]
                                            [ text "Be the first to add an itinerary!" ]
                                        ]
                                    , if isLoggedIn then
                                        button
                                            [ onClick OpenModal
                                            , TW.apply
                                                [ flex
                                                , p_3
                                                , gap_x_2
                                                , font_semibold
                                                , block
                                                , rounded
                                                , mx_auto
                                                ]
                                            , classList
                                                [ ( "bg-blue-700 hover:bg-blue-700 text-white", not isCreatingNewItinerary )
                                                , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", isCreatingNewItinerary )
                                                ]
                                            ]
                                            [ plusSvg
                                                [ [ w_6, h_6 ]
                                                    |> String.join " "
                                                    |> Svg.Attributes.class
                                                ]
                                            , if isCreatingNewItinerary then
                                                text "Creating itinerary..."

                                              else
                                                text "Create Itinerary"
                                            ]

                                      else
                                        a
                                            [ href "/login"
                                            , TW.apply
                                                [ flex
                                                , p_3
                                                , gap_x_2
                                                , font_semibold
                                                , block
                                                , rounded
                                                , mx_auto
                                                ]
                                            , classList
                                                [ ( "bg-blue-700 hover:bg-blue-700 text-white", not isCreatingNewItinerary )
                                                , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", isCreatingNewItinerary )
                                                ]
                                            ]
                                            [ text "Log in to create an itinerary" ]
                                    ]
                                ]
                            ]

                         else
                            [ h2
                                [ class "pt-2 text-center text-2xl" ]
                                [ text "Itineraries" ]
                            , div [ class "px-4 my-2 flex flex-col gap-y-4" ]
                                [ if creatingNewItineraryError /= "" then
                                    div [ class "mx-auto w-full md:w-72 block rounded" ]
                                        [ div
                                            [ TW.apply
                                                [ bg_red_100
                                                , p_3
                                                , flex
                                                , gap_x_2
                                                ]
                                            ]
                                            [ errorSvg
                                            , p [ TW.apply [ text_red_700 ] ]
                                                [ div [ TW.apply [ flex, flex_col ] ]
                                                    [ p [ TW.apply [ font_bold ] ] [ text "Error" ]
                                                    , text creatingNewItineraryError
                                                    , button
                                                        [ TW.apply
                                                            [ bg_red_300
                                                            , py_2
                                                            , px_4
                                                            , font_bold
                                                            , flex_grow
                                                            , rounded
                                                            , hover [ bg_red_500, text_red_200 ]
                                                            ]
                                                        , onClick RetryCreatingNewItinerary
                                                        ]
                                                        [ text "Retry?" ]
                                                    ]
                                                ]
                                            ]
                                        ]

                                  else
                                    text ""
                                , case model.userSession of
                                    Just _ ->
                                        button
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

                                    Nothing ->
                                        text ""
                                ]
                            , -- TODO add a max height
                              ul [ class "container mx-auto px-4 pb-4 flex flex-col md:flex-row md:flex-wrap items-baseline" ]
                                (List.map (\l -> li [ class "md:w-1/2 xl:w-1/3 w-full p-2" ] [ itinerary l model ]) itineraries)
                            ]
                        )
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
        , case cityData of
            Loaded loadedCityData ->
                case loadedCityData.newItineraryModal.isOpen of
                    Open formData ->
                        modal
                            formData
                            isCreatingNewItinerary

                    Closed ->
                        text ""

            _ ->
                text ""
        , case cityData of
            Loaded ({ isEditItineraryModalOpen, editItineraryId, editItineraryName, editItineraryTime, editItineraryPrice, editItineraryTag1, editItineraryTag2, editItineraryTag3, editItineraryFirstActivity, editItineraryRestActivities } as val) ->
                let
                    itineraries =
                        val.itineraries
                in
                if isEditItineraryModalOpen then
                    editItineraryModal
                        { name = editItineraryName
                        , time = editItineraryTime
                        , price = editItineraryPrice
                        , tag1 = editItineraryTag1
                        , tag2 = editItineraryTag2
                        , tag3 = editItineraryTag3
                        , firstActivity = editItineraryFirstActivity
                        , restActivities = editItineraryRestActivities
                        , activitiesId = -1
                        }
                        (itineraries
                            |> List.any
                                (\{ data, action } ->
                                    if data.id == editItineraryId then
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
            |> List.map (Html.map GotLoadedCityMsg)
    }


itinerary : Itinerary -> Model -> Html LoadedCityMsg
itinerary { data, action, areCommentsExpanded, newComment, showOnlyMyComments, editingComment } model =
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

        newCommentHtml : Html LoadedCityMsg
        newCommentHtml =
            case newComment of
                Just newCommentData ->
                    let
                        tooManyChars =
                            String.length newCommentData.text > 300
                    in
                    div [ class "p-4 pb-0" ]
                        [ div [ class "mb-2" ]
                            [ if newCommentData.isCreating then
                                infoHtml "Posting comment..."

                              else
                                text ""
                            , case newCommentData.error of
                                Just err ->
                                    errorHtml err

                                Nothing ->
                                    text ""
                            ]
                        , div []
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
                        , div [ class "flex justify-between" ]
                            [ p
                                [ class "mt-2 text-sm text-gray-500"
                                , classList [ ( "text-red-500", String.length newCommentData.text > 300 ) ]
                                ]
                                [ text
                                    ((newCommentData.text
                                        |> String.length
                                        |> String.fromInt
                                     )
                                        ++ "/300"
                                    )
                                ]
                            , div [ class "flex mt-2" ]
                                [ button
                                    [ onClick (CancelComment data.id)
                                    , class "font-bold py-2 px-4"
                                    , classList
                                        [ ( "text-black", not newCommentData.isCreating )
                                        , ( "text-gray-800", newCommentData.isCreating )
                                        ]
                                    ]
                                    [ text "Cancel" ]
                                , button
                                    [ onClick (PostNewComment data.id)
                                    , class "font-bold py-2 px-4 rounded"
                                    , disabled (newCommentData.isCreating || tooManyChars)
                                    , classList
                                        [ ( "bg-blue-700 hover:bg-blue-700 text-white", not newCommentData.isCreating && not tooManyChars )
                                        , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", newCommentData.isCreating || tooManyChars )
                                        ]
                                    ]
                                    [ text "Create" ]
                                ]
                            ]
                        ]

                Nothing ->
                    text ""

        editCommentHtml : Html LoadedCityMsg
        editCommentHtml =
            case editingComment of
                Just editingCommentData ->
                    let
                        tooManyChars =
                            String.length editingCommentData.text > 300
                    in
                    div [ class "p-4 pb-0" ]
                        [ div [ class "mb-2" ]
                            [ if editingCommentData.isEditing then
                                infoHtml "Editing comment..."

                              else
                                text ""
                            , case editingCommentData.error of
                                Just err ->
                                    errorHtml err

                                Nothing ->
                                    text ""
                            ]
                        , div []
                            [ label
                                [ class "block text-sm font-medium text-gray-700"
                                , for "edit-comment"
                                ]
                                [ text "Edit Comment" ]
                            ]
                        , div [ class "mt-1" ]
                            [ textarea
                                [ class "shadow-sm mt-1 block w-full sm:text-sm border border-gray-300 rounded-md p-1"
                                , id "edit-comment"
                                , placeholder "Leave a comment..."
                                , rows 3
                                , value editingCommentData.text
                                , onInput (\l -> ChangeEditComment l data.id)
                                ]
                                []
                            ]
                        , div [ class "flex justify-between" ]
                            [ p
                                [ class "mt-2 text-sm text-gray-500"
                                , classList [ ( "text-red-500", String.length editingCommentData.text > 300 ) ]
                                ]
                                [ text
                                    ((editingCommentData.text
                                        |> String.length
                                        |> String.fromInt
                                     )
                                        ++ "/300"
                                    )
                                ]
                            , div [ class "flex mt-2" ]
                                [ button
                                    [ onClick (CancelEditComment data.id)
                                    , class "font-bold py-2 px-4"
                                    , classList
                                        [ ( "text-black", not editingCommentData.isEditing )
                                        , ( "text-gray-800", editingCommentData.isEditing )
                                        ]
                                    ]
                                    [ text "Cancel" ]
                                , button
                                    [ onClick (PostEditComment data.id)
                                    , class "font-bold py-2 px-4 rounded"
                                    , disabled (editingCommentData.isEditing || tooManyChars)
                                    , classList
                                        [ ( "bg-blue-700 hover:bg-blue-700 text-white", not editingCommentData.isEditing && not tooManyChars )
                                        , ( "bg-gray-300 hover:bg-gray-400 text-gray-800", editingCommentData.isEditing || tooManyChars )
                                        ]
                                    ]
                                    [ text "Edit" ]
                                ]
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
                        infoHtml "Deleting itinerary..."

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
                                case model.cityData of
                                    Loaded val ->
                                        if userData.id == data.creator.id then
                                            [ div [ class "ml-auto relative" ]
                                                [ button [ onClick (OpenItineraryMenu data.id), class "w-12 h-12", disabled thisItineraryIsBeingDeleted ]
                                                    [ div [ class "flex w-12 h-12", classList [ ( "text-gray-400", thisItineraryIsBeingDeleted ) ] ] [ verticalDotsSvg ]
                                                    ]
                                                , div
                                                    [ classList
                                                        [ ( "hidden"
                                                          , not (Maybe.withDefault -1 val.itineraryMenuOpen == data.id)
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

                                    _ ->
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
                    [ div [ class "w-full h-px bg-gray-200" ]
                        [ newCommentHtml
                        , editCommentHtml
                        , case model.userSession of
                            Just userData ->
                                let
                                    myCommentsAmount =
                                        data.comments
                                            |> List.filter (\c -> c.author.id == userData.id)
                                            |> List.length
                                in
                                case newComment of
                                    Just _ ->
                                        if myCommentsAmount > 0 then
                                            div [ class "p-4" ]
                                                [ if showOnlyMyComments then
                                                    button
                                                        [ class "font-bold py-2 px-4 rounded w-full bg-blue-700 hover:bg-blue-700 text-white"
                                                        , onClick (ToggleMyComments data.id)
                                                        ]
                                                        [ text
                                                            "Show all comments"
                                                        ]

                                                  else
                                                    HtmlComponents.button
                                                        [ onClick (ToggleMyComments data.id)
                                                        , TW.apply [ w_full ]
                                                        ]
                                                        [ text
                                                            ("My comments ("
                                                                ++ (myCommentsAmount |> String.fromInt)
                                                                ++ ")"
                                                            )
                                                        ]
                                                ]

                                        else
                                            div [ class "pt-2" ] []

                                    Nothing ->
                                        if List.length data.comments /= 0 then
                                            div [ class "p-4 flex gap-x-4 justify-between" ]
                                                [ if myCommentsAmount > 0 then
                                                    if showOnlyMyComments then
                                                        HtmlComponents.button
                                                            [ onClick (ToggleMyComments data.id)
                                                            ]
                                                            [ text
                                                                "Show all comments"
                                                            ]

                                                    else
                                                        HtmlComponents.button [ onClick (ToggleMyComments data.id) ]
                                                            [ text
                                                                ("My comments ("
                                                                    ++ (myCommentsAmount |> String.fromInt)
                                                                    ++ ")"
                                                                )
                                                            ]

                                                  else
                                                    text ""
                                                , HtmlComponents.button
                                                    [ type_ "submit"
                                                    , onClick (StartWritingComment data.id)
                                                    , classList [ ( w_full, myCommentsAmount < 1 ) ]
                                                    ]
                                                    [ text "Post comment" ]
                                                ]

                                        else
                                            text ""

                            Nothing ->
                                text ""
                        , if List.length data.comments == 0 then
                            case newComment of
                                Just _ ->
                                    text ""

                                Nothing ->
                                    div
                                        [ TW.apply
                                            [ m_auto
                                            , text_center
                                            , flex
                                            , flex_col
                                            , gap_y_3
                                            , py_4
                                            ]
                                        ]
                                        [ annotationSvg
                                            [ [ w_12, h_12, opacity_40, mx_auto ]
                                                |> String.join " "
                                                |> Svg.Attributes.class
                                            ]
                                        , div []
                                            [ p
                                                [ TW.apply
                                                    [ text_black
                                                    , font_semibold
                                                    ]
                                                ]
                                                [ text "No comments" ]
                                            , p
                                                [ TW.apply
                                                    [ text_black
                                                    , font_semibold
                                                    , opacity_50
                                                    ]
                                                ]
                                                [ text "Be the first to add a comment!" ]
                                            ]
                                        , case model.userSession of
                                            Just val ->
                                                button
                                                    [ onClick (StartWritingComment data.id)
                                                    , TW.apply
                                                        [ flex
                                                        , p_3
                                                        , gap_x_2
                                                        , font_semibold
                                                        , block
                                                        , rounded
                                                        , mx_auto
                                                        , text_white
                                                        , bg_blue_500
                                                        , hover [ bg_blue_700 ]
                                                        ]
                                                    ]
                                                    [ plusSvg
                                                        [ [ w_6, h_6 ]
                                                            |> String.join " "
                                                            |> Svg.Attributes.class
                                                        ]
                                                    , text "Post a comment"
                                                    ]

                                            Nothing ->
                                                a
                                                    [ href "/login"
                                                    , TW.apply
                                                        [ flex
                                                        , p_3
                                                        , gap_x_2
                                                        , font_semibold
                                                        , block
                                                        , rounded
                                                        , mx_auto
                                                        , text_white
                                                        , bg_blue_500
                                                        , hover [ bg_blue_700 ]
                                                        ]
                                                    ]
                                                    [ text "Log in to post a comment" ]
                                        ]

                          else
                            text ""
                        , ul [ class "flex flex-col" ]
                            (data.comments
                                |> (\l ->
                                        case model.userSession of
                                            Just userData ->
                                                if showOnlyMyComments then
                                                    List.filter (\el -> el.author.id == userData.id) l

                                                else
                                                    l

                                            Nothing ->
                                                l
                                   )
                                |> List.map
                                    (\comment ->
                                        itineraryComment data.id
                                            comment
                                            (case model.commentMenuOpen of
                                                Just commentId ->
                                                    commentId == comment.id

                                                Nothing ->
                                                    False
                                            )
                                            (case model.userSession of
                                                Just _ ->
                                                    True

                                                Nothing ->
                                                    False
                                            )
                                    )
                            )
                        ]
                    ]

                else
                    [ text "" ]
               )
        )


itineraryComment : Int -> Comment -> Bool -> Bool -> Html LoadedCityMsg
itineraryComment itineraryId ({ author, comment, action } as commentData) isMenuOpen showMenu =
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
                , if showMenu then
                    div
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
                                , li []
                                    [ button [ class "w-full px-2 py-1", onClick (EditComment itineraryId commentData.id) ] [ text "Edit" ]
                                    ]
                                ]
                            ]
                        ]

                  else
                    text ""
                ]
            , text comment
            ]
        ]


modal : ItineraryFormData -> Bool -> Html LoadedCityMsg
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


formActivities : ItineraryFormData -> Bool -> Html LoadedCityMsg
formActivities { firstActivity, restActivities } isCreatingNewItinerary =
    let
        otherActivities =
            List.indexedMap
                (\i ( idNumber, content ) ->
                    let
                        idN =
                            String.fromInt idNumber
                    in
                    div
                        [ class "flex flex-col" ]
                        [ label
                            [ class "block text-gray-700 text-sm font-bold mb-2"
                            , for ("activity-" ++ idN)
                            ]
                            [ text ("Activity #" ++ String.fromInt (i + 2))
                            ]
                        , div [ class "flex rounded w-full shadow border" ]
                            [ input
                                [ value content
                                , onInput (ChangeActivity idNumber)
                                , class "appearance-none w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                , id ("activity-" ++ idN)
                                , type_ "text"
                                ]
                                []
                            , button
                                [ type_ "button"
                                , onClick (RemoveActivity idNumber)
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


editItineraryModal : ItineraryFormData -> Bool -> Html LoadedCityMsg
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


editFormActivities : ItineraryFormData -> Bool -> Html LoadedCityMsg
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
