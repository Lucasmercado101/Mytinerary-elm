module HtmlComponents exposing (..)

import Html exposing (Attribute, Html)
import TailwindHelpers as TW exposing (..)



-- https://v1.tailwindcss.com/components/buttons


button : List (Attribute msg) -> List (Html msg) -> Html msg
button attrs html =
    Html.button
        (TW.apply
            [ bg_blue_500
            , hover [ bg_blue_700 ]
            , rounded
            , font_bold
            , text_white
            , py_2
            , px_4
            ]
            :: attrs
        )
        html
