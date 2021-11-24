module Pages.Landing exposing (view)

import Html exposing (Html, a, br, div, h1, img, section, text)
import Html.Attributes exposing (class, href, src, style)


view : Html msg
view =
    section [ class "h-full w-screen relative flex flex-col" ]
        [ img [ src "/assets/heroBgr.jpg", class "absolute inset-0 h-full w-full object-cover object-center", style "z-index" "-1", style "filter" "brightness(0.35)" ] []
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
