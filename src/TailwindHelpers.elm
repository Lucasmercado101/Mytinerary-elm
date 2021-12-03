module TailwindHelpers exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (class)


apply : List String -> Attribute msg
apply classes =
    class (String.join " " classes)



-- Resposive helpers (https://tailwindcss.com/docs/responsive-design)


sm : List String -> String
sm strs =
    strs
        |> List.map (\str -> "sm:" ++ str)
        |> String.join " "


md : List String -> String
md strs =
    strs
        |> List.map (\str -> "md:" ++ str)
        |> String.join " "


lg : List String -> String
lg strs =
    strs
        |> List.map (\str -> "lg:" ++ str)
        |> String.join " "


s2xl : List String -> String
s2xl strs =
    strs
        |> List.map (\str -> "s2xl:" ++ str)
        |> String.join " "



-- Width (https://tailwindcss.com/docs/width)
{- w-0 -}


w_0 : String
w_0 =
    "w-0"



{- w-px -}


w_px : String
w_px =
    "w-px"



{- w-0.5 -}


w_0_dot_5 : String
w_0_dot_5 =
    "w-0.5"



{- w-1 -}


w_1 : String
w_1 =
    "w-1"



{- w-1.5 -}


w_1_dot_5 : String
w_1_dot_5 =
    "w-1.5"



{- w-2 -}


w_2 : String
w_2 =
    "w-2"



{- w-2.5 -}


w_2_dot_5 : String
w_2_dot_5 =
    "w-2.5"



{- w-3 -}


w_3 : String
w_3 =
    "w-3"



{- w-3.5 -}


w_3__dot_ot_5 : String
w_3__dot_ot_5 =
    "w-3.5"



{- w-4 -}


w_4 : String
w_4 =
    "w-4"



{- w-5 -}


w_5 : String
w_5 =
    "w-5"



{- w-6 -}


w_6 : String
w_6 =
    "w-6"



{- w-7 -}


w_7 : String
w_7 =
    "w-7"



{- w-8 -}


w_8 : String
w_8 =
    "w-8"



{- w-9 -}


w_9 : String
w_9 =
    "w-9"



{- w-10 -}


w_10 : String
w_10 =
    "w-10"



{- w-11 -}


w_11 : String
w_11 =
    "w-11"



{- w-12 -}


w_12 : String
w_12 =
    "w-12"



{- w-14 -}


w_14 : String
w_14 =
    "w-14"



{- w-16 -}


w_16 : String
w_16 =
    "w-16"



{- w-20 -}


w_20 : String
w_20 =
    "w-20"



{- w-24 -}


w_24 : String
w_24 =
    "w-24"



{- w-28 -}


w_28 : String
w_28 =
    "w-28"



{- w-32 -}


w_32 : String
w_32 =
    "w-32"



{- w-36 -}


w_36 : String
w_36 =
    "w-36"



{- w-40 -}


w_40 : String
w_40 =
    "w-40"



{- w-44 -}


w_44 : String
w_44 =
    "w-44"



{- w-48 -}


w_48 : String
w_48 =
    "w-48"



{- w-52 -}


w_52 : String
w_52 =
    "w-52"



{- w-56 -}


w_56 : String
w_56 =
    "w-56"



{- w-60 -}


w_60 : String
w_60 =
    "w-60"



{- w-64 -}


w_64 : String
w_64 =
    "w-64"



{- w-72 -}


w_72 : String
w_72 =
    "w-72"



{- w-80 -}


w_80 : String
w_80 =
    "w-80"



{- w-96 -}


w_96 : String
w_96 =
    "w-96"



{- w-auto -}


w_auto : String
w_auto =
    "w-auto"



{- w-1/2 -}


w_1_slash_2 : String
w_1_slash_2 =
    "w-1/2"



{- w-1/3 -}


w_1_slash_3 : String
w_1_slash_3 =
    "w-1/3"



{- w-2/3 -}


w_2_slash_3 : String
w_2_slash_3 =
    "w-2/3"



{- w-1/4 -}


w_1_slash_4 : String
w_1_slash_4 =
    "w-1/4"



{- w-2/4 -}


w_2_slash_4 : String
w_2_slash_4 =
    "w-2/4"



{- w-3/4 -}


w_3_slash_4 : String
w_3_slash_4 =
    "w-3/4"



{- w-1/5 -}


w_1_slash_5 : String
w_1_slash_5 =
    "w-1/5"



{- w-2/5 -}


w_2_slash_5 : String
w_2_slash_5 =
    "w-2/5"



{- w-3/5 -}


w_3_slash_5 : String
w_3_slash_5 =
    "w-3/5"



{- w-4/5 -}


w_4_slash_5 : String
w_4_slash_5 =
    "w-4/5"



{- w-1/6 -}


w_1_slash_6 : String
w_1_slash_6 =
    "w-1/6"



{- w-2/6 -}


w_2_slash_6 : String
w_2_slash_6 =
    "w-2/6"



{- w-3/6 -}


w_3_slash_6 : String
w_3_slash_6 =
    "w-3/6"



{- w-4/6 -}


w_4_slash_6 : String
w_4_slash_6 =
    "w-4/6"



{- w-5/6 -}


w_5_slash_6 : String
w_5_slash_6 =
    "w-5/6"



{- w-1/12 -}


w_1_slash_12 : String
w_1_slash_12 =
    "w-1/12"



{- w-2/12 -}


w_2_slash_12 : String
w_2_slash_12 =
    "w-2/12"



{- w-3/12 -}


w_3_slash_12 : String
w_3_slash_12 =
    "w-3/12"



{- w-4/12 -}


w_4_slash_12 : String
w_4_slash_12 =
    "w-4/12"



{- w-5/12 -}


w_5_slash_12 : String
w_5_slash_12 =
    "w-5/12"



{- w-6/12 -}


w_6_slash_12 : String
w_6_slash_12 =
    "w-6/12"



{- w-7/12 -}


w_7_slash_12 : String
w_7_slash_12 =
    "w-7/12"



{- w-8/12 -}


w_8_slash_12 : String
w_8_slash_12 =
    "w-8/12"



{- w-9/12 -}


w_9_slash_12 : String
w_9_slash_12 =
    "w-9/12"



{- w-10/12 -}


w_10_slash__12 : String
w_10_slash__12 =
    "w-10/12"



{- w-11/12 -}


w_11_slash__12 : String
w_11_slash__12 =
    "w-11/12"



{- w-full -}


w_full : String
w_full =
    "w-full"



{- w-screen -}


w_screen : String
w_screen =
    "w-screen"



{- w-min -}


w_min : String
w_min =
    "w-min"



{- w-max -}


w_max : String
w_max =
    "w-max"



-- Max Width (https://tailwindcss.com/docs/max-width)


max_w_0 : String
max_w_0 =
    "max-w-0"


max_w_none : String
max_w_none =
    "max-w-none"


max_w_xs : String
max_w_xs =
    "max-w-xs"


max_w_sm : String
max_w_sm =
    "max-w-sm"


max_w_md : String
max_w_md =
    "max-w-md"


max_w_lg : String
max_w_lg =
    "max-w-lg"


max_w_xl : String
max_w_xl =
    "max-w-xl"


max_w_2xl : String
max_w_2xl =
    "max-w-2xl"


max_w_3xl : String
max_w_3xl =
    "max-w-3xl"


max_w_4xl : String
max_w_4xl =
    "max-w-4xl"


max_w_5xl : String
max_w_5xl =
    "max-w-5xl"


max_w_6xl : String
max_w_6xl =
    "max-w-6xl"


max_w_7xl : String
max_w_7xl =
    "max-w-7xl"


max_w_full : String
max_w_full =
    "max-w-full"


max_w_min : String
max_w_min =
    "max-w-min"


max_w_max : String
max_w_max =
    "max-w-max"


max_w_prose : String
max_w_prose =
    "max-w-prose"


max_w_screen_sm : String
max_w_screen_sm =
    "max-w-screen-sm"


max_w_screen_md : String
max_w_screen_md =
    "max-w-screen-md"


max_w_screen_lg : String
max_w_screen_lg =
    "max-w-screen-lg"


max_w_screen_xl : String
max_w_screen_xl =
    "max-w-screen-xl"


max_w_screen_2xl : String
max_w_screen_2xl =
    "max-w-screen-2x"
