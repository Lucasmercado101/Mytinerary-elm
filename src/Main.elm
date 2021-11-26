module Main exposing (main)

import Api.Auth
import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, img, li, p, text, ul)
import Html.Attributes exposing (class, classList, href, src)
import Html.Events exposing (onClick)
import Pages.Cities as Cities exposing (Model, Msg, init, view)
import Pages.City as City exposing (Model, Msg, init, update, view)
import Pages.Landing as Landing exposing (view)
import Pages.Login as Login exposing (Model, Msg, init, update, view)
import Pages.Register as Register exposing (Model, Msg, init, update, view)
import Session
import Svg exposing (svg)
import Svg.Attributes
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, s)


subscriptions : Model -> Sub Msg
subscriptions { page } =
    case page of
        CitiesPage citiesModel ->
            Sub.map GotCitiesMsg (Cities.subscriptions citiesModel)

        _ ->
            Sub.map ReceivedUser Session.localStorageUserSub


type Route
    = Landing
    | Cities
    | City Int
    | Register
    | Login


type Page
    = LandingPage
    | RegisterPage Register.Model
    | CitiesPage Cities.Model
    | CityPage City.Model
    | LoginPage Login.Model
    | PageNotFound


urlParser : Parser (Route -> a) a
urlParser =
    Parser.oneOf
        [ Parser.map Landing Parser.top
        , Parser.map Cities (s "cities")
        , Parser.map Register (s "register")
        , Parser.map City (s "cities" </> Parser.int)
        , Parser.map Login (s "login")
        ]


toCities : Model -> ( Cities.Model, Cmd Cities.Msg ) -> ( Model, Cmd Msg )
toCities model ( cities, cmd ) =
    ( { model | page = CitiesPage cities }
    , Cmd.map GotCitiesMsg cmd
    )


toCity : Model -> ( City.Model, Cmd City.Msg ) -> ( Model, Cmd Msg )
toCity model ( cities, cmd ) =
    ( { model | page = CityPage cities }
    , Cmd.map GotCityMsg cmd
    )


toRegister : Model -> ( Register.Model, Cmd Register.Msg ) -> ( Model, Cmd Msg )
toRegister model ( register, cmd ) =
    ( { model | page = RegisterPage register }
    , Cmd.map GotRegisterMsg cmd
    )


toLogin : Model -> ( Login.Model, Cmd Login.Msg ) -> ( Model, Cmd Msg )
toLogin model ( login, cmd ) =
    ( { model | page = LoginPage login }
    , Cmd.map GotLoginMsg cmd
    )


updateUrl : Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse urlParser url of
        Just Landing ->
            ( { model | page = LandingPage }, Cmd.none )

        Just Cities ->
            toCities model Cities.init

        Just (City cityId) ->
            toCity model (City.init cityId)

        Just Register ->
            toRegister model (Register.init model.key)

        Just Login ->
            toLogin model (Login.init model.key)

        Nothing ->
            ( { model | page = PageNotFound }, Cmd.none )


main : Program (Maybe Session.UserData) Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChanged
        }


type User
    = LoggedOut
    | LoggedIn Session.UserData


type alias Model =
    { key : Nav.Key
    , page : Page
    , isMenuExpanded : Bool
    , isUserMenuExpanded : Bool
    , user : User
    }


init : Maybe Session.UserData -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init userData url key =
    updateUrl url
        { page = PageNotFound
        , key = key
        , isMenuExpanded = False
        , isUserMenuExpanded = False
        , user =
            case userData of
                Just data ->
                    LoggedIn data

                Nothing ->
                    LoggedOut
        }


type Msg
    = ClickedLink Browser.UrlRequest
    | UrlChanged Url.Url
    | ReceivedUser (Maybe Session.UserData)
    | GotCitiesMsg Cities.Msg
    | GotCityMsg City.Msg
    | GotRegisterMsg Register.Msg
    | GotLoginMsg Login.Msg
    | LogOut
    | NoOp
      -- Navbar
    | ToggleMenu
    | ToggleUserMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ page } as model) =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            updateUrl url model
                |> (\( newModel, cmd ) ->
                        ( { newModel
                            | isMenuExpanded = False
                            , isUserMenuExpanded = False
                          }
                        , cmd
                        )
                   )

        ToggleMenu ->
            ( { model
                | isMenuExpanded = not model.isMenuExpanded
                , isUserMenuExpanded = False
              }
            , Cmd.none
            )

        ToggleUserMenu ->
            ( { model
                | isUserMenuExpanded = not model.isUserMenuExpanded
                , isMenuExpanded = False
              }
            , Cmd.none
            )

        ReceivedUser userData ->
            ( { model
                | user =
                    case userData of
                        Nothing ->
                            LoggedOut

                        Just data ->
                            LoggedIn data
              }
            , Cmd.none
            )

        LogOut ->
            ( { model
                | user = LoggedOut
              }
            , Cmd.batch [ Api.Auth.logOut NoOp, Session.clearUserFromLocalStorageMsg ]
            )

        -- PAGES
        GotCitiesMsg citiesMsg ->
            case page of
                CitiesPage citiesModel ->
                    toCities model (Cities.update citiesMsg citiesModel)

                _ ->
                    ( model, Cmd.none )

        GotCityMsg cityMsg ->
            case page of
                CityPage cityModel ->
                    toCity model (City.update cityMsg cityModel)

                _ ->
                    ( model, Cmd.none )

        GotRegisterMsg registerMsg ->
            case page of
                RegisterPage registerModel ->
                    toRegister model (Register.update registerMsg registerModel)

                _ ->
                    ( model, Cmd.none )

        GotLoginMsg loginMsg ->
            case page of
                LoginPage loginModel ->
                    toLogin model (Login.update loginMsg loginModel)

                _ ->
                    ( model, Cmd.none )


view : Model -> Browser.Document Msg
view ({ page } as model) =
    case page of
        LandingPage ->
            { title = "Mytinerary"
            , body =
                [ Landing.view ]
            }
                |> addContentWrapper
                |> addNavbar model

        CitiesPage citiesModel ->
            Cities.view citiesModel
                |> documentMap GotCitiesMsg
                |> addContentWrapper
                |> addNavbar model

        CityPage cityModel ->
            City.view cityModel
                |> documentMap GotCityMsg
                |> addContentWrapper
                |> addNavbar model

        RegisterPage registerModel ->
            Register.view registerModel
                |> documentMap GotRegisterMsg
                |> addContentWrapper
                |> addNavbar model

        LoginPage loginModel ->
            Login.view loginModel
                |> documentMap GotLoginMsg
                |> addContentWrapper
                |> addNavbar model

        PageNotFound ->
            { title = "Page not found"
            , body = [ div [] [ text "Page not found" ] ]
            }


addContentWrapper : Browser.Document msg -> Browser.Document msg
addContentWrapper { title, body } =
    { title = title
    , body =
        [ div [ class "h-screen pt-12" ] body
        ]
    }


addNavbar : Model -> Browser.Document Msg -> Browser.Document Msg
addNavbar model { title, body } =
    { title = title
    , body = mobileNavbar model :: body
    }


isLoggedIn : Model -> Bool
isLoggedIn model =
    case model.user of
        LoggedIn _ ->
            True

        _ ->
            False


mobileNavbar : Model -> Html Msg
mobileNavbar ({ isMenuExpanded } as model) =
    div [ class "bg-white fixed h-12 w-screen flex justify-between z-20 shadow-sm" ]
        [ a
            [ href "/"
            , class "inline-block flex text-xl px-2 h-full font-semibold pb-1 text-red-600 focus:text-red-600 active:text-red-600"
            ]
            [ div [ class "self-center" ] [ text "Mytinerary" ] ]
        , div [ class "h-full flex" ]
            [ button
                [ class "px-4 h-full"
                , onClick ToggleMenu
                ]
                [ burgerSvg ]
            , button
                [ class "h-full"
                , classList [ ( "px-1", isLoggedIn model ), ( "px-2", not (isLoggedIn model) ) ]
                , onClick ToggleUserMenu
                ]
                [ case model.user of
                    LoggedIn data ->
                        case data.profile_pic of
                            Just pfp ->
                                img [ class "h-10 w-10 rounded-full", src pfp ] []

                            Nothing ->
                                div [ class "h-10 w-10 rounded-full bg-red-300 flex justify-center items-center text-black" ]
                                    [ p [ class "text-xl capitalize" ] [ text (String.left 1 data.username) ]
                                    ]

                    _ ->
                        avatarSvg
                ]
            ]
        , mobileMenuContent isMenuExpanded
        , userMobileMenuContent model
        ]


mobileMenuContent : Bool -> Html msg
mobileMenuContent isMenuExpanded =
    div
        [ class
            "w-screen h-auto z-20 bg-white absolute top-full text-lg text-center py-2"
        , classList [ ( "hidden", not isMenuExpanded ) ]
        ]
        [ ul []
            [ li [] [ a [ class "block", href "/cities" ] [ text "Cities" ] ]
            , li [] [ a [ class "block", href "/" ] [ text "Home" ] ]
            ]
        ]


userMobileMenuContent : Model -> Html Msg
userMobileMenuContent model =
    div
        [ class
            "w-screen h-auto z-20 bg-white absolute top-full text-lg text-center py-2"
        , classList [ ( "hidden", not model.isUserMenuExpanded ) ]
        ]
        [ ul []
            (if isLoggedIn model then
                [ li [] [ button [ class "block text-center w-full", onClick LogOut ] [ p [] [ text "Log Out" ] ] ] ]

             else
                [ li [] [ a [ class "block", href "/register" ] [ text "Register" ] ]
                , li [] [ a [ class "block", href "/login" ] [ text "Log In" ] ]
                ]
            )
        ]


burgerSvg : Html msg
burgerSvg =
    svg
        [ Svg.Attributes.class "h-6 w-6"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap
                "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M4 6h16M4 12h16M4 18h16"
            ]
            []
        ]


avatarSvg : Html msg
avatarSvg =
    svg
        [ Svg.Attributes.class "h-6 w-6"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
            ]
            []
        ]


documentMap : (msg -> Msg) -> Browser.Document msg -> Browser.Document Msg
documentMap msg { title, body } =
    { title = title
    , body = List.map (Html.map msg) body
    }
