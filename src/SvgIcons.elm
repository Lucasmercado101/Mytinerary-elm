module SvgIcons exposing (..)

import Html exposing (Attribute, Html)
import Html.Attributes exposing (attribute)
import Svg
import Svg.Attributes



-- https://heroicons.com/


burgerSvg : Html msg
burgerSvg =
    Svg.svg
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
    Svg.svg
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


clockSvg : Html msg
clockSvg =
    Svg.svg
        [ Svg.Attributes.class "h-5 w-5"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
            ]
            []
        ]


xSvg : Html msg
xSvg =
    Svg.svg
        [ Svg.Attributes.class "h-6 w-6"
        , Svg.Attributes.fill "none"
        , attribute "stroke" "currentColor"
        , Svg.Attributes.viewBox "0 0 24 24"
        , attribute "xmlns" "http://www.w3.org/2000/svg"
        ]
        [ Svg.path
            [ Svg.Attributes.d "M6 18L18 6M6 6l12 12"
            , attribute "stroke-linecap" "round"
            , attribute "stroke-linejoin" "round"
            , attribute "stroke-width" "2"
            ]
            []
        ]


verticalDotsSvg : Html msg
verticalDotsSvg =
    Svg.svg
        [ Svg.Attributes.class "m-auto text-center h-6 w-6"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap
                "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z"
            ]
            []
        ]


chevronDownSvg : List (Html.Attribute msg) -> Html msg
chevronDownSvg attrs =
    Svg.svg
        ([ Svg.Attributes.fill "none"
         , attribute "stroke" "currentColor"
         , Svg.Attributes.viewBox "0 0 24 24"
         , attribute "xmlns" "http://www.w3.org/2000/svg"
         ]
            ++ attrs
        )
        [ Svg.path
            [ Svg.Attributes.d "M5 15l7-7 7 7"
            , attribute "stroke-linecap" "round"
            , attribute "stroke-linejoin" "round"
            , attribute "stroke-width" "2"
            ]
            []
        ]


errorSvg : Html msg
errorSvg =
    Svg.svg
        [ Svg.Attributes.class "h-8 w-8 text-red-500"
        , Svg.Attributes.fill "none"
        , Svg.Attributes.viewBox "0 0 24 24"
        , Svg.Attributes.stroke "currentColor"
        ]
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
            ]
            []
        ]


mapMarkerOutlineSvg : List (Svg.Attribute msg) -> Html msg
mapMarkerOutlineSvg attrs =
    Svg.svg
        ([ Svg.Attributes.fill "none"
         , Svg.Attributes.viewBox "0 0 24 24"
         , Svg.Attributes.stroke "currentColor"
         ]
            ++ attrs
        )
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
            ]
            []
        , Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M15 11a3 3 0 11-6 0 3 3 0 016 0z"
            ]
            []
        ]


plusSvg : List (Svg.Attribute msg) -> Html msg
plusSvg attrs =
    Svg.svg
        (attrs
            ++ [ Svg.Attributes.fill "none"
               , Svg.Attributes.viewBox "0 0 24 24"
               , Svg.Attributes.stroke "currentColor"
               ]
        )
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M12 4v16m8-8H4"
            ]
            []
        ]


annotationSvg : List (Svg.Attribute msg) -> Html msg
annotationSvg attrs =
    Svg.svg
        ([ Svg.Attributes.fill "none"
         , Svg.Attributes.viewBox "0 0 24 24"
         , Svg.Attributes.stroke "currentColor"
         ]
            ++ attrs
        )
        [ Svg.path
            [ Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.d "M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"
            ]
            []
        ]
