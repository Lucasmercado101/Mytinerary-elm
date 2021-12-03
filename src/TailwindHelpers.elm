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



-- Padding (https://tailwindcss.com/docs/padding)
{- p-0 -}


p_0 : String
p_0 =
    "p-0"



{- p-px -}


p_px : String
p_px =
    "p-px"



{- p-0.5 -}


p_0_dot_5 : String
p_0_dot_5 =
    "p-0.5"



{- p-1 -}


p_1 : String
p_1 =
    "p-1"



{- p-1.5 -}


p_1_dot_5 : String
p_1_dot_5 =
    "p-1.5"



{- p-2 -}


p_2 : String
p_2 =
    "p-2"



{- p-2.5 -}


p_2_dot_5 : String
p_2_dot_5 =
    "p-2.5"



{- p-3 -}


p_3 : String
p_3 =
    "p-3"



{- p-3.5 -}


p_3_dot_5 : String
p_3_dot_5 =
    "p-3.5"



{- p-4 -}


p_4 : String
p_4 =
    "p-4"



{- p-5 -}


p_5 : String
p_5 =
    "p-5"



{- p-6 -}


p_6 : String
p_6 =
    "p-6"



{- p-7 -}


p_7 : String
p_7 =
    "p-7"



{- p-8 -}


p_8 : String
p_8 =
    "p-8"



{- p-9 -}


p_9 : String
p_9 =
    "p-9"



{- p-10 -}


p_10 : String
p_10 =
    "p-10"



{- p-11 -}


p_11 : String
p_11 =
    "p-11"



{- p-12 -}


p_12 : String
p_12 =
    "p-12"



{- p-14 -}


p_14 : String
p_14 =
    "p-14"



{- p-16 -}


p_16 : String
p_16 =
    "p-16"



{- p-20 -}


p_20 : String
p_20 =
    "p-20"



{- p-24 -}


p_24 : String
p_24 =
    "p-24"



{- p-28 -}


p_28 : String
p_28 =
    "p-28"



{- p-32 -}


p_32 : String
p_32 =
    "p-32"



{- p-36 -}


p_36 : String
p_36 =
    "p-36"



{- p-40 -}


p_40 : String
p_40 =
    "p-40"



{- p-44 -}


p_44 : String
p_44 =
    "p-44"



{- p-48 -}


p_48 : String
p_48 =
    "p-48"



{- p-52 -}


p_52 : String
p_52 =
    "p-52"



{- p-56 -}


p_56 : String
p_56 =
    "p-56"



{- p-60 -}


p_60 : String
p_60 =
    "p-60"



{- p-64 -}


p_64 : String
p_64 =
    "p-64"



{- p-72 -}


p_72 : String
p_72 =
    "p-72"



{- p-80 -}


p_80 : String
p_80 =
    "p-80"



{- p-96 -}


p_96 : String
p_96 =
    "p-96"



{- px-0 -}


px_0 : String
px_0 =
    "px-0"



{- px-px -}


px_px : String
px_px =
    "px-px"



{- px-0.5 -}


px_0_dot_5 : String
px_0_dot_5 =
    "px-0.5"



{- px-1 -}


px_1 : String
px_1 =
    "px-1"



{- px-1.5 -}


px_1_dot_5 : String
px_1_dot_5 =
    "px-1.5"



{- px-2 -}


px_2 : String
px_2 =
    "px-2"



{- px-2.5 -}


px_2_dot_5 : String
px_2_dot_5 =
    "px-2.5"



{- px-3 -}


px_3 : String
px_3 =
    "px-3"



{- px-3.5 -}


px_3_dot_5 : String
px_3_dot_5 =
    "px-3.5"



{- px-4 -}


px_4 : String
px_4 =
    "px-4"



{- px-5 -}


px_5 : String
px_5 =
    "px-5"



{- px-6 -}


px_6 : String
px_6 =
    "px-6"



{- px-7 -}


px_7 : String
px_7 =
    "px-7"



{- px-8 -}


px_8 : String
px_8 =
    "px-8"



{- px-9 -}


px_9 : String
px_9 =
    "px-9"



{- px-10 -}


px_10 : String
px_10 =
    "px-10"



{- px-11 -}


px_11 : String
px_11 =
    "px-11"



{- px-12 -}


px_12 : String
px_12 =
    "px-12"



{- px-14 -}


px_14 : String
px_14 =
    "px-14"



{- px-16 -}


px_16 : String
px_16 =
    "px-16"



{- px-20 -}


px_20 : String
px_20 =
    "px-20"



{- px-24 -}


px_24 : String
px_24 =
    "px-24"



{- px-28 -}


px_28 : String
px_28 =
    "px-28"



{- px-32 -}


px_32 : String
px_32 =
    "px-32"



{- px-36 -}


px_36 : String
px_36 =
    "px-36"



{- px-40 -}


px_40 : String
px_40 =
    "px-40"



{- px-44 -}


px_44 : String
px_44 =
    "px-44"



{- px-48 -}


px_48 : String
px_48 =
    "px-48"



{- px-52 -}


px_52 : String
px_52 =
    "px-52"



{- px-56 -}


px_56 : String
px_56 =
    "px-56"



{- px-60 -}


px_60 : String
px_60 =
    "px-60"



{- px-64 -}


px_64 : String
px_64 =
    "px-64"



{- px-72 -}


px_72 : String
px_72 =
    "px-72"



{- px-80 -}


px_80 : String
px_80 =
    "px-80"



{- px-96 -}


px_96 : String
px_96 =
    "px-96"



{- py-0 -}


py_0 : String
py_0 =
    "py-0"



{- py-px -}


py_px : String
py_px =
    "py-px"



{- py-0.5 -}


py_0_dot_5 : String
py_0_dot_5 =
    "py-0.5"



{- py-1 -}


py_1 : String
py_1 =
    "py-1"



{- py-1.5 -}


py_1_dot_5 : String
py_1_dot_5 =
    "py-1.5"



{- py-2 -}


py_2 : String
py_2 =
    "py-2"



{- py-2.5 -}


py_2_dot_5 : String
py_2_dot_5 =
    "py-2.5"



{- py-3 -}


py_3 : String
py_3 =
    "py-3"



{- py-3.5 -}


py_3_dot_5 : String
py_3_dot_5 =
    "py-3.5"



{- py-4 -}


py_4 : String
py_4 =
    "py-4"



{- py-5 -}


py_5 : String
py_5 =
    "py-5"



{- py-6 -}


py_6 : String
py_6 =
    "py-6"



{- py-7 -}


py_7 : String
py_7 =
    "py-7"



{- py-8 -}


py_8 : String
py_8 =
    "py-8"



{- py-9 -}


py_9 : String
py_9 =
    "py-9"



{- py-10 -}


py_10 : String
py_10 =
    "py-10"



{- py-11 -}


py_11 : String
py_11 =
    "py-11"



{- py-12 -}


py_12 : String
py_12 =
    "py-12"



{- py-14 -}


py_14 : String
py_14 =
    "py-14"



{- py-16 -}


py_16 : String
py_16 =
    "py-16"



{- py-20 -}


py_20 : String
py_20 =
    "py-20"



{- py-24 -}


py_24 : String
py_24 =
    "py-24"



{- py-28 -}


py_28 : String
py_28 =
    "py-28"



{- py-32 -}


py_32 : String
py_32 =
    "py-32"



{- py-36 -}


py_36 : String
py_36 =
    "py-36"



{- py-40 -}


py_40 : String
py_40 =
    "py-40"



{- py-44 -}


py_44 : String
py_44 =
    "py-44"



{- py-48 -}


py_48 : String
py_48 =
    "py-48"



{- py-52 -}


py_52 : String
py_52 =
    "py-52"



{- py-56 -}


py_56 : String
py_56 =
    "py-56"



{- py-60 -}


py_60 : String
py_60 =
    "py-60"



{- py-64 -}


py_64 : String
py_64 =
    "py-64"



{- py-72 -}


py_72 : String
py_72 =
    "py-72"



{- py-80 -}


py_80 : String
py_80 =
    "py-80"



{- py-96 -}


py_96 : String
py_96 =
    "py-96"



{- pt-0 -}


pt_0 : String
pt_0 =
    "pt-0"



{- pt-px -}


pt_px : String
pt_px =
    "pt-px"



{- pt-0.5 -}


pt_0_dot_5 : String
pt_0_dot_5 =
    "pt-0.5"



{- pt-1 -}


pt_1 : String
pt_1 =
    "pt-1"



{- pt-1.5 -}


pt_1_dot_5 : String
pt_1_dot_5 =
    "pt-1.5"



{- pt-2 -}


pt_2 : String
pt_2 =
    "pt-2"



{- pt-2.5 -}


pt_2_dot_5 : String
pt_2_dot_5 =
    "pt-2.5"



{- pt-3 -}


pt_3 : String
pt_3 =
    "pt-3"



{- pt-3.5 -}


pt_3_dot_5 : String
pt_3_dot_5 =
    "pt-3.5"



{- pt-4 -}


pt_4 : String
pt_4 =
    "pt-4"



{- pt-5 -}


pt_5 : String
pt_5 =
    "pt-5"



{- pt-6 -}


pt_6 : String
pt_6 =
    "pt-6"



{- pt-7 -}


pt_7 : String
pt_7 =
    "pt-7"



{- pt-8 -}


pt_8 : String
pt_8 =
    "pt-8"



{- pt-9 -}


pt_9 : String
pt_9 =
    "pt-9"



{- pt-10 -}


pt_10 : String
pt_10 =
    "pt-10"



{- pt-11 -}


pt_11 : String
pt_11 =
    "pt-11"



{- pt-12 -}


pt_12 : String
pt_12 =
    "pt-12"



{- pt-14 -}


pt_14 : String
pt_14 =
    "pt-14"



{- pt-16 -}


pt_16 : String
pt_16 =
    "pt-16"



{- pt-20 -}


pt_20 : String
pt_20 =
    "pt-20"



{- pt-24 -}


pt_24 : String
pt_24 =
    "pt-24"



{- pt-28 -}


pt_28 : String
pt_28 =
    "pt-28"



{- pt-32 -}


pt_32 : String
pt_32 =
    "pt-32"



{- pt-36 -}


pt_36 : String
pt_36 =
    "pt-36"



{- pt-40 -}


pt_40 : String
pt_40 =
    "pt-40"



{- pt-44 -}


pt_44 : String
pt_44 =
    "pt-44"



{- pt-48 -}


pt_48 : String
pt_48 =
    "pt-48"



{- pt-52 -}


pt_52 : String
pt_52 =
    "pt-52"



{- pt-56 -}


pt_56 : String
pt_56 =
    "pt-56"



{- pt-60 -}


pt_60 : String
pt_60 =
    "pt-60"



{- pt-64 -}


pt_64 : String
pt_64 =
    "pt-64"



{- pt-72 -}


pt_72 : String
pt_72 =
    "pt-72"



{- pt-80 -}


pt_80 : String
pt_80 =
    "pt-80"



{- pt-96 -}


pt_96 : String
pt_96 =
    "pt-96"



{- pr-0 -}


pr_0 : String
pr_0 =
    "pr-0"



{- pr-px -}


pr_px : String
pr_px =
    "pr-px"



{- pr-0.5 -}


pr_0_dot_5 : String
pr_0_dot_5 =
    "pr-0.5"



{- pr-1 -}


pr_1 : String
pr_1 =
    "pr-1"



{- pr-1.5 -}


pr_1_dot_5 : String
pr_1_dot_5 =
    "pr-1.5"



{- pr-2 -}


pr_2 : String
pr_2 =
    "pr-2"



{- pr-2.5 -}


pr_2_dot_5 : String
pr_2_dot_5 =
    "pr-2.5"



{- pr-3 -}


pr_3 : String
pr_3 =
    "pr-3"



{- pr-3.5 -}


pr_3_dot_5 : String
pr_3_dot_5 =
    "pr-3.5"



{- pr-4 -}


pr_4 : String
pr_4 =
    "pr-4"



{- pr-5 -}


pr_5 : String
pr_5 =
    "pr-5"



{- pr-6 -}


pr_6 : String
pr_6 =
    "pr-6"



{- pr-7 -}


pr_7 : String
pr_7 =
    "pr-7"



{- pr-8 -}


pr_8 : String
pr_8 =
    "pr-8"



{- pr-9 -}


pr_9 : String
pr_9 =
    "pr-9"



{- pr-10 -}


pr_10 : String
pr_10 =
    "pr-10"



{- pr-11 -}


pr_11 : String
pr_11 =
    "pr-11"



{- pr-12 -}


pr_12 : String
pr_12 =
    "pr-12"



{- pr-14 -}


pr_14 : String
pr_14 =
    "pr-14"



{- pr-16 -}


pr_16 : String
pr_16 =
    "pr-16"



{- pr-20 -}


pr_20 : String
pr_20 =
    "pr-20"



{- pr-24 -}


pr_24 : String
pr_24 =
    "pr-24"



{- pr-28 -}


pr_28 : String
pr_28 =
    "pr-28"



{- pr-32 -}


pr_32 : String
pr_32 =
    "pr-32"



{- pr-36 -}


pr_36 : String
pr_36 =
    "pr-36"



{- pr-40 -}


pr_40 : String
pr_40 =
    "pr-40"



{- pr-44 -}


pr_44 : String
pr_44 =
    "pr-44"



{- pr-48 -}


pr_48 : String
pr_48 =
    "pr-48"



{- pr-52 -}


pr_52 : String
pr_52 =
    "pr-52"



{- pr-56 -}


pr_56 : String
pr_56 =
    "pr-56"



{- pr-60 -}


pr_60 : String
pr_60 =
    "pr-60"



{- pr-64 -}


pr_64 : String
pr_64 =
    "pr-64"



{- pr-72 -}


pr_72 : String
pr_72 =
    "pr-72"



{- pr-80 -}


pr_80 : String
pr_80 =
    "pr-80"



{- pr-96 -}


pr_96 : String
pr_96 =
    "pr-96"



{- pb-0 -}


pb_0 : String
pb_0 =
    "pb-0"



{- pb-px -}


pb_px : String
pb_px =
    "pb-px"



{- pb-0.5 -}


pb_0_dot_5 : String
pb_0_dot_5 =
    "pb-0.5"



{- pb-1 -}


pb_1 : String
pb_1 =
    "pb-1"



{- pb-1.5 -}


pb_1_dot_5 : String
pb_1_dot_5 =
    "pb-1.5"



{- pb-2 -}


pb_2 : String
pb_2 =
    "pb-2"



{- pb-2.5 -}


pb_2_dot_5 : String
pb_2_dot_5 =
    "pb-2.5"



{- pb-3 -}


pb_3 : String
pb_3 =
    "pb-3"



{- pb-3.5 -}


pb_3_dot_5 : String
pb_3_dot_5 =
    "pb-3.5"



{- pb-4 -}


pb_4 : String
pb_4 =
    "pb-4"



{- pb-5 -}


pb_5 : String
pb_5 =
    "pb-5"



{- pb-6 -}


pb_6 : String
pb_6 =
    "pb-6"



{- pb-7 -}


pb_7 : String
pb_7 =
    "pb-7"



{- pb-8 -}


pb_8 : String
pb_8 =
    "pb-8"



{- pb-9 -}


pb_9 : String
pb_9 =
    "pb-9"



{- pb-10 -}


pb_10 : String
pb_10 =
    "pb-10"



{- pb-11 -}


pb_11 : String
pb_11 =
    "pb-11"



{- pb-12 -}


pb_12 : String
pb_12 =
    "pb-12"



{- pb-14 -}


pb_14 : String
pb_14 =
    "pb-14"



{- pb-16 -}


pb_16 : String
pb_16 =
    "pb-16"



{- pb-20 -}


pb_20 : String
pb_20 =
    "pb-20"



{- pb-24 -}


pb_24 : String
pb_24 =
    "pb-24"



{- pb-28 -}


pb_28 : String
pb_28 =
    "pb-28"



{- pb-32 -}


pb_32 : String
pb_32 =
    "pb-32"



{- pb-36 -}


pb_36 : String
pb_36 =
    "pb-36"



{- pb-40 -}


pb_40 : String
pb_40 =
    "pb-40"



{- pb-44 -}


pb_44 : String
pb_44 =
    "pb-44"



{- pb-48 -}


pb_48 : String
pb_48 =
    "pb-48"



{- pb-52 -}


pb_52 : String
pb_52 =
    "pb-52"



{- pb-56 -}


pb_56 : String
pb_56 =
    "pb-56"



{- pb-60 -}


pb_60 : String
pb_60 =
    "pb-60"



{- pb-64 -}


pb_64 : String
pb_64 =
    "pb-64"



{- pb-72 -}


pb_72 : String
pb_72 =
    "pb-72"



{- pb-80 -}


pb_80 : String
pb_80 =
    "pb-80"



{- pb-96 -}


pb_96 : String
pb_96 =
    "pb-96"



{- pl-0 -}


pl_0 : String
pl_0 =
    "pl-0"



{- pl-px -}


pl_px : String
pl_px =
    "pl-px"



{- pl-0.5 -}


pl_0_dot_5 : String
pl_0_dot_5 =
    "pl-0.5"



{- pl-1 -}


pl_1 : String
pl_1 =
    "pl-1"



{- pl-1.5 -}


pl_1_dot_5 : String
pl_1_dot_5 =
    "pl-1.5"



{- pl-2 -}


pl_2 : String
pl_2 =
    "pl-2"



{- pl-2.5 -}


pl_2_dot_5 : String
pl_2_dot_5 =
    "pl-2.5"



{- pl-3 -}


pl_3 : String
pl_3 =
    "pl-3"



{- pl-3.5 -}


pl_3_dot_5 : String
pl_3_dot_5 =
    "pl-3.5"



{- pl-4 -}


pl_4 : String
pl_4 =
    "pl-4"



{- pl-5 -}


pl_5 : String
pl_5 =
    "pl-5"



{- pl-6 -}


pl_6 : String
pl_6 =
    "pl-6"



{- pl-7 -}


pl_7 : String
pl_7 =
    "pl-7"



{- pl-8 -}


pl_8 : String
pl_8 =
    "pl-8"



{- pl-9 -}


pl_9 : String
pl_9 =
    "pl-9"



{- pl-10 -}


pl_10 : String
pl_10 =
    "pl-10"



{- pl-11 -}


pl_11 : String
pl_11 =
    "pl-11"



{- pl-12 -}


pl_12 : String
pl_12 =
    "pl-12"



{- pl-14 -}


pl_14 : String
pl_14 =
    "pl-14"



{- pl-16 -}


pl_16 : String
pl_16 =
    "pl-16"



{- pl-20 -}


pl_20 : String
pl_20 =
    "pl-20"



{- pl-24 -}


pl_24 : String
pl_24 =
    "pl-24"



{- pl-28 -}


pl_28 : String
pl_28 =
    "pl-28"



{- pl-32 -}


pl_32 : String
pl_32 =
    "pl-32"



{- pl-36 -}


pl_36 : String
pl_36 =
    "pl-36"



{- pl-40 -}


pl_40 : String
pl_40 =
    "pl-40"



{- pl-44 -}


pl_44 : String
pl_44 =
    "pl-44"



{- pl-48 -}


pl_48 : String
pl_48 =
    "pl-48"



{- pl-52 -}


pl_52 : String
pl_52 =
    "pl-52"



{- pl-56 -}


pl_56 : String
pl_56 =
    "pl-56"



{- pl-60 -}


pl_60 : String
pl_60 =
    "pl-60"



{- pl-64 -}


pl_64 : String
pl_64 =
    "pl-64"



{- pl-72 -}


pl_72 : String
pl_72 =
    "pl-72"



{- pl-80 -}


pl_80 : String
pl_80 =
    "pl-80"
