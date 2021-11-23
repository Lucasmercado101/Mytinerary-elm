module Pages.Landing exposing (view)

import Browser
import Html exposing (Html, a, button, div, img, section, text)
import Html.Attributes exposing (class, href, src, style)
import Svg exposing (svg)
import Svg.Attributes exposing (d, fill, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


view : Browser.Document msg
view =
    { title = "Mytinerary"
    , body =
        [ section [ class "h-screen w-screen relative" ]
            [ img [ src "../assets/heroBgr.jpg", class "absolute inset-0 h-full object-cover object-center filter brightness-50", style "z-index" "-1" ] []
            , mobileNavbar
            , content [ text "a" ]
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
        --                         [ text "Find your perfect trip, designed by insiders who know and love their\n          cities."
        --                         ]
        --                     ]
        --                 ]
        --             , col [ class "has-text-centered" ]
        --                 [ a [ href "/cities" ] [ img [ style "max-height" "180px", src "../assets/arrowRight.svg" ] [] ]
        --                 ]
        --             ]
        --         ]
        --     ]
        ]
    }


mobileNavbar : Html msg
mobileNavbar =
    div [ class "bg-white fixed h-12 w-screen flex justify-between" ]
        [ a
            [ href "/"
            , class "inline-block text-xl p-2 h-full bold text-red-600 focus:text-red-600"
            ]
            [ text "Mytinerary" ]
        , button [ class "px-2" ] [ burgerSvg ]
        ]


content : List (Html msg) -> Html msg
content html =
    div [ class "pt-14 h-screen" ]
        html


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
