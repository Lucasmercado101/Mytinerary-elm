module Pages.Landing exposing (view)

import Browser
import Html exposing (Html, div, img, section, text)
import Html.Attributes exposing (class, src, style)


view : Browser.Document msg
view =
    { title = "Mytinerary"
    , body =
        [ section [ class "h-screen w-screen relative" ]
            [ img [ src "../assets/heroBgr.jpg", class "absolute inset-0 h-full object-cover object-center filter brightness-50", style "z-index" "-1" ] []
            , navbar
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
        --                 [ col [ class "is-full" ] [ img [ src "../assets/mytinerary_logo.svg" ] [] ]
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


navbar : Html msg
navbar =
    div [ class "bg-white fixed h-14 w-screen" ]
        []


content : List (Html msg) -> Html msg
content html =
    div [ class "pt-14 h-screen" ]
        html
