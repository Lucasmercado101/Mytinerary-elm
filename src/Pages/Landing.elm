module Pages.Landing exposing (Model, Msg, init, update, view)

import Html exposing (Html, a, br, button, div, h1, img, li, section, text, ul)
import Html.Attributes exposing (class, classList, href, src, style)
import Html.Events exposing (onClick)
import Svg exposing (svg)
import Svg.Attributes exposing (d, fill, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


type Model
    = IsMenuExpanded Bool


type Msg
    = OpenMenu
    | CloseMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OpenMenu ->
            ( IsMenuExpanded True, Cmd.none )

        CloseMenu ->
            ( IsMenuExpanded False, Cmd.none )


init : ( Model, Cmd Msg )
init =
    ( IsMenuExpanded False, Cmd.none )


view : Model -> Html Msg
view model =
    section [ class "h-screen w-screen relative flex flex-col" ]
        [ img [ src "/assets/heroBgr.jpg", class "absolute inset-0 h-full w-full object-cover object-center", style "z-index" "-1", style "filter" "brightness(0.35)" ] []
        , mobileNavbar model
        , div [ class "h-screen  flex flex-col justify-evenly lg:flex-row lg:items-center px-5 xl:px-28" ]
            [ div [ class "hidden lg:flex flex-col gap-y-14" ]
                [ img [ class "md:max-w-lg xl:max-w-2xl", src "/assets/mytinerary_logo.svg" ] []
                , h1 [ class "md:text-3xl xl:text-4xl text-white text-semibold" ] [ text "Find your perfect trip, designed by", br [] [], text "insiders who know and love their cities." ]
                ]
            , img [ class "lg:hidden", src "/assets/mytinerary_logo.svg" ] []
            , h1 [ class "lg:hidden", class "text-2xl text-white" ] [ text "Find your perfect trip, designed by insiders who know and love their\n          cities." ]
            , a [ href "/cities" ] [ img [ class "max-h-40 md:max-h-52 xl:max-h-64 mx-auto", src "/assets/arrowRight.svg" ] [] ]
            ]
        ]



-- , hero [ class "is-fullheight" ]
--     [ heroHead []
--         [ navbar [ class "has-background-white" ]
--             [ mobileNavbar ]
--         ]
--     , heroBody []
--         [ columns [ class "is-3 is-variable is-fullwidth is-flex-tablet is-vcentered container mx-auto" ]
--             [ columns [ class "column is-multiline" ]
--                 [ col [ class "is-full" ] [  ] [] ]
--                 , col [ class "is-full" ]
--                     [ p [ class "has-text-white is-size-3-tablet is-size-4-mobile", style "line-height" "1.4" ]
--                         [ text
--                         ]
--                     ]
--                 ]
--             , col [ class "has-text-centered" ]
--                 [ ]
--                 ]
--             ]
--         ]
--     ]


mobileNavbar : Model -> Html Msg
mobileNavbar model =
    div [ class "bg-white fixed h-12 w-screen flex justify-between relative" ]
        [ a
            [ href "/"
            , class "inline-block flex text-xl px-2 h-full font-semibold pb-1 text-red-600 focus:text-red-600 active:text-red-600"
            ]
            [ div [ class "self-center" ] [ text "Mytinerary" ] ]
        , button
            [ class "px-2"
            , onClick
                (case model of
                    IsMenuExpanded True ->
                        CloseMenu

                    IsMenuExpanded False ->
                        OpenMenu
                )
            ]
            [ burgerSvg ]
        , mobileMenuContent model
        ]


mobileMenuContent : Model -> Html msg
mobileMenuContent model =
    let
        isMenuHidden =
            case model of
                IsMenuExpanded True ->
                    False

                IsMenuExpanded False ->
                    True
    in
    div
        [ class
            "w-screen h-auto z-20 bg-white absolute top-full text-lg text-center py-2"
        , classList [ ( "hidden", isMenuHidden ) ]
        ]
        [ ul []
            [ li [] [ a [ class "block", href "/cities" ] [ text "Cities" ] ]
            , li [] [ a [ class "block", href "/" ] [ text "Home" ] ]
            ]
        ]


burgerSvg : Html msg
burgerSvg =
    svg
        [ Svg.Attributes.class "h-6 w-6"
        , fill "none"
        , viewBox "0 0 24 24"
        , stroke "currentColor"
        ]
        [ Svg.path
            [ strokeLinecap
                "round"
            , strokeLinejoin "round"
            , strokeWidth "2"
            , d "M4 6h16M4 12h16M4 18h16"
            ]
            []
        ]
