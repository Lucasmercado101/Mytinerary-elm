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
{- "w-0" -}


w_0 : String
w_0 =
    "w-0"



{- "w-px" -}


w_px : String
w_px =
    "w-px"



{- "w-0.5" -}


w_0_dot_5 : String
w_0_dot_5 =
    "w-0.5"



{- "w-1" -}


w_1 : String
w_1 =
    "w-1"



{- "w-1.5" -}


w_1_dot_5 : String
w_1_dot_5 =
    "w-1.5"



{- "w-2" -}


w_2 : String
w_2 =
    "w-2"



{- "w-2.5" -}


w_2_dot_5 : String
w_2_dot_5 =
    "w-2.5"



{- "w-3" -}


w_3 : String
w_3 =
    "w-3"



{- "w-3.5" -}


w_3__dot_ot_5 : String
w_3__dot_ot_5 =
    "w-3.5"



{- "w-4" -}


w_4 : String
w_4 =
    "w-4"



{- "w-5" -}


w_5 : String
w_5 =
    "w-5"



{- "w-6" -}


w_6 : String
w_6 =
    "w-6"



{- "w-7" -}


w_7 : String
w_7 =
    "w-7"



{- "w-8" -}


w_8 : String
w_8 =
    "w-8"



{- "w-9" -}


w_9 : String
w_9 =
    "w-9"



{- "w-10" -}


w_10 : String
w_10 =
    "w-10"



{- "w-11" -}


w_11 : String
w_11 =
    "w-11"



{- "w-12" -}


w_12 : String
w_12 =
    "w-12"



{- "w-14" -}


w_14 : String
w_14 =
    "w-14"



{- "w-16" -}


w_16 : String
w_16 =
    "w-16"



{- "w-20" -}


w_20 : String
w_20 =
    "w-20"



{- "w-24" -}


w_24 : String
w_24 =
    "w-24"



{- "w-28" -}


w_28 : String
w_28 =
    "w-28"



{- "w-32" -}


w_32 : String
w_32 =
    "w-32"



{- "w-36" -}


w_36 : String
w_36 =
    "w-36"



{- "w-40" -}


w_40 : String
w_40 =
    "w-40"



{- "w-44" -}


w_44 : String
w_44 =
    "w-44"



{- "w-48" -}


w_48 : String
w_48 =
    "w-48"



{- "w-52" -}


w_52 : String
w_52 =
    "w-52"



{- "w-56" -}


w_56 : String
w_56 =
    "w-56"



{- "w-60" -}


w_60 : String
w_60 =
    "w-60"



{- "w-64" -}


w_64 : String
w_64 =
    "w-64"



{- "w-72" -}


w_72 : String
w_72 =
    "w-72"



{- "w-80" -}


w_80 : String
w_80 =
    "w-80"



{- "w-96" -}


w_96 : String
w_96 =
    "w-96"



{- "w-auto" -}


w_auto : String
w_auto =
    "w-auto"



{- "w-1/2" -}


w_1_slash_2 : String
w_1_slash_2 =
    "w-1/2"



{- "w-1/3" -}


w_1_slash_3 : String
w_1_slash_3 =
    "w-1/3"



{- "w-2/3" -}


w_2_slash_3 : String
w_2_slash_3 =
    "w-2/3"



{- "w-1/4" -}


w_1_slash_4 : String
w_1_slash_4 =
    "w-1/4"



{- "w-2/4" -}


w_2_slash_4 : String
w_2_slash_4 =
    "w-2/4"



{- "w-3/4" -}


w_3_slash_4 : String
w_3_slash_4 =
    "w-3/4"



{- "w-1/5" -}


w_1_slash_5 : String
w_1_slash_5 =
    "w-1/5"



{- "w-2/5" -}


w_2_slash_5 : String
w_2_slash_5 =
    "w-2/5"



{- "w-3/5" -}


w_3_slash_5 : String
w_3_slash_5 =
    "w-3/5"



{- "w-4/5" -}


w_4_slash_5 : String
w_4_slash_5 =
    "w-4/5"



{- "w-1/6" -}


w_1_slash_6 : String
w_1_slash_6 =
    "w-1/6"



{- "w-2/6" -}


w_2_slash_6 : String
w_2_slash_6 =
    "w-2/6"



{- "w-3/6" -}


w_3_slash_6 : String
w_3_slash_6 =
    "w-3/6"



{- "w-4/6" -}


w_4_slash_6 : String
w_4_slash_6 =
    "w-4/6"



{- "w-5/6" -}


w_5_slash_6 : String
w_5_slash_6 =
    "w-5/6"



{- "w-1/12" -}


w_1_slash_12 : String
w_1_slash_12 =
    "w-1/12"



{- "w-2/12" -}


w_2_slash_12 : String
w_2_slash_12 =
    "w-2/12"



{- "w-3/12" -}


w_3_slash_12 : String
w_3_slash_12 =
    "w-3/12"



{- "w-4/12" -}


w_4_slash_12 : String
w_4_slash_12 =
    "w-4/12"



{- "w-5/12" -}


w_5_slash_12 : String
w_5_slash_12 =
    "w-5/12"



{- "w-6/12" -}


w_6_slash_12 : String
w_6_slash_12 =
    "w-6/12"



{- "w-7/12" -}


w_7_slash_12 : String
w_7_slash_12 =
    "w-7/12"



{- "w-8/12" -}


w_8_slash_12 : String
w_8_slash_12 =
    "w-8/12"



{- "w-9/12" -}


w_9_slash_12 : String
w_9_slash_12 =
    "w-9/12"



{- "w-10/12" -}


w_10_slash__12 : String
w_10_slash__12 =
    "w-10/12"



{- "w-11/12" -}


w_11_slash__12 : String
w_11_slash__12 =
    "w-11/12"



{- "w-full" -}


w_full : String
w_full =
    "w-full"



{- "w-screen" -}


w_screen : String
w_screen =
    "w-screen"



{- "w-min" -}


w_min : String
w_min =
    "w-min"



{- "w-max" -}


w_max : String
w_max =
    "w-max"



-- Max Width (https://tailwindcss.com/docs/max-width)
{- "max-w-0" -}


max_w_0 : String
max_w_0 =
    "max-w-0"



{- "max-w-none" -}


max_w_none : String
max_w_none =
    "max-w-none"



{- "max-w-xs" -}


max_w_xs : String
max_w_xs =
    "max-w-xs"



{- "max-w-sm" -}


max_w_sm : String
max_w_sm =
    "max-w-sm"



{- "max-w-md" -}


max_w_md : String
max_w_md =
    "max-w-md"



{- "max-w-lg" -}


max_w_lg : String
max_w_lg =
    "max-w-lg"



{- "max-w-xl" -}


max_w_xl : String
max_w_xl =
    "max-w-xl"



{- "max-w-2xl" -}


max_w_2xl : String
max_w_2xl =
    "max-w-2xl"



{- "max-w-3xl" -}


max_w_3xl : String
max_w_3xl =
    "max-w-3xl"



{- "max-w-4xl" -}


max_w_4xl : String
max_w_4xl =
    "max-w-4xl"



{- "max-w-5xl" -}


max_w_5xl : String
max_w_5xl =
    "max-w-5xl"



{- "max-w-6xl" -}


max_w_6xl : String
max_w_6xl =
    "max-w-6xl"



{- "max-w-7xl" -}


max_w_7xl : String
max_w_7xl =
    "max-w-7xl"



{- "max-w-full" -}


max_w_full : String
max_w_full =
    "max-w-full"



{- "max-w-min" -}


max_w_min : String
max_w_min =
    "max-w-min"



{- "max-w-max" -}


max_w_max : String
max_w_max =
    "max-w-max"



{- "max-w-prose" -}


max_w_prose : String
max_w_prose =
    "max-w-prose"



{- "max-w-screen-sm" -}


max_w_screen_sm : String
max_w_screen_sm =
    "max-w-screen-sm"



{- "max-w-screen-md" -}


max_w_screen_md : String
max_w_screen_md =
    "max-w-screen-md"



{- "max-w-screen-lg" -}


max_w_screen_lg : String
max_w_screen_lg =
    "max-w-screen-lg"



{- "max-w-screen-xl" -}


max_w_screen_xl : String
max_w_screen_xl =
    "max-w-screen-xl"



{- "max-w-screen-2x" -}


max_w_screen_2xl : String
max_w_screen_2xl =
    "max-w-screen-2x"



-- Height (https://tailwindcss.com/docs/height)
{- "h-0" -}


h_0 : String
h_0 =
    "h-0"



{- "h-px" -}


h_px : String
h_px =
    "h-px"



{- "h-0.5" -}


h_0_dot_5 : String
h_0_dot_5 =
    "h-0.5"



{- "h-1" -}


h_1 : String
h_1 =
    "h-1"



{- "h-1.5" -}


h_1_dot_5 : String
h_1_dot_5 =
    "h-1.5"



{- "h-2" -}


h_2 : String
h_2 =
    "h-2"



{- "h-2.5" -}


h_2_dot_5 : String
h_2_dot_5 =
    "h-2.5"



{- "h-3" -}


h_3 : String
h_3 =
    "h-3"



{- "h-3.5" -}


h_3_dot_5 : String
h_3_dot_5 =
    "h-3.5"



{- "h-4" -}


h_4 : String
h_4 =
    "h-4"



{- "h-5" -}


h_5 : String
h_5 =
    "h-5"



{- "h-6" -}


h_6 : String
h_6 =
    "h-6"



{- "h-7" -}


h_7 : String
h_7 =
    "h-7"



{- "h-8" -}


h_8 : String
h_8 =
    "h-8"



{- "h-9" -}


h_9 : String
h_9 =
    "h-9"



{- "h-10" -}


h_10 : String
h_10 =
    "h-10"



{- "h-11" -}


h_11 : String
h_11 =
    "h-11"



{- "h-12" -}


h_12 : String
h_12 =
    "h-12"



{- "h-14" -}


h_14 : String
h_14 =
    "h-14"



{- "h-16" -}


h_16 : String
h_16 =
    "h-16"



{- "h-20" -}


h_20 : String
h_20 =
    "h-20"



{- "h-24" -}


h_24 : String
h_24 =
    "h-24"



{- "h-28" -}


h_28 : String
h_28 =
    "h-28"



{- "h-32" -}


h_32 : String
h_32 =
    "h-32"



{- "h-36" -}


h_36 : String
h_36 =
    "h-36"



{- "h-40" -}


h_40 : String
h_40 =
    "h-40"



{- "h-44" -}


h_44 : String
h_44 =
    "h-44"



{- "h-48" -}


h_48 : String
h_48 =
    "h-48"



{- "h-52" -}


h_52 : String
h_52 =
    "h-52"



{- "h-56" -}


h_56 : String
h_56 =
    "h-56"



{- "h-60" -}


h_60 : String
h_60 =
    "h-60"



{- "h-64" -}


h_64 : String
h_64 =
    "h-64"



{- "h-72" -}


h_72 : String
h_72 =
    "h-72"



{- "h-80" -}


h_80 : String
h_80 =
    "h-80"



{- "h-96" -}


h_96 : String
h_96 =
    "h-96"



{- "h-auto" -}


h_auto : String
h_auto =
    "h-auto"



{- "h-1/2" -}


h_1_slash_2 : String
h_1_slash_2 =
    "h-1/2"



{- "h-1/3" -}


h_1_slash_3 : String
h_1_slash_3 =
    "h-1/3"



{- "h-2/3" -}


h_2_slash_3 : String
h_2_slash_3 =
    "h-2/3"



{- "h-1/4" -}


h_1_slash_4 : String
h_1_slash_4 =
    "h-1/4"



{- "h-2/4" -}


h_2_slash_4 : String
h_2_slash_4 =
    "h-2/4"



{- "h-3/4" -}


h_3_slash_4 : String
h_3_slash_4 =
    "h-3/4"



{- "h-1/5" -}


h_1_slash_5 : String
h_1_slash_5 =
    "h-1/5"



{- "h-2/5" -}


h_2_slash_5 : String
h_2_slash_5 =
    "h-2/5"



{- "h-3/5" -}


h_3_slash_5 : String
h_3_slash_5 =
    "h-3/5"



{- "h-4/5" -}


h_4_slash_5 : String
h_4_slash_5 =
    "h-4/5"



{- "h-1/6" -}


h_1_slash_6 : String
h_1_slash_6 =
    "h-1/6"



{- "h-2/6" -}


h_2_slash_6 : String
h_2_slash_6 =
    "h-2/6"



{- "h-3/6" -}


h_3_slash_6 : String
h_3_slash_6 =
    "h-3/6"



{- "h-4/6" -}


h_4_slash_6 : String
h_4_slash_6 =
    "h-4/6"



{- "h-5/6" -}


h_5_slash_6 : String
h_5_slash_6 =
    "h-5/6"



{- "h-full" -}


h_full : String
h_full =
    "h-full"



{- "h-screen" -}


h_screen : String
h_screen =
    "h-screen"



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



-- Margin (https://tailwindcss.com/docs/margin)
{- "m-0" -}


m_0 : String
m_0 =
    "m-0"



{- "m-px" -}


m_px : String
m_px =
    "m-px"



{- "m-0.5" -}


m_0_dot_5 : String
m_0_dot_5 =
    "m-0.5"



{- "m-1" -}


m_1 : String
m_1 =
    "m-1"



{- "m-1.5" -}


m_1_dot_5 : String
m_1_dot_5 =
    "m-1.5"



{- "m-2" -}


m_2 : String
m_2 =
    "m-2"



{- "m-2.5" -}


m_2_dot_5 : String
m_2_dot_5 =
    "m-2.5"



{- "m-3" -}


m_3 : String
m_3 =
    "m-3"



{- "m-3.5" -}


m_3_dot_5 : String
m_3_dot_5 =
    "m-3.5"



{- "m-4" -}


m_4 : String
m_4 =
    "m-4"



{- "m-5" -}


m_5 : String
m_5 =
    "m-5"



{- "m-6" -}


m_6 : String
m_6 =
    "m-6"



{- "m-7" -}


m_7 : String
m_7 =
    "m-7"



{- "m-8" -}


m_8 : String
m_8 =
    "m-8"



{- "m-9" -}


m_9 : String
m_9 =
    "m-9"



{- "m-10" -}


m_10 : String
m_10 =
    "m-10"



{- "m-11" -}


m_11 : String
m_11 =
    "m-11"



{- "m-12" -}


m_12 : String
m_12 =
    "m-12"



{- "m-14" -}


m_14 : String
m_14 =
    "m-14"



{- "m-16" -}


m_16 : String
m_16 =
    "m-16"



{- "m-20" -}


m_20 : String
m_20 =
    "m-20"



{- "m-24" -}


m_24 : String
m_24 =
    "m-24"



{- "m-28" -}


m_28 : String
m_28 =
    "m-28"



{- "m-32" -}


m_32 : String
m_32 =
    "m-32"



{- "m-36" -}


m_36 : String
m_36 =
    "m-36"



{- "m-40" -}


m_40 : String
m_40 =
    "m-40"



{- "m-44" -}


m_44 : String
m_44 =
    "m-44"



{- "m-48" -}


m_48 : String
m_48 =
    "m-48"



{- "m-52" -}


m_52 : String
m_52 =
    "m-52"



{- "m-56" -}


m_56 : String
m_56 =
    "m-56"



{- "m-60" -}


m_60 : String
m_60 =
    "m-60"



{- "m-64" -}


m_64 : String
m_64 =
    "m-64"



{- "m-72" -}


m_72 : String
m_72 =
    "m-72"



{- "m-80" -}


m_80 : String
m_80 =
    "m-80"



{- "m-96" -}


m_96 : String
m_96 =
    "m-96"



{- "m-auto" -}


m_auto : String
m_auto =
    "m-auto"



{- "-m-0" -}


n_m_0 : String
n_m_0 =
    "-m-0"



{- "-m-px" -}


n_m_px : String
n_m_px =
    "-m-px"



{- "-m-0.5" -}


n_m_0_dot_5 : String
n_m_0_dot_5 =
    "-m-0.5"



{- "-m-1" -}


n_m_1 : String
n_m_1 =
    "-m-1"



{- "-m-1.5" -}


n_m_1_dot_5 : String
n_m_1_dot_5 =
    "-m-1.5"



{- "-m-2" -}


n_m_2 : String
n_m_2 =
    "-m-2"



{- "-m-2.5" -}


n_m_2_dot_5 : String
n_m_2_dot_5 =
    "-m-2.5"



{- "-m-3" -}


n_m_3 : String
n_m_3 =
    "-m-3"



{- "-m-3.5" -}


n_m_3_dot_5 : String
n_m_3_dot_5 =
    "-m-3.5"



{- "-m-4" -}


n_m_4 : String
n_m_4 =
    "-m-4"



{- "-m-5" -}


n_m_5 : String
n_m_5 =
    "-m-5"



{- "-m-6" -}


n_m_6 : String
n_m_6 =
    "-m-6"



{- "-m-7" -}


n_m_7 : String
n_m_7 =
    "-m-7"



{- "-m-8" -}


n_m_8 : String
n_m_8 =
    "-m-8"



{- "-m-9" -}


n_m_9 : String
n_m_9 =
    "-m-9"



{- "-m-10" -}


n_m_10 : String
n_m_10 =
    "-m-10"



{- "-m-11" -}


n_m_11 : String
n_m_11 =
    "-m-11"



{- "-m-12" -}


n_m_12 : String
n_m_12 =
    "-m-12"



{- "-m-14" -}


n_m_14 : String
n_m_14 =
    "-m-14"



{- "-m-16" -}


n_m_16 : String
n_m_16 =
    "-m-16"



{- "-m-20" -}


n_m_20 : String
n_m_20 =
    "-m-20"



{- "-m-24" -}


n_m_24 : String
n_m_24 =
    "-m-24"



{- "-m-28" -}


n_m_28 : String
n_m_28 =
    "-m-28"



{- "-m-32" -}


n_m_32 : String
n_m_32 =
    "-m-32"



{- "-m-36" -}


n_m_36 : String
n_m_36 =
    "-m-36"



{- "-m-40" -}


n_m_40 : String
n_m_40 =
    "-m-40"



{- "-m-44" -}


n_m_44 : String
n_m_44 =
    "-m-44"



{- "-m-48" -}


n_m_48 : String
n_m_48 =
    "-m-48"



{- "-m-52" -}


n_m_52 : String
n_m_52 =
    "-m-52"



{- "-m-56" -}


n_m_56 : String
n_m_56 =
    "-m-56"



{- "-m-60" -}


n_m_60 : String
n_m_60 =
    "-m-60"



{- "-m-64" -}


n_m_64 : String
n_m_64 =
    "-m-64"



{- "-m-72" -}


n_m_72 : String
n_m_72 =
    "-m-72"



{- "-m-80" -}


n_m_80 : String
n_m_80 =
    "-m-80"



{- "-m-96" -}


n_m_96 : String
n_m_96 =
    "-m-96"



{- "mx-0" -}


mx_0 : String
mx_0 =
    "mx-0"



{- "mx-px" -}


mx_px : String
mx_px =
    "mx-px"



{- "mx-0.5" -}


mx_0_dot_5 : String
mx_0_dot_5 =
    "mx-0.5"



{- "mx-1" -}


mx_1 : String
mx_1 =
    "mx-1"



{- "mx-1.5" -}


mx_1_dot_5 : String
mx_1_dot_5 =
    "mx-1.5"



{- "mx-2" -}


mx_2 : String
mx_2 =
    "mx-2"



{- "mx-2.5" -}


mx_2_dot_5 : String
mx_2_dot_5 =
    "mx-2.5"



{- "mx-3" -}


mx_3 : String
mx_3 =
    "mx-3"



{- "mx-3.5" -}


mx_3_dot_5 : String
mx_3_dot_5 =
    "mx-3.5"



{- "mx-4" -}


mx_4 : String
mx_4 =
    "mx-4"



{- "mx-5" -}


mx_5 : String
mx_5 =
    "mx-5"



{- "mx-6" -}


mx_6 : String
mx_6 =
    "mx-6"



{- "mx-7" -}


mx_7 : String
mx_7 =
    "mx-7"



{- "mx-8" -}


mx_8 : String
mx_8 =
    "mx-8"



{- "mx-9" -}


mx_9 : String
mx_9 =
    "mx-9"



{- "mx-10" -}


mx_10 : String
mx_10 =
    "mx-10"



{- "mx-11" -}


mx_11 : String
mx_11 =
    "mx-11"



{- "mx-12" -}


mx_12 : String
mx_12 =
    "mx-12"



{- "mx-14" -}


mx_14 : String
mx_14 =
    "mx-14"



{- "mx-16" -}


mx_16 : String
mx_16 =
    "mx-16"



{- "mx-20" -}


mx_20 : String
mx_20 =
    "mx-20"



{- "mx-24" -}


mx_24 : String
mx_24 =
    "mx-24"



{- "mx-28" -}


mx_28 : String
mx_28 =
    "mx-28"



{- "mx-32" -}


mx_32 : String
mx_32 =
    "mx-32"



{- "mx-36" -}


mx_36 : String
mx_36 =
    "mx-36"



{- "mx-40" -}


mx_40 : String
mx_40 =
    "mx-40"



{- "mx-44" -}


mx_44 : String
mx_44 =
    "mx-44"



{- "mx-48" -}


mx_48 : String
mx_48 =
    "mx-48"



{- "mx-52" -}


mx_52 : String
mx_52 =
    "mx-52"



{- "mx-56" -}


mx_56 : String
mx_56 =
    "mx-56"



{- "mx-60" -}


mx_60 : String
mx_60 =
    "mx-60"



{- "mx-64" -}


mx_64 : String
mx_64 =
    "mx-64"



{- "mx-72" -}


mx_72 : String
mx_72 =
    "mx-72"



{- "mx-80" -}


mx_80 : String
mx_80 =
    "mx-80"



{- "mx-96" -}


mx_96 : String
mx_96 =
    "mx-96"



{- "mx-auto" -}


mx_auto : String
mx_auto =
    "mx-auto"



{- "-mx-0" -}


n_mx_0 : String
n_mx_0 =
    "-mx-0"



{- "-mx-px" -}


n_mx_px : String
n_mx_px =
    "-mx-px"



{- "-mx-0.5" -}


n_mx_0_dot_5 : String
n_mx_0_dot_5 =
    "-mx-0.5"



{- "-mx-1" -}


n_mx_1 : String
n_mx_1 =
    "-mx-1"



{- "-mx-1.5" -}


n_mx_1_dot_5 : String
n_mx_1_dot_5 =
    "-mx-1.5"



{- "-mx-2" -}


n_mx_2 : String
n_mx_2 =
    "-mx-2"



{- "-mx-2.5" -}


n_mx_2_dot_5 : String
n_mx_2_dot_5 =
    "-mx-2.5"



{- "-mx-3" -}


n_mx_3 : String
n_mx_3 =
    "-mx-3"



{- "-mx-3.5" -}


n_mx_3_dot_5 : String
n_mx_3_dot_5 =
    "-mx-3.5"



{- "-mx-4" -}


n_mx_4 : String
n_mx_4 =
    "-mx-4"



{- "-mx-5" -}


n_mx_5 : String
n_mx_5 =
    "-mx-5"



{- "-mx-6" -}


n_mx_6 : String
n_mx_6 =
    "-mx-6"



{- "-mx-7" -}


n_mx_7 : String
n_mx_7 =
    "-mx-7"



{- "-mx-8" -}


n_mx_8 : String
n_mx_8 =
    "-mx-8"



{- "-mx-9" -}


n_mx_9 : String
n_mx_9 =
    "-mx-9"



{- "-mx-10" -}


n_mx_10 : String
n_mx_10 =
    "-mx-10"



{- "-mx-11" -}


n_mx_11 : String
n_mx_11 =
    "-mx-11"



{- "-mx-12" -}


n_mx_12 : String
n_mx_12 =
    "-mx-12"



{- "-mx-14" -}


n_mx_14 : String
n_mx_14 =
    "-mx-14"



{- "-mx-16" -}


n_mx_16 : String
n_mx_16 =
    "-mx-16"



{- "-mx-20" -}


n_mx_20 : String
n_mx_20 =
    "-mx-20"



{- "-mx-24" -}


n_mx_24 : String
n_mx_24 =
    "-mx-24"



{- "-mx-28" -}


n_mx_28 : String
n_mx_28 =
    "-mx-28"



{- "-mx-32" -}


n_mx_32 : String
n_mx_32 =
    "-mx-32"



{- "-mx-36" -}


n_mx_36 : String
n_mx_36 =
    "-mx-36"



{- "-mx-40" -}


n_mx_40 : String
n_mx_40 =
    "-mx-40"



{- "-mx-44" -}


n_mx_44 : String
n_mx_44 =
    "-mx-44"



{- "-mx-48" -}


n_mx_48 : String
n_mx_48 =
    "-mx-48"



{- "-mx-52" -}


n_mx_52 : String
n_mx_52 =
    "-mx-52"



{- "-mx-56" -}


n_mx_56 : String
n_mx_56 =
    "-mx-56"



{- "-mx-60" -}


n_mx_60 : String
n_mx_60 =
    "-mx-60"



{- "-mx-64" -}


n_mx_64 : String
n_mx_64 =
    "-mx-64"



{- "-mx-72" -}


n_mx_72 : String
n_mx_72 =
    "-mx-72"



{- "-mx-80" -}


n_mx_80 : String
n_mx_80 =
    "-mx-80"



{- "-mx-96" -}


n_mx_96 : String
n_mx_96 =
    "-mx-96"



{- "my-0" -}


my_0 : String
my_0 =
    "my-0"



{- "my-px" -}


my_px : String
my_px =
    "my-px"



{- "my-0.5" -}


my_0_dot_5 : String
my_0_dot_5 =
    "my-0.5"



{- "my-1" -}


my_1 : String
my_1 =
    "my-1"



{- "my-1.5" -}


my_1_dot_5 : String
my_1_dot_5 =
    "my-1.5"



{- "my-2" -}


my_2 : String
my_2 =
    "my-2"



{- "my-2.5" -}


my_2_dot_5 : String
my_2_dot_5 =
    "my-2.5"



{- "my-3" -}


my_3 : String
my_3 =
    "my-3"



{- "my-3.5" -}


my_3_dot_5 : String
my_3_dot_5 =
    "my-3.5"



{- "my-4" -}


my_4 : String
my_4 =
    "my-4"



{- "my-5" -}


my_5 : String
my_5 =
    "my-5"



{- "my-6" -}


my_6 : String
my_6 =
    "my-6"



{- "my-7" -}


my_7 : String
my_7 =
    "my-7"



{- "my-8" -}


my_8 : String
my_8 =
    "my-8"



{- "my-9" -}


my_9 : String
my_9 =
    "my-9"



{- "my-10" -}


my_10 : String
my_10 =
    "my-10"



{- "my-11" -}


my_11 : String
my_11 =
    "my-11"



{- "my-12" -}


my_12 : String
my_12 =
    "my-12"



{- "my-14" -}


my_14 : String
my_14 =
    "my-14"



{- "my-16" -}


my_16 : String
my_16 =
    "my-16"



{- "my-20" -}


my_20 : String
my_20 =
    "my-20"



{- "my-24" -}


my_24 : String
my_24 =
    "my-24"



{- "my-28" -}


my_28 : String
my_28 =
    "my-28"



{- "my-32" -}


my_32 : String
my_32 =
    "my-32"



{- "my-36" -}


my_36 : String
my_36 =
    "my-36"



{- "my-40" -}


my_40 : String
my_40 =
    "my-40"



{- "my-44" -}


my_44 : String
my_44 =
    "my-44"



{- "my-48" -}


my_48 : String
my_48 =
    "my-48"



{- "my-52" -}


my_52 : String
my_52 =
    "my-52"



{- "my-56" -}


my_56 : String
my_56 =
    "my-56"



{- "my-60" -}


my_60 : String
my_60 =
    "my-60"



{- "my-64" -}


my_64 : String
my_64 =
    "my-64"



{- "my-72" -}


my_72 : String
my_72 =
    "my-72"



{- "my-80" -}


my_80 : String
my_80 =
    "my-80"



{- "my-96" -}


my_96 : String
my_96 =
    "my-96"



{- "my-auto" -}


my_auto : String
my_auto =
    "my-auto"



{- "-my-0" -}


n_my_0 : String
n_my_0 =
    "-my-0"



{- "-my-px" -}


n_my_px : String
n_my_px =
    "-my-px"



{- "-my-0.5" -}


n_my_0_dot_5 : String
n_my_0_dot_5 =
    "-my-0.5"



{- "-my-1" -}


n_my_1 : String
n_my_1 =
    "-my-1"



{- "-my-1.5" -}


n_my_1_dot_5 : String
n_my_1_dot_5 =
    "-my-1.5"



{- "-my-2" -}


n_my_2 : String
n_my_2 =
    "-my-2"



{- "-my-2.5" -}


n_my_2_dot_5 : String
n_my_2_dot_5 =
    "-my-2.5"



{- "-my-3" -}


n_my_3 : String
n_my_3 =
    "-my-3"



{- "-my-3.5" -}


n_my_3_dot_5 : String
n_my_3_dot_5 =
    "-my-3.5"



{- "-my-4" -}


n_my_4 : String
n_my_4 =
    "-my-4"



{- "-my-5" -}


n_my_5 : String
n_my_5 =
    "-my-5"



{- "-my-6" -}


n_my_6 : String
n_my_6 =
    "-my-6"



{- "-my-7" -}


n_my_7 : String
n_my_7 =
    "-my-7"



{- "-my-8" -}


n_my_8 : String
n_my_8 =
    "-my-8"



{- "-my-9" -}


n_my_9 : String
n_my_9 =
    "-my-9"



{- "-my-10" -}


n_my_10 : String
n_my_10 =
    "-my-10"



{- "-my-11" -}


n_my_11 : String
n_my_11 =
    "-my-11"



{- "-my-12" -}


n_my_12 : String
n_my_12 =
    "-my-12"



{- "-my-14" -}


n_my_14 : String
n_my_14 =
    "-my-14"



{- "-my-16" -}


n_my_16 : String
n_my_16 =
    "-my-16"



{- "-my-20" -}


n_my_20 : String
n_my_20 =
    "-my-20"



{- "-my-24" -}


n_my_24 : String
n_my_24 =
    "-my-24"



{- "-my-28" -}


n_my_28 : String
n_my_28 =
    "-my-28"



{- "-my-32" -}


n_my_32 : String
n_my_32 =
    "-my-32"



{- "-my-36" -}


n_my_36 : String
n_my_36 =
    "-my-36"



{- "-my-40" -}


n_my_40 : String
n_my_40 =
    "-my-40"



{- "-my-44" -}


n_my_44 : String
n_my_44 =
    "-my-44"



{- "-my-48" -}


n_my_48 : String
n_my_48 =
    "-my-48"



{- "-my-52" -}


n_my_52 : String
n_my_52 =
    "-my-52"



{- "-my-56" -}


n_my_56 : String
n_my_56 =
    "-my-56"



{- "-my-60" -}


n_my_60 : String
n_my_60 =
    "-my-60"



{- "-my-64" -}


n_my_64 : String
n_my_64 =
    "-my-64"



{- "-my-72" -}


n_my_72 : String
n_my_72 =
    "-my-72"



{- "-my-80" -}


n_my_80 : String
n_my_80 =
    "-my-80"



{- "-my-96" -}


n_my_96 : String
n_my_96 =
    "-my-96"



{- "mt-0" -}


mt_0 : String
mt_0 =
    "mt-0"



{- "mt-px" -}


mt_px : String
mt_px =
    "mt-px"



{- "mt-0.5" -}


mt_0_dot_5 : String
mt_0_dot_5 =
    "mt-0.5"



{- "mt-1" -}


mt_1 : String
mt_1 =
    "mt-1"



{- "mt-1.5" -}


mt_1_dot_5 : String
mt_1_dot_5 =
    "mt-1.5"



{- "mt-2" -}


mt_2 : String
mt_2 =
    "mt-2"



{- "mt-2.5" -}


mt_2_dot_5 : String
mt_2_dot_5 =
    "mt-2.5"



{- "mt-3" -}


mt_3 : String
mt_3 =
    "mt-3"



{- "mt-3.5" -}


mt_3_dot_5 : String
mt_3_dot_5 =
    "mt-3.5"



{- "mt-4" -}


mt_4 : String
mt_4 =
    "mt-4"



{- "mt-5" -}


mt_5 : String
mt_5 =
    "mt-5"



{- "mt-6" -}


mt_6 : String
mt_6 =
    "mt-6"



{- "mt-7" -}


mt_7 : String
mt_7 =
    "mt-7"



{- "mt-8" -}


mt_8 : String
mt_8 =
    "mt-8"



{- "mt-9" -}


mt_9 : String
mt_9 =
    "mt-9"



{- "mt-10" -}


mt_10 : String
mt_10 =
    "mt-10"



{- "mt-11" -}


mt_11 : String
mt_11 =
    "mt-11"



{- "mt-12" -}


mt_12 : String
mt_12 =
    "mt-12"



{- "mt-14" -}


mt_14 : String
mt_14 =
    "mt-14"



{- "mt-16" -}


mt_16 : String
mt_16 =
    "mt-16"



{- "mt-20" -}


mt_20 : String
mt_20 =
    "mt-20"



{- "mt-24" -}


mt_24 : String
mt_24 =
    "mt-24"



{- "mt-28" -}


mt_28 : String
mt_28 =
    "mt-28"



{- "mt-32" -}


mt_32 : String
mt_32 =
    "mt-32"



{- "mt-36" -}


mt_36 : String
mt_36 =
    "mt-36"



{- "mt-40" -}


mt_40 : String
mt_40 =
    "mt-40"



{- "mt-44" -}


mt_44 : String
mt_44 =
    "mt-44"



{- "mt-48" -}


mt_48 : String
mt_48 =
    "mt-48"



{- "mt-52" -}


mt_52 : String
mt_52 =
    "mt-52"



{- "mt-56" -}


mt_56 : String
mt_56 =
    "mt-56"



{- "mt-60" -}


mt_60 : String
mt_60 =
    "mt-60"



{- "mt-64" -}


mt_64 : String
mt_64 =
    "mt-64"



{- "mt-72" -}


mt_72 : String
mt_72 =
    "mt-72"



{- "mt-80" -}


mt_80 : String
mt_80 =
    "mt-80"



{- "mt-96" -}


mt_96 : String
mt_96 =
    "mt-96"



{- "mt-auto" -}


mt_auto : String
mt_auto =
    "mt-auto"



{- "-mt-0" -}


n_mt_0 : String
n_mt_0 =
    "-mt-0"



{- "-mt-px" -}


n_mt_px : String
n_mt_px =
    "-mt-px"



{- "-mt-0.5" -}


n_mt_0_dot_5 : String
n_mt_0_dot_5 =
    "-mt-0.5"



{- "-mt-1" -}


n_mt_1 : String
n_mt_1 =
    "-mt-1"



{- "-mt-1.5" -}


n_mt_1_dot_5 : String
n_mt_1_dot_5 =
    "-mt-1.5"



{- "-mt-2" -}


n_mt_2 : String
n_mt_2 =
    "-mt-2"



{- "-mt-2.5" -}


n_mt_2_dot_5 : String
n_mt_2_dot_5 =
    "-mt-2.5"



{- "-mt-3" -}


n_mt_3 : String
n_mt_3 =
    "-mt-3"



{- "-mt-3.5" -}


n_mt_3_dot_5 : String
n_mt_3_dot_5 =
    "-mt-3.5"



{- "-mt-4" -}


n_mt_4 : String
n_mt_4 =
    "-mt-4"



{- "-mt-5" -}


n_mt_5 : String
n_mt_5 =
    "-mt-5"



{- "-mt-6" -}


n_mt_6 : String
n_mt_6 =
    "-mt-6"



{- "-mt-7" -}


n_mt_7 : String
n_mt_7 =
    "-mt-7"



{- "-mt-8" -}


n_mt_8 : String
n_mt_8 =
    "-mt-8"



{- "-mt-9" -}


n_mt_9 : String
n_mt_9 =
    "-mt-9"



{- "-mt-10" -}


n_mt_10 : String
n_mt_10 =
    "-mt-10"



{- "-mt-11" -}


n_mt_11 : String
n_mt_11 =
    "-mt-11"



{- "-mt-12" -}


n_mt_12 : String
n_mt_12 =
    "-mt-12"



{- "-mt-14" -}


n_mt_14 : String
n_mt_14 =
    "-mt-14"



{- "-mt-16" -}


n_mt_16 : String
n_mt_16 =
    "-mt-16"



{- "-mt-20" -}


n_mt_20 : String
n_mt_20 =
    "-mt-20"



{- "-mt-24" -}


n_mt_24 : String
n_mt_24 =
    "-mt-24"



{- "-mt-28" -}


n_mt_28 : String
n_mt_28 =
    "-mt-28"



{- "-mt-32" -}


n_mt_32 : String
n_mt_32 =
    "-mt-32"



{- "-mt-36" -}


n_mt_36 : String
n_mt_36 =
    "-mt-36"



{- "-mt-40" -}


n_mt_40 : String
n_mt_40 =
    "-mt-40"



{- "-mt-44" -}


n_mt_44 : String
n_mt_44 =
    "-mt-44"



{- "-mt-48" -}


n_mt_48 : String
n_mt_48 =
    "-mt-48"



{- "-mt-52" -}


n_mt_52 : String
n_mt_52 =
    "-mt-52"



{- "-mt-56" -}


n_mt_56 : String
n_mt_56 =
    "-mt-56"



{- "-mt-60" -}


n_mt_60 : String
n_mt_60 =
    "-mt-60"



{- "-mt-64" -}


n_mt_64 : String
n_mt_64 =
    "-mt-64"



{- "-mt-72" -}


n_mt_72 : String
n_mt_72 =
    "-mt-72"



{- "-mt-80" -}


n_mt_80 : String
n_mt_80 =
    "-mt-80"



{- "-mt-96" -}


n_mt_96 : String
n_mt_96 =
    "-mt-96"



{- "mr-0" -}


mr_0 : String
mr_0 =
    "mr-0"



{- "mr-px" -}


mr_px : String
mr_px =
    "mr-px"



{- "mr-0.5" -}


mr_0_dot_5 : String
mr_0_dot_5 =
    "mr-0.5"



{- "mr-1" -}


mr_1 : String
mr_1 =
    "mr-1"



{- "mr-1.5" -}


mr_1_dot_5 : String
mr_1_dot_5 =
    "mr-1.5"



{- "mr-2" -}


mr_2 : String
mr_2 =
    "mr-2"



{- "mr-2.5" -}


mr_2_dot_5 : String
mr_2_dot_5 =
    "mr-2.5"



{- "mr-3" -}


mr_3 : String
mr_3 =
    "mr-3"



{- "mr-3.5" -}


mr_3_dot_5 : String
mr_3_dot_5 =
    "mr-3.5"



{- "mr-4" -}


mr_4 : String
mr_4 =
    "mr-4"



{- "mr-5" -}


mr_5 : String
mr_5 =
    "mr-5"



{- "mr-6" -}


mr_6 : String
mr_6 =
    "mr-6"



{- "mr-7" -}


mr_7 : String
mr_7 =
    "mr-7"



{- "mr-8" -}


mr_8 : String
mr_8 =
    "mr-8"



{- "mr-9" -}


mr_9 : String
mr_9 =
    "mr-9"



{- "mr-10" -}


mr_10 : String
mr_10 =
    "mr-10"



{- "mr-11" -}


mr_11 : String
mr_11 =
    "mr-11"



{- "mr-12" -}


mr_12 : String
mr_12 =
    "mr-12"



{- "mr-14" -}


mr_14 : String
mr_14 =
    "mr-14"



{- "mr-16" -}


mr_16 : String
mr_16 =
    "mr-16"



{- "mr-20" -}


mr_20 : String
mr_20 =
    "mr-20"



{- "mr-24" -}


mr_24 : String
mr_24 =
    "mr-24"



{- "mr-28" -}


mr_28 : String
mr_28 =
    "mr-28"



{- "mr-32" -}


mr_32 : String
mr_32 =
    "mr-32"



{- "mr-36" -}


mr_36 : String
mr_36 =
    "mr-36"



{- "mr-40" -}


mr_40 : String
mr_40 =
    "mr-40"



{- "mr-44" -}


mr_44 : String
mr_44 =
    "mr-44"



{- "mr-48" -}


mr_48 : String
mr_48 =
    "mr-48"



{- "mr-52" -}


mr_52 : String
mr_52 =
    "mr-52"



{- "mr-56" -}


mr_56 : String
mr_56 =
    "mr-56"



{- "mr-60" -}


mr_60 : String
mr_60 =
    "mr-60"



{- "mr-64" -}


mr_64 : String
mr_64 =
    "mr-64"



{- "mr-72" -}


mr_72 : String
mr_72 =
    "mr-72"



{- "mr-80" -}


mr_80 : String
mr_80 =
    "mr-80"



{- "mr-96" -}


mr_96 : String
mr_96 =
    "mr-96"



{- "mr-auto" -}


mr_auto : String
mr_auto =
    "mr-auto"



{- "-mr-0" -}


n_mr_0 : String
n_mr_0 =
    "-mr-0"



{- "-mr-px" -}


n_mr_px : String
n_mr_px =
    "-mr-px"



{- "-mr-0.5" -}


n_mr_0_dot_5 : String
n_mr_0_dot_5 =
    "-mr-0.5"



{- "-mr-1" -}


n_mr_1 : String
n_mr_1 =
    "-mr-1"



{- "-mr-1.5" -}


n_mr_1_dot_5 : String
n_mr_1_dot_5 =
    "-mr-1.5"



{- "-mr-2" -}


n_mr_2 : String
n_mr_2 =
    "-mr-2"



{- "-mr-2.5" -}


n_mr_2_dot_5 : String
n_mr_2_dot_5 =
    "-mr-2.5"



{- "-mr-3" -}


n_mr_3 : String
n_mr_3 =
    "-mr-3"



{- "-mr-3.5" -}


n_mr_3_dot_5 : String
n_mr_3_dot_5 =
    "-mr-3.5"



{- "-mr-4" -}


n_mr_4 : String
n_mr_4 =
    "-mr-4"



{- "-mr-5" -}


n_mr_5 : String
n_mr_5 =
    "-mr-5"



{- "-mr-6" -}


n_mr_6 : String
n_mr_6 =
    "-mr-6"



{- "-mr-7" -}


n_mr_7 : String
n_mr_7 =
    "-mr-7"



{- "-mr-8" -}


n_mr_8 : String
n_mr_8 =
    "-mr-8"



{- "-mr-9" -}


n_mr_9 : String
n_mr_9 =
    "-mr-9"



{- "-mr-10" -}


n_mr_10 : String
n_mr_10 =
    "-mr-10"



{- "-mr-11" -}


n_mr_11 : String
n_mr_11 =
    "-mr-11"



{- "-mr-12" -}


n_mr_12 : String
n_mr_12 =
    "-mr-12"



{- "-mr-14" -}


n_mr_14 : String
n_mr_14 =
    "-mr-14"



{- "-mr-16" -}


n_mr_16 : String
n_mr_16 =
    "-mr-16"



{- "-mr-20" -}


n_mr_20 : String
n_mr_20 =
    "-mr-20"



{- "-mr-24" -}


n_mr_24 : String
n_mr_24 =
    "-mr-24"



{- "-mr-28" -}


n_mr_28 : String
n_mr_28 =
    "-mr-28"



{- "-mr-32" -}


n_mr_32 : String
n_mr_32 =
    "-mr-32"



{- "-mr-36" -}


n_mr_36 : String
n_mr_36 =
    "-mr-36"



{- "-mr-40" -}


n_mr_40 : String
n_mr_40 =
    "-mr-40"



{- "-mr-44" -}


n_mr_44 : String
n_mr_44 =
    "-mr-44"



{- "-mr-48" -}


n_mr_48 : String
n_mr_48 =
    "-mr-48"



{- "-mr-52" -}


n_mr_52 : String
n_mr_52 =
    "-mr-52"



{- "-mr-56" -}


n_mr_56 : String
n_mr_56 =
    "-mr-56"



{- "-mr-60" -}


n_mr_60 : String
n_mr_60 =
    "-mr-60"



{- "-mr-64" -}


n_mr_64 : String
n_mr_64 =
    "-mr-64"



{- "-mr-72" -}


n_mr_72 : String
n_mr_72 =
    "-mr-72"



{- "-mr-80" -}


n_mr_80 : String
n_mr_80 =
    "-mr-80"



{- "-mr-96" -}


n_mr_96 : String
n_mr_96 =
    "-mr-96"



{- "mb-0" -}


mb_0 : String
mb_0 =
    "mb-0"



{- "mb-px" -}


mb_px : String
mb_px =
    "mb-px"



{- "mb-0.5" -}


mb_0_dot_5 : String
mb_0_dot_5 =
    "mb-0.5"



{- "mb-1" -}


mb_1 : String
mb_1 =
    "mb-1"



{- "mb-1.5" -}


mb_1_dot_5 : String
mb_1_dot_5 =
    "mb-1.5"



{- "mb-2" -}


mb_2 : String
mb_2 =
    "mb-2"



{- "mb-2.5" -}


mb_2_dot_5 : String
mb_2_dot_5 =
    "mb-2.5"



{- "mb-3" -}


mb_3 : String
mb_3 =
    "mb-3"



{- "mb-3.5" -}


mb_3_dot_5 : String
mb_3_dot_5 =
    "mb-3.5"



{- "mb-4" -}


mb_4 : String
mb_4 =
    "mb-4"



{- "mb-5" -}


mb_5 : String
mb_5 =
    "mb-5"



{- "mb-6" -}


mb_6 : String
mb_6 =
    "mb-6"



{- "mb-7" -}


mb_7 : String
mb_7 =
    "mb-7"



{- "mb-8" -}


mb_8 : String
mb_8 =
    "mb-8"



{- "mb-9" -}


mb_9 : String
mb_9 =
    "mb-9"



{- "mb-10" -}


mb_10 : String
mb_10 =
    "mb-10"



{- "mb-11" -}


mb_11 : String
mb_11 =
    "mb-11"



{- "mb-12" -}


mb_12 : String
mb_12 =
    "mb-12"



{- "mb-14" -}


mb_14 : String
mb_14 =
    "mb-14"



{- "mb-16" -}


mb_16 : String
mb_16 =
    "mb-16"



{- "mb-20" -}


mb_20 : String
mb_20 =
    "mb-20"



{- "mb-24" -}


mb_24 : String
mb_24 =
    "mb-24"



{- "mb-28" -}


mb_28 : String
mb_28 =
    "mb-28"



{- "mb-32" -}


mb_32 : String
mb_32 =
    "mb-32"



{- "mb-36" -}


mb_36 : String
mb_36 =
    "mb-36"



{- "mb-40" -}


mb_40 : String
mb_40 =
    "mb-40"



{- "mb-44" -}


mb_44 : String
mb_44 =
    "mb-44"



{- "mb-48" -}


mb_48 : String
mb_48 =
    "mb-48"



{- "mb-52" -}


mb_52 : String
mb_52 =
    "mb-52"



{- "mb-56" -}


mb_56 : String
mb_56 =
    "mb-56"



{- "mb-60" -}


mb_60 : String
mb_60 =
    "mb-60"



{- "mb-64" -}


mb_64 : String
mb_64 =
    "mb-64"



{- "mb-72" -}


mb_72 : String
mb_72 =
    "mb-72"



{- "mb-80" -}


mb_80 : String
mb_80 =
    "mb-80"



{- "mb-96" -}


mb_96 : String
mb_96 =
    "mb-96"



{- "mb-auto" -}


mb_auto : String
mb_auto =
    "mb-auto"



{- "-mb-0" -}


n_mb_0 : String
n_mb_0 =
    "-mb-0"



{- "-mb-px" -}


n_mb_px : String
n_mb_px =
    "-mb-px"



{- "-mb-0.5" -}


n_mb_0_dot_5 : String
n_mb_0_dot_5 =
    "-mb-0.5"



{- "-mb-1" -}


n_mb_1 : String
n_mb_1 =
    "-mb-1"



{- "-mb-1.5" -}


n_mb_1_dot_5 : String
n_mb_1_dot_5 =
    "-mb-1.5"



{- "-mb-2" -}


n_mb_2 : String
n_mb_2 =
    "-mb-2"



{- "-mb-2.5" -}


n_mb_2_dot_5 : String
n_mb_2_dot_5 =
    "-mb-2.5"



{- "-mb-3" -}


n_mb_3 : String
n_mb_3 =
    "-mb-3"



{- "-mb-3.5" -}


n_mb_3_dot_5 : String
n_mb_3_dot_5 =
    "-mb-3.5"



{- "-mb-4" -}


n_mb_4 : String
n_mb_4 =
    "-mb-4"



{- "-mb-5" -}


n_mb_5 : String
n_mb_5 =
    "-mb-5"



{- "-mb-6" -}


n_mb_6 : String
n_mb_6 =
    "-mb-6"



{- "-mb-7" -}


n_mb_7 : String
n_mb_7 =
    "-mb-7"



{- "-mb-8" -}


n_mb_8 : String
n_mb_8 =
    "-mb-8"



{- "-mb-9" -}


n_mb_9 : String
n_mb_9 =
    "-mb-9"



{- "-mb-10" -}


n_mb_10 : String
n_mb_10 =
    "-mb-10"



{- "-mb-11" -}


n_mb_11 : String
n_mb_11 =
    "-mb-11"



{- "-mb-12" -}


n_mb_12 : String
n_mb_12 =
    "-mb-12"



{- "-mb-14" -}


n_mb_14 : String
n_mb_14 =
    "-mb-14"



{- "-mb-16" -}


n_mb_16 : String
n_mb_16 =
    "-mb-16"



{- "-mb-20" -}


n_mb_20 : String
n_mb_20 =
    "-mb-20"



{- "-mb-24" -}


n_mb_24 : String
n_mb_24 =
    "-mb-24"



{- "-mb-28" -}


n_mb_28 : String
n_mb_28 =
    "-mb-28"



{- "-mb-32" -}


n_mb_32 : String
n_mb_32 =
    "-mb-32"



{- "-mb-36" -}


n_mb_36 : String
n_mb_36 =
    "-mb-36"



{- "-mb-40" -}


n_mb_40 : String
n_mb_40 =
    "-mb-40"



{- "-mb-44" -}


n_mb_44 : String
n_mb_44 =
    "-mb-44"



{- "-mb-48" -}


n_mb_48 : String
n_mb_48 =
    "-mb-48"



{- "-mb-52" -}


n_mb_52 : String
n_mb_52 =
    "-mb-52"



{- "-mb-56" -}


n_mb_56 : String
n_mb_56 =
    "-mb-56"



{- "-mb-60" -}


n_mb_60 : String
n_mb_60 =
    "-mb-60"



{- "-mb-64" -}


n_mb_64 : String
n_mb_64 =
    "-mb-64"



{- "-mb-72" -}


n_mb_72 : String
n_mb_72 =
    "-mb-72"



{- "-mb-80" -}


n_mb_80 : String
n_mb_80 =
    "-mb-80"



{- "-mb-96" -}


n_mb_96 : String
n_mb_96 =
    "-mb-96"



{- "ml-0" -}


ml_0 : String
ml_0 =
    "ml-0"



{- "ml-px" -}


ml_px : String
ml_px =
    "ml-px"



{- "ml-0.5" -}


ml_0_dot_5 : String
ml_0_dot_5 =
    "ml-0.5"



{- "ml-1" -}


ml_1 : String
ml_1 =
    "ml-1"



{- "ml-1.5" -}


ml_1_dot_5 : String
ml_1_dot_5 =
    "ml-1.5"



{- "ml-2" -}


ml_2 : String
ml_2 =
    "ml-2"



{- "ml-2.5" -}


ml_2_dot_5 : String
ml_2_dot_5 =
    "ml-2.5"



{- "ml-3" -}


ml_3 : String
ml_3 =
    "ml-3"



{- "ml-3.5" -}


ml_3_dot_5 : String
ml_3_dot_5 =
    "ml-3.5"



{- "ml-4" -}


ml_4 : String
ml_4 =
    "ml-4"



{- "ml-5" -}


ml_5 : String
ml_5 =
    "ml-5"



{- "ml-6" -}


ml_6 : String
ml_6 =
    "ml-6"



{- "ml-7" -}


ml_7 : String
ml_7 =
    "ml-7"



{- "ml-8" -}


ml_8 : String
ml_8 =
    "ml-8"



{- "ml-9" -}


ml_9 : String
ml_9 =
    "ml-9"



{- "ml-10" -}


ml_10 : String
ml_10 =
    "ml-10"



{- "ml-11" -}


ml_11 : String
ml_11 =
    "ml-11"



{- "ml-12" -}


ml_12 : String
ml_12 =
    "ml-12"



{- "ml-14" -}


ml_14 : String
ml_14 =
    "ml-14"



{- "ml-16" -}


ml_16 : String
ml_16 =
    "ml-16"



{- "ml-20" -}


ml_20 : String
ml_20 =
    "ml-20"



{- "ml-24" -}


ml_24 : String
ml_24 =
    "ml-24"



{- "ml-28" -}


ml_28 : String
ml_28 =
    "ml-28"



{- "ml-32" -}


ml_32 : String
ml_32 =
    "ml-32"



{- "ml-36" -}


ml_36 : String
ml_36 =
    "ml-36"



{- "ml-40" -}


ml_40 : String
ml_40 =
    "ml-40"



{- "ml-44" -}


ml_44 : String
ml_44 =
    "ml-44"



{- "ml-48" -}


ml_48 : String
ml_48 =
    "ml-48"



{- "ml-52" -}


ml_52 : String
ml_52 =
    "ml-52"



{- "ml-56" -}


ml_56 : String
ml_56 =
    "ml-56"



{- "ml-60" -}


ml_60 : String
ml_60 =
    "ml-60"



{- "ml-64" -}


ml_64 : String
ml_64 =
    "ml-64"



{- "ml-72" -}


ml_72 : String
ml_72 =
    "ml-72"



{- "ml-80" -}


ml_80 : String
ml_80 =
    "ml-80"



{- "ml-96" -}


ml_96 : String
ml_96 =
    "ml-96"



{- "ml-auto" -}


ml_auto : String
ml_auto =
    "ml-auto"



{- "-ml-0" -}


n_ml_0 : String
n_ml_0 =
    "-ml-0"



{- "-ml-px" -}


n_ml_px : String
n_ml_px =
    "-ml-px"



{- "-ml-0.5" -}


n_ml_0_dot_5 : String
n_ml_0_dot_5 =
    "-ml-0.5"



{- "-ml-1" -}


n_ml_1 : String
n_ml_1 =
    "-ml-1"



{- "-ml-1.5" -}


n_ml_1_dot_5 : String
n_ml_1_dot_5 =
    "-ml-1.5"



{- "-ml-2" -}


n_ml_2 : String
n_ml_2 =
    "-ml-2"



{- "-ml-2.5" -}


n_ml_2_dot_5 : String
n_ml_2_dot_5 =
    "-ml-2.5"



{- "-ml-3" -}


n_ml_3 : String
n_ml_3 =
    "-ml-3"



{- "-ml-3.5" -}


n_ml_3_dot_5 : String
n_ml_3_dot_5 =
    "-ml-3.5"



{- "-ml-4" -}


n_ml_4 : String
n_ml_4 =
    "-ml-4"



{- "-ml-5" -}


n_ml_5 : String
n_ml_5 =
    "-ml-5"



{- "-ml-6" -}


n_ml_6 : String
n_ml_6 =
    "-ml-6"



{- "-ml-7" -}


n_ml_7 : String
n_ml_7 =
    "-ml-7"



{- "-ml-8" -}


n_ml_8 : String
n_ml_8 =
    "-ml-8"



{- "-ml-9" -}


n_ml_9 : String
n_ml_9 =
    "-ml-9"



{- "-ml-10" -}


n_ml_10 : String
n_ml_10 =
    "-ml-10"



{- "-ml-11" -}


n_ml_11 : String
n_ml_11 =
    "-ml-11"



{- "-ml-12" -}


n_ml_12 : String
n_ml_12 =
    "-ml-12"



{- "-ml-14" -}


n_ml_14 : String
n_ml_14 =
    "-ml-14"



{- "-ml-16" -}


n_ml_16 : String
n_ml_16 =
    "-ml-16"



{- "-ml-20" -}


n_ml_20 : String
n_ml_20 =
    "-ml-20"



{- "-ml-24" -}


n_ml_24 : String
n_ml_24 =
    "-ml-24"



{- "-ml-28" -}


n_ml_28 : String
n_ml_28 =
    "-ml-28"



{- "-ml-32" -}


n_ml_32 : String
n_ml_32 =
    "-ml-32"



{- "-ml-36" -}


n_ml_36 : String
n_ml_36 =
    "-ml-36"



{- "-ml-40" -}


n_ml_40 : String
n_ml_40 =
    "-ml-40"



{- "-ml-44" -}


n_ml_44 : String
n_ml_44 =
    "-ml-44"



{- "-ml-48" -}


n_ml_48 : String
n_ml_48 =
    "-ml-48"



{- "-ml-52" -}


n_ml_52 : String
n_ml_52 =
    "-ml-52"



{- "-ml-56" -}


n_ml_56 : String
n_ml_56 =
    "-ml-56"



{- "-ml-60" -}


n_ml_60 : String
n_ml_60 =
    "-ml-60"



{- "-ml-64" -}


n_ml_64 : String
n_ml_64 =
    "-ml-64"



{- "-ml-72" -}


n_ml_72 : String
n_ml_72 =
    "-ml-72"



{- "-ml-80" -}


n_ml_80 : String
n_ml_80 =
    "-ml-80"



{- "-ml-96" -}


n_ml_96 : String
n_ml_96 =
    "-ml-96"



-- Font Size (https://tailwindcss.com/docs/font-size)
{- "text-xs" -}


text_xs : String
text_xs =
    "text-xs"



{- "text-sm" -}


text_sm : String
text_sm =
    "text-sm"



{- "text-base" -}


text_base : String
text_base =
    "text-base"



{- "text-lg" -}


text_lg : String
text_lg =
    "text-lg"



{- "text-xl" -}


text_xl : String
text_xl =
    "text-xl"



{- "text-2xl" -}


text_2xl : String
text_2xl =
    "text-2xl"



{- "text-3xl" -}


text_3xl : String
text_3xl =
    "text-3xl"



{- "text-4xl" -}


text_4xl : String
text_4xl =
    "text-4xl"



{- "text-5xl" -}


text_5xl : String
text_5xl =
    "text-5xl"



{- "text-6xl" -}


text_6xl : String
text_6xl =
    "text-6xl"



{- "text-7xl" -}


text_7xl : String
text_7xl =
    "text-7xl"



{- "text-8xl" -}


text_8xl : String
text_8xl =
    "text-8xl"



{- "text-9xl" -}


text_9xl : String
text_9xl =
    "text-9xl"



-- Font Weight (https://tailwindcss.com/docs/font-weight)
{- "font-thin" -}


font_thin : String
font_thin =
    "font-thin"



{- "font-extralight" -}


font_extralight : String
font_extralight =
    "font-extralight"



{- "font-light" -}


font_light : String
font_light =
    "font-light"



{- "font-normal" -}


font_normal : String
font_normal =
    "font-normal"



{- "font-medium" -}


font_medium : String
font_medium =
    "font-medium"



{- "font-semibold" -}


font_semibold : String
font_semibold =
    "font-semibold"



{- "font-bold" -}


font_bold : String
font_bold =
    "font-bold"



{- "font-extrabold" -}


font_extrabold : String
font_extrabold =
    "font-extrabold"



{- "ont-black" -}


font_black : String
font_black =
    "font-black"



-- Gap (https://tailwindcss.com/docs/gap)
{- "gap-0" -}


gap_0 : String
gap_0 =
    "gap-0"



{- "gap-x-0" -}


gap_x_0 : String
gap_x_0 =
    "gap-x-0"



{- "gap-y-0" -}


gap_y_0 : String
gap_y_0 =
    "gap-y-0"



{- "gap-px" -}


gap_px : String
gap_px =
    "gap-px"



{- "gap-x-px" -}


gap_x_px : String
gap_x_px =
    "gap-x-px"



{- "gap-y-px" -}


gap_y_px : String
gap_y_px =
    "gap-y-px"



{- "gap-0.5" -}


gap_0_dot_5 : String
gap_0_dot_5 =
    "gap-0.5"



{- "gap-x-0.5" -}


gap_x_0_dot_5 : String
gap_x_0_dot_5 =
    "gap-x-0.5"



{- "gap-y-0.5" -}


gap_y_0_dot_5 : String
gap_y_0_dot_5 =
    "gap-y-0.5"



{- "gap-1" -}


gap_1 : String
gap_1 =
    "gap-1"



{- "gap-x-1" -}


gap_x_1 : String
gap_x_1 =
    "gap-x-1"



{- "gap-y-1" -}


gap_y_1 : String
gap_y_1 =
    "gap-y-1"



{- "gap-1.5" -}


gap_1_dot_5 : String
gap_1_dot_5 =
    "gap-1.5"



{- "gap-x-1.5" -}


gap_x_1_dot_5 : String
gap_x_1_dot_5 =
    "gap-x-1.5"



{- "gap-y-1.5" -}


gap_y_1_dot_5 : String
gap_y_1_dot_5 =
    "gap-y-1.5"



{- "gap-2" -}


gap_2 : String
gap_2 =
    "gap-2"



{- "gap-x-2" -}


gap_x_2 : String
gap_x_2 =
    "gap-x-2"



{- "gap-y-2" -}


gap_y_2 : String
gap_y_2 =
    "gap-y-2"



{- "gap-2.5" -}


gap_2_dot_5 : String
gap_2_dot_5 =
    "gap-2.5"



{- "gap-x-2.5" -}


gap_x_2_dot_5 : String
gap_x_2_dot_5 =
    "gap-x-2.5"



{- "gap-y-2.5" -}


gap_y_2_dot_5 : String
gap_y_2_dot_5 =
    "gap-y-2.5"



{- "gap-3" -}


gap_3 : String
gap_3 =
    "gap-3"



{- "gap-x-3" -}


gap_x_3 : String
gap_x_3 =
    "gap-x-3"



{- "gap-y-3" -}


gap_y_3 : String
gap_y_3 =
    "gap-y-3"



{- "gap-3.5" -}


gap_3_dot_5 : String
gap_3_dot_5 =
    "gap-3.5"



{- "gap-x-3.5" -}


gap_x_3_dot_5 : String
gap_x_3_dot_5 =
    "gap-x-3.5"



{- "gap-y-3.5" -}


gap_y_3_dot_5 : String
gap_y_3_dot_5 =
    "gap-y-3.5"



{- "gap-4" -}


gap_4 : String
gap_4 =
    "gap-4"



{- "gap-x-4" -}


gap_x_4 : String
gap_x_4 =
    "gap-x-4"



{- "gap-y-4" -}


gap_y_4 : String
gap_y_4 =
    "gap-y-4"



{- "gap-5" -}


gap_5 : String
gap_5 =
    "gap-5"



{- "gap-x-5" -}


gap_x_5 : String
gap_x_5 =
    "gap-x-5"



{- "gap-y-5" -}


gap_y_5 : String
gap_y_5 =
    "gap-y-5"



{- "gap-6" -}


gap_6 : String
gap_6 =
    "gap-6"



{- "gap-x-6" -}


gap_x_6 : String
gap_x_6 =
    "gap-x-6"



{- "gap-y-6" -}


gap_y_6 : String
gap_y_6 =
    "gap-y-6"



{- "gap-7" -}


gap_7 : String
gap_7 =
    "gap-7"



{- "gap-x-7" -}


gap_x_7 : String
gap_x_7 =
    "gap-x-7"



{- "gap-y-7" -}


gap_y_7 : String
gap_y_7 =
    "gap-y-7"



{- "gap-8" -}


gap_8 : String
gap_8 =
    "gap-8"



{- "gap-x-8" -}


gap_x_8 : String
gap_x_8 =
    "gap-x-8"



{- "gap-y-8" -}


gap_y_8 : String
gap_y_8 =
    "gap-y-8"



{- "gap-9" -}


gap_9 : String
gap_9 =
    "gap-9"



{- "gap-x-9" -}


gap_x_9 : String
gap_x_9 =
    "gap-x-9"



{- "gap-y-9" -}


gap_y_9 : String
gap_y_9 =
    "gap-y-9"



{- "gap-10" -}


gap_10 : String
gap_10 =
    "gap-10"



{- "gap-x-10" -}


gap_x_10 : String
gap_x_10 =
    "gap-x-10"



{- "gap-y-10" -}


gap_y_10 : String
gap_y_10 =
    "gap-y-10"



{- "gap-11" -}


gap_11 : String
gap_11 =
    "gap-11"



{- "gap-x-11" -}


gap_x_11 : String
gap_x_11 =
    "gap-x-11"



{- "gap-y-11" -}


gap_y_11 : String
gap_y_11 =
    "gap-y-11"



{- "gap-12" -}


gap_12 : String
gap_12 =
    "gap-12"



{- "gap-x-12" -}


gap_x_12 : String
gap_x_12 =
    "gap-x-12"



{- "gap-y-12" -}


gap_y_12 : String
gap_y_12 =
    "gap-y-12"



{- "gap-14" -}


gap_14 : String
gap_14 =
    "gap-14"



{- "gap-x-14" -}


gap_x_14 : String
gap_x_14 =
    "gap-x-14"



{- "gap-y-14" -}


gap_y_14 : String
gap_y_14 =
    "gap-y-14"



{- "gap-16" -}


gap_16 : String
gap_16 =
    "gap-16"



{- "gap-x-16" -}


gap_x_16 : String
gap_x_16 =
    "gap-x-16"



{- "gap-y-16" -}


gap_y_16 : String
gap_y_16 =
    "gap-y-16"



{- "gap-20" -}


gap_20 : String
gap_20 =
    "gap-20"



{- "gap-x-20" -}


gap_x_20 : String
gap_x_20 =
    "gap-x-20"



{- "gap-y-20" -}


gap_y_20 : String
gap_y_20 =
    "gap-y-20"



{- "gap-24" -}


gap_24 : String
gap_24 =
    "gap-24"



{- "gap-x-24" -}


gap_x_24 : String
gap_x_24 =
    "gap-x-24"



{- "gap-y-24" -}


gap_y_24 : String
gap_y_24 =
    "gap-y-24"



{- "gap-28" -}


gap_28 : String
gap_28 =
    "gap-28"



{- "gap-x-28" -}


gap_x_28 : String
gap_x_28 =
    "gap-x-28"



{- "gap-y-28" -}


gap_y_28 : String
gap_y_28 =
    "gap-y-28"



{- "gap-32" -}


gap_32 : String
gap_32 =
    "gap-32"



{- "gap-x-32" -}


gap_x_32 : String
gap_x_32 =
    "gap-x-32"



{- "gap-y-32" -}


gap_y_32 : String
gap_y_32 =
    "gap-y-32"



{- "gap-36" -}


gap_36 : String
gap_36 =
    "gap-36"



{- "gap-x-36" -}


gap_x_36 : String
gap_x_36 =
    "gap-x-36"



{- "gap-y-36" -}


gap_y_36 : String
gap_y_36 =
    "gap-y-36"



{- "gap-40" -}


gap_40 : String
gap_40 =
    "gap-40"



{- "gap-x-40" -}


gap_x_40 : String
gap_x_40 =
    "gap-x-40"



{- "gap-y-40" -}


gap_y_40 : String
gap_y_40 =
    "gap-y-40"



{- "gap-44" -}


gap_44 : String
gap_44 =
    "gap-44"



{- "gap-x-44" -}


gap_x_44 : String
gap_x_44 =
    "gap-x-44"



{- "gap-y-44" -}


gap_y_44 : String
gap_y_44 =
    "gap-y-44"



{- "gap-48" -}


gap_48 : String
gap_48 =
    "gap-48"



{- "gap-x-48" -}


gap_x_48 : String
gap_x_48 =
    "gap-x-48"



{- "gap-y-48" -}


gap_y_48 : String
gap_y_48 =
    "gap-y-48"



{- "gap-52" -}


gap_52 : String
gap_52 =
    "gap-52"



{- "gap-x-52" -}


gap_x_52 : String
gap_x_52 =
    "gap-x-52"



{- "gap-y-52" -}


gap_y_52 : String
gap_y_52 =
    "gap-y-52"



{- "gap-56" -}


gap_56 : String
gap_56 =
    "gap-56"



{- "gap-x-56" -}


gap_x_56 : String
gap_x_56 =
    "gap-x-56"



{- "gap-y-56" -}


gap_y_56 : String
gap_y_56 =
    "gap-y-56"



{- "gap-60" -}


gap_60 : String
gap_60 =
    "gap-60"



{- "gap-x-60" -}


gap_x_60 : String
gap_x_60 =
    "gap-x-60"



{- "gap-y-60" -}


gap_y_60 : String
gap_y_60 =
    "gap-y-60"



{- "gap-64" -}


gap_64 : String
gap_64 =
    "gap-64"



{- "gap-x-64" -}


gap_x_64 : String
gap_x_64 =
    "gap-x-64"



{- "gap-y-64" -}


gap_y_64 : String
gap_y_64 =
    "gap-y-64"



{- "gap-72" -}


gap_72 : String
gap_72 =
    "gap-72"



{- "gap-x-72" -}


gap_x_72 : String
gap_x_72 =
    "gap-x-72"



{- "gap-y-72" -}


gap_y_72 : String
gap_y_72 =
    "gap-y-72"



{- "gap-80" -}


gap_80 : String
gap_80 =
    "gap-80"



{- "gap-x-80" -}


gap_x_80 : String
gap_x_80 =
    "gap-x-80"



{- "gap-y-80" -}


gap_y_80 : String
gap_y_80 =
    "gap-y-80"



{- "gap-96" -}


gap_96 : String
gap_96 =
    "gap-96"



{- "gap-x-96" -}


gap_x_96 : String
gap_x_96 =
    "gap-x-96"



{- "gap-y-96" -}


gap_y_96 : String
gap_y_96 =
    "gap-y-96"



-- Position (https://tailwindcss.com/docs/position)
{- "static" -}


static : String
static =
    "static"



{- "fixed" -}


fixed : String
fixed =
    "fixed"



{- "absolute" -}


absolute : String
absolute =
    "absolute"



{- "relative" -}


relative : String
relative =
    "relative"



{- "sticky" -}


sticky : String
sticky =
    "sticky"



-- Top / Right / Bottom / Left (https://tailwindcss.com/docs/top-right-bottom-left)
{- "inset-0" -}


inset_0 : String
inset_0 =
    "inset-0"



{- "-inset-0" -}


n_inset_0 : String
n_inset_0 =
    "-inset-0"



{- "inset-x-0" -}


inset_x_0 : String
inset_x_0 =
    "inset-x-0"



{- "-inset-x-0" -}


n_inset_x_0 : String
n_inset_x_0 =
    "-inset-x-0"



{- "inset-y-0" -}


inset_y_0 : String
inset_y_0 =
    "inset-y-0"



{- "-inset-y-0" -}


n_inset_y_0 : String
n_inset_y_0 =
    "-inset-y-0"



{- "top-0" -}


top_0 : String
top_0 =
    "top-0"



{- "-top-0" -}


n_top_0 : String
n_top_0 =
    "-top-0"



{- "right-0" -}


right_0 : String
right_0 =
    "right-0"



{- "-right-0" -}


n_right_0 : String
n_right_0 =
    "-right-0"



{- "bottom-0" -}


bottom_0 : String
bottom_0 =
    "bottom-0"



{- "-bottom-0" -}


n_bottom_0 : String
n_bottom_0 =
    "-bottom-0"



{- "left-0" -}


left_0 : String
left_0 =
    "left-0"



{- "-left-0" -}


n_left_0 : String
n_left_0 =
    "-left-0"



{- "inset-px" -}


inset_px : String
inset_px =
    "inset-px"



{- "-inset-px" -}


n_inset_px : String
n_inset_px =
    "-inset-px"



{- "inset-x-px" -}


inset_x_px : String
inset_x_px =
    "inset-x-px"



{- "-inset-x-px" -}


n_inset_x_px : String
n_inset_x_px =
    "-inset-x-px"



{- "inset-y-px" -}


inset_y_px : String
inset_y_px =
    "inset-y-px"



{- "-inset-y-px" -}


n_inset_y_px : String
n_inset_y_px =
    "-inset-y-px"



{- "top-px" -}


top_px : String
top_px =
    "top-px"



{- "-top-px" -}


n_top_px : String
n_top_px =
    "-top-px"



{- "right-px" -}


right_px : String
right_px =
    "right-px"



{- "-right-px" -}


n_right_px : String
n_right_px =
    "-right-px"



{- "bottom-px" -}


bottom_px : String
bottom_px =
    "bottom-px"



{- "-bottom-px" -}


n_bottom_px : String
n_bottom_px =
    "-bottom-px"



{- "left-px" -}


left_px : String
left_px =
    "left-px"



{- "-left-px" -}


n_left_px : String
n_left_px =
    "-left-px"



{- "inset-0.5" -}


inset_0_dot_5 : String
inset_0_dot_5 =
    "inset-0.5"



{- "-inset-0.5" -}


n_inset_0_dot_5 : String
n_inset_0_dot_5 =
    "-inset-0.5"



{- "inset-x-0.5" -}


inset_x_0_dot_5 : String
inset_x_0_dot_5 =
    "inset-x-0.5"



{- "-inset-x-0.5" -}


n_inset_x_0_dot_5 : String
n_inset_x_0_dot_5 =
    "-inset-x-0.5"



{- "inset-y-0.5" -}


inset_y_0_dot_5 : String
inset_y_0_dot_5 =
    "inset-y-0.5"



{- "-inset-y-0.5" -}


n_inset_y_0_dot_5 : String
n_inset_y_0_dot_5 =
    "-inset-y-0.5"



{- "top-0.5" -}


top_0_dot_5 : String
top_0_dot_5 =
    "top-0.5"



{- "-top-0.5" -}


n_top_0_dot_5 : String
n_top_0_dot_5 =
    "-top-0.5"



{- "right-0.5" -}


right_0_dot_5 : String
right_0_dot_5 =
    "right-0.5"



{- "-right-0.5" -}


n_right_0_dot_5 : String
n_right_0_dot_5 =
    "-right-0.5"



{- "bottom-0.5" -}


bottom_0_dot_5 : String
bottom_0_dot_5 =
    "bottom-0.5"



{- "-bottom-0.5" -}


n_bottom_0_dot_5 : String
n_bottom_0_dot_5 =
    "-bottom-0.5"



{- "left-0.5" -}


left_0_dot_5 : String
left_0_dot_5 =
    "left-0.5"



{- "-left-0.5" -}


n_left_0_dot_5 : String
n_left_0_dot_5 =
    "-left-0.5"



{- "inset-1" -}


inset_1 : String
inset_1 =
    "inset-1"



{- "-inset-1" -}


n_inset_1 : String
n_inset_1 =
    "-inset-1"



{- "inset-x-1" -}


inset_x_1 : String
inset_x_1 =
    "inset-x-1"



{- "-inset-x-1" -}


n_inset_x_1 : String
n_inset_x_1 =
    "-inset-x-1"



{- "inset-y-1" -}


inset_y_1 : String
inset_y_1 =
    "inset-y-1"



{- "-inset-y-1" -}


n_inset_y_1 : String
n_inset_y_1 =
    "-inset-y-1"



{- "top-1" -}


top_1 : String
top_1 =
    "top-1"



{- "-top-1" -}


n_top_1 : String
n_top_1 =
    "-top-1"



{- "right-1" -}


right_1 : String
right_1 =
    "right-1"



{- "-right-1" -}


n_right_1 : String
n_right_1 =
    "-right-1"



{- "bottom-1" -}


bottom_1 : String
bottom_1 =
    "bottom-1"



{- "-bottom-1" -}


n_bottom_1 : String
n_bottom_1 =
    "-bottom-1"



{- "left-1" -}


left_1 : String
left_1 =
    "left-1"



{- "-left-1" -}


n_left_1 : String
n_left_1 =
    "-left-1"



{- "inset-1.5" -}


inset_1_dot_5 : String
inset_1_dot_5 =
    "inset-1.5"



{- "-inset-1.5" -}


n_inset_1_dot_5 : String
n_inset_1_dot_5 =
    "-inset-1.5"



{- "inset-x-1.5" -}


inset_x_1_dot_5 : String
inset_x_1_dot_5 =
    "inset-x-1.5"



{- "-inset-x-1.5" -}


n_inset_x_1_dot_5 : String
n_inset_x_1_dot_5 =
    "-inset-x-1.5"



{- "inset-y-1.5" -}


inset_y_1_dot_5 : String
inset_y_1_dot_5 =
    "inset-y-1.5"



{- "-inset-y-1.5" -}


n_inset_y_1_dot_5 : String
n_inset_y_1_dot_5 =
    "-inset-y-1.5"



{- "top-1.5" -}


top_1_dot_5 : String
top_1_dot_5 =
    "top-1.5"



{- "-top-1.5" -}


n_top_1_dot_5 : String
n_top_1_dot_5 =
    "-top-1.5"



{- "right-1.5" -}


right_1_dot_5 : String
right_1_dot_5 =
    "right-1.5"



{- "-right-1.5" -}


n_right_1_dot_5 : String
n_right_1_dot_5 =
    "-right-1.5"



{- "bottom-1.5" -}


bottom_1_dot_5 : String
bottom_1_dot_5 =
    "bottom-1.5"



{- "-bottom-1.5" -}


n_bottom_1_dot_5 : String
n_bottom_1_dot_5 =
    "-bottom-1.5"



{- "left-1.5" -}


left_1_dot_5 : String
left_1_dot_5 =
    "left-1.5"



{- "-left-1.5" -}


n_left_1_dot_5 : String
n_left_1_dot_5 =
    "-left-1.5"



{- "inset-2" -}


inset_2 : String
inset_2 =
    "inset-2"



{- "-inset-2" -}


n_inset_2 : String
n_inset_2 =
    "-inset-2"



{- "inset-x-2" -}


inset_x_2 : String
inset_x_2 =
    "inset-x-2"



{- "-inset-x-2" -}


n_inset_x_2 : String
n_inset_x_2 =
    "-inset-x-2"



{- "inset-y-2" -}


inset_y_2 : String
inset_y_2 =
    "inset-y-2"



{- "-inset-y-2" -}


n_inset_y_2 : String
n_inset_y_2 =
    "-inset-y-2"



{- "top-2" -}


top_2 : String
top_2 =
    "top-2"



{- "-top-2" -}


n_top_2 : String
n_top_2 =
    "-top-2"



{- "right-2" -}


right_2 : String
right_2 =
    "right-2"



{- "-right-2" -}


n_right_2 : String
n_right_2 =
    "-right-2"



{- "bottom-2" -}


bottom_2 : String
bottom_2 =
    "bottom-2"



{- "-bottom-2" -}


n_bottom_2 : String
n_bottom_2 =
    "-bottom-2"



{- "left-2" -}


left_2 : String
left_2 =
    "left-2"



{- "-left-2" -}


n_left_2 : String
n_left_2 =
    "-left-2"



{- "inset-2.5" -}


inset_2_dot_5 : String
inset_2_dot_5 =
    "inset-2.5"



{- "-inset-2.5" -}


n_inset_2_dot_5 : String
n_inset_2_dot_5 =
    "-inset-2.5"



{- "inset-x-2.5" -}


inset_x_2_dot_5 : String
inset_x_2_dot_5 =
    "inset-x-2.5"



{- "-inset-x-2.5" -}


n_inset_x_2_dot_5 : String
n_inset_x_2_dot_5 =
    "-inset-x-2.5"



{- "inset-y-2.5" -}


inset_y_2_dot_5 : String
inset_y_2_dot_5 =
    "inset-y-2.5"



{- "-inset-y-2.5" -}


n_inset_y_2_dot_5 : String
n_inset_y_2_dot_5 =
    "-inset-y-2.5"



{- "top-2.5" -}


top_2_dot_5 : String
top_2_dot_5 =
    "top-2.5"



{- "-top-2.5" -}


n_top_2_dot_5 : String
n_top_2_dot_5 =
    "-top-2.5"



{- "right-2.5" -}


right_2_dot_5 : String
right_2_dot_5 =
    "right-2.5"



{- "-right-2.5" -}


n_right_2_dot_5 : String
n_right_2_dot_5 =
    "-right-2.5"



{- "bottom-2.5" -}


bottom_2_dot_5 : String
bottom_2_dot_5 =
    "bottom-2.5"



{- "-bottom-2.5" -}


n_bottom_2_dot_5 : String
n_bottom_2_dot_5 =
    "-bottom-2.5"



{- "left-2.5" -}


left_2_dot_5 : String
left_2_dot_5 =
    "left-2.5"



{- "-left-2.5" -}


n_left_2_dot_5 : String
n_left_2_dot_5 =
    "-left-2.5"



{- "inset-3" -}


inset_3 : String
inset_3 =
    "inset-3"



{- "-inset-3" -}


n_inset_3 : String
n_inset_3 =
    "-inset-3"



{- "inset-x-3" -}


inset_x_3 : String
inset_x_3 =
    "inset-x-3"



{- "-inset-x-3" -}


n_inset_x_3 : String
n_inset_x_3 =
    "-inset-x-3"



{- "inset-y-3" -}


inset_y_3 : String
inset_y_3 =
    "inset-y-3"



{- "-inset-y-3" -}


n_inset_y_3 : String
n_inset_y_3 =
    "-inset-y-3"



{- "top-3" -}


top_3 : String
top_3 =
    "top-3"



{- "-top-3" -}


n_top_3 : String
n_top_3 =
    "-top-3"



{- "right-3" -}


right_3 : String
right_3 =
    "right-3"



{- "-right-3" -}


n_right_3 : String
n_right_3 =
    "-right-3"



{- "bottom-3" -}


bottom_3 : String
bottom_3 =
    "bottom-3"



{- "-bottom-3" -}


n_bottom_3 : String
n_bottom_3 =
    "-bottom-3"



{- "left-3" -}


left_3 : String
left_3 =
    "left-3"



{- "-left-3" -}


n_left_3 : String
n_left_3 =
    "-left-3"



{- "inset-3.5" -}


inset_3_dot_5 : String
inset_3_dot_5 =
    "inset-3.5"



{- "-inset-3.5" -}


n_inset_3_dot_5 : String
n_inset_3_dot_5 =
    "-inset-3.5"



{- "inset-x-3.5" -}


inset_x_3_dot_5 : String
inset_x_3_dot_5 =
    "inset-x-3.5"



{- "-inset-x-3.5" -}


n_inset_x_3_dot_5 : String
n_inset_x_3_dot_5 =
    "-inset-x-3.5"



{- "inset-y-3.5" -}


inset_y_3_dot_5 : String
inset_y_3_dot_5 =
    "inset-y-3.5"



{- "-inset-y-3.5" -}


n_inset_y_3_dot_5 : String
n_inset_y_3_dot_5 =
    "-inset-y-3.5"



{- "top-3.5" -}


top_3_dot_5 : String
top_3_dot_5 =
    "top-3.5"



{- "-top-3.5" -}


n_top_3_dot_5 : String
n_top_3_dot_5 =
    "-top-3.5"



{- "right-3.5" -}


right_3_dot_5 : String
right_3_dot_5 =
    "right-3.5"



{- "-right-3.5" -}


n_right_3_dot_5 : String
n_right_3_dot_5 =
    "-right-3.5"



{- "bottom-3.5" -}


bottom_3_dot_5 : String
bottom_3_dot_5 =
    "bottom-3.5"



{- "-bottom-3.5" -}


n_bottom_3_dot_5 : String
n_bottom_3_dot_5 =
    "-bottom-3.5"



{- "left-3.5" -}


left_3_dot_5 : String
left_3_dot_5 =
    "left-3.5"



{- "-left-3.5" -}


n_left_3_dot_5 : String
n_left_3_dot_5 =
    "-left-3.5"



{- "inset-4" -}


inset_4 : String
inset_4 =
    "inset-4"



{- "-inset-4" -}


n_inset_4 : String
n_inset_4 =
    "-inset-4"



{- "inset-x-4" -}


inset_x_4 : String
inset_x_4 =
    "inset-x-4"



{- "-inset-x-4" -}


n_inset_x_4 : String
n_inset_x_4 =
    "-inset-x-4"



{- "inset-y-4" -}


inset_y_4 : String
inset_y_4 =
    "inset-y-4"



{- "-inset-y-4" -}


n_inset_y_4 : String
n_inset_y_4 =
    "-inset-y-4"



{- "top-4" -}


top_4 : String
top_4 =
    "top-4"



{- "-top-4" -}


n_top_4 : String
n_top_4 =
    "-top-4"



{- "right-4" -}


right_4 : String
right_4 =
    "right-4"



{- "-right-4" -}


n_right_4 : String
n_right_4 =
    "-right-4"



{- "bottom-4" -}


bottom_4 : String
bottom_4 =
    "bottom-4"



{- "-bottom-4" -}


n_bottom_4 : String
n_bottom_4 =
    "-bottom-4"



{- "left-4" -}


left_4 : String
left_4 =
    "left-4"



{- "-left-4" -}


n_left_4 : String
n_left_4 =
    "-left-4"



{- "inset-5" -}


inset_5 : String
inset_5 =
    "inset-5"



{- "-inset-5" -}


n_inset_5 : String
n_inset_5 =
    "-inset-5"



{- "inset-x-5" -}


inset_x_5 : String
inset_x_5 =
    "inset-x-5"



{- "-inset-x-5" -}


n_inset_x_5 : String
n_inset_x_5 =
    "-inset-x-5"



{- "inset-y-5" -}


inset_y_5 : String
inset_y_5 =
    "inset-y-5"



{- "-inset-y-5" -}


n_inset_y_5 : String
n_inset_y_5 =
    "-inset-y-5"



{- "top-5" -}


top_5 : String
top_5 =
    "top-5"



{- "-top-5" -}


n_top_5 : String
n_top_5 =
    "-top-5"



{- "right-5" -}


right_5 : String
right_5 =
    "right-5"



{- "-right-5" -}


n_right_5 : String
n_right_5 =
    "-right-5"



{- "bottom-5" -}


bottom_5 : String
bottom_5 =
    "bottom-5"



{- "-bottom-5" -}


n_bottom_5 : String
n_bottom_5 =
    "-bottom-5"



{- "left-5" -}


left_5 : String
left_5 =
    "left-5"



{- "-left-5" -}


n_left_5 : String
n_left_5 =
    "-left-5"



{- "inset-6" -}


inset_6 : String
inset_6 =
    "inset-6"



{- "-inset-6" -}


n_inset_6 : String
n_inset_6 =
    "-inset-6"



{- "inset-x-6" -}


inset_x_6 : String
inset_x_6 =
    "inset-x-6"



{- "-inset-x-6" -}


n_inset_x_6 : String
n_inset_x_6 =
    "-inset-x-6"



{- "inset-y-6" -}


inset_y_6 : String
inset_y_6 =
    "inset-y-6"



{- "-inset-y-6" -}


n_inset_y_6 : String
n_inset_y_6 =
    "-inset-y-6"



{- "top-6" -}


top_6 : String
top_6 =
    "top-6"



{- "-top-6" -}


n_top_6 : String
n_top_6 =
    "-top-6"



{- "right-6" -}


right_6 : String
right_6 =
    "right-6"



{- "-right-6" -}


n_right_6 : String
n_right_6 =
    "-right-6"



{- "bottom-6" -}


bottom_6 : String
bottom_6 =
    "bottom-6"



{- "-bottom-6" -}


n_bottom_6 : String
n_bottom_6 =
    "-bottom-6"



{- "left-6" -}


left_6 : String
left_6 =
    "left-6"



{- "-left-6" -}


n_left_6 : String
n_left_6 =
    "-left-6"



{- "inset-7" -}


inset_7 : String
inset_7 =
    "inset-7"



{- "-inset-7" -}


n_inset_7 : String
n_inset_7 =
    "-inset-7"



{- "inset-x-7" -}


inset_x_7 : String
inset_x_7 =
    "inset-x-7"



{- "-inset-x-7" -}


n_inset_x_7 : String
n_inset_x_7 =
    "-inset-x-7"



{- "inset-y-7" -}


inset_y_7 : String
inset_y_7 =
    "inset-y-7"



{- "-inset-y-7" -}


n_inset_y_7 : String
n_inset_y_7 =
    "-inset-y-7"



{- "top-7" -}


top_7 : String
top_7 =
    "top-7"



{- "-top-7" -}


n_top_7 : String
n_top_7 =
    "-top-7"



{- "right-7" -}


right_7 : String
right_7 =
    "right-7"



{- "-right-7" -}


n_right_7 : String
n_right_7 =
    "-right-7"



{- "bottom-7" -}


bottom_7 : String
bottom_7 =
    "bottom-7"



{- "-bottom-7" -}


n_bottom_7 : String
n_bottom_7 =
    "-bottom-7"



{- "left-7" -}


left_7 : String
left_7 =
    "left-7"



{- "-left-7" -}


n_left_7 : String
n_left_7 =
    "-left-7"



{- "inset-8" -}


inset_8 : String
inset_8 =
    "inset-8"



{- "-inset-8" -}


n_inset_8 : String
n_inset_8 =
    "-inset-8"



{- "inset-x-8" -}


inset_x_8 : String
inset_x_8 =
    "inset-x-8"



{- "-inset-x-8" -}


n_inset_x_8 : String
n_inset_x_8 =
    "-inset-x-8"



{- "inset-y-8" -}


inset_y_8 : String
inset_y_8 =
    "inset-y-8"



{- "-inset-y-8" -}


n_inset_y_8 : String
n_inset_y_8 =
    "-inset-y-8"



{- "top-8" -}


top_8 : String
top_8 =
    "top-8"



{- "-top-8" -}


n_top_8 : String
n_top_8 =
    "-top-8"



{- "right-8" -}


right_8 : String
right_8 =
    "right-8"



{- "-right-8" -}


n_right_8 : String
n_right_8 =
    "-right-8"



{- "bottom-8" -}


bottom_8 : String
bottom_8 =
    "bottom-8"



{- "-bottom-8" -}


n_bottom_8 : String
n_bottom_8 =
    "-bottom-8"



{- "left-8" -}


left_8 : String
left_8 =
    "left-8"



{- "-left-8" -}


n_left_8 : String
n_left_8 =
    "-left-8"



{- "inset-9" -}


inset_9 : String
inset_9 =
    "inset-9"



{- "-inset-9" -}


n_inset_9 : String
n_inset_9 =
    "-inset-9"



{- "inset-x-9" -}


inset_x_9 : String
inset_x_9 =
    "inset-x-9"



{- "-inset-x-9" -}


n_inset_x_9 : String
n_inset_x_9 =
    "-inset-x-9"



{- "inset-y-9" -}


inset_y_9 : String
inset_y_9 =
    "inset-y-9"



{- "-inset-y-9" -}


n_inset_y_9 : String
n_inset_y_9 =
    "-inset-y-9"



{- "top-9" -}


top_9 : String
top_9 =
    "top-9"



{- "-top-9" -}


n_top_9 : String
n_top_9 =
    "-top-9"



{- "right-9" -}


right_9 : String
right_9 =
    "right-9"



{- "-right-9" -}


n_right_9 : String
n_right_9 =
    "-right-9"



{- "bottom-9" -}


bottom_9 : String
bottom_9 =
    "bottom-9"



{- "-bottom-9" -}


n_bottom_9 : String
n_bottom_9 =
    "-bottom-9"



{- "left-9" -}


left_9 : String
left_9 =
    "left-9"



{- "-left-9" -}


n_left_9 : String
n_left_9 =
    "-left-9"



{- "inset-10" -}


inset_10 : String
inset_10 =
    "inset-10"



{- "-inset-10" -}


n_inset_10 : String
n_inset_10 =
    "-inset-10"



{- "inset-x-10" -}


inset_x_10 : String
inset_x_10 =
    "inset-x-10"



{- "-inset-x-10" -}


n_inset_x_10 : String
n_inset_x_10 =
    "-inset-x-10"



{- "inset-y-10" -}


inset_y_10 : String
inset_y_10 =
    "inset-y-10"



{- "-inset-y-10" -}


n_inset_y_10 : String
n_inset_y_10 =
    "-inset-y-10"



{- "top-10" -}


top_10 : String
top_10 =
    "top-10"



{- "-top-10" -}


n_top_10 : String
n_top_10 =
    "-top-10"



{- "right-10" -}


right_10 : String
right_10 =
    "right-10"



{- "-right-10" -}


n_right_10 : String
n_right_10 =
    "-right-10"



{- "bottom-10" -}


bottom_10 : String
bottom_10 =
    "bottom-10"



{- "-bottom-10" -}


n_bottom_10 : String
n_bottom_10 =
    "-bottom-10"



{- "left-10" -}


left_10 : String
left_10 =
    "left-10"



{- "-left-10" -}


n_left_10 : String
n_left_10 =
    "-left-10"



{- "inset-11" -}


inset_11 : String
inset_11 =
    "inset-11"



{- "-inset-11" -}


n_inset_11 : String
n_inset_11 =
    "-inset-11"



{- "inset-x-11" -}


inset_x_11 : String
inset_x_11 =
    "inset-x-11"



{- "-inset-x-11" -}


n_inset_x_11 : String
n_inset_x_11 =
    "-inset-x-11"



{- "inset-y-11" -}


inset_y_11 : String
inset_y_11 =
    "inset-y-11"



{- "-inset-y-11" -}


n_inset_y_11 : String
n_inset_y_11 =
    "-inset-y-11"



{- "top-11" -}


top_11 : String
top_11 =
    "top-11"



{- "-top-11" -}


n_top_11 : String
n_top_11 =
    "-top-11"



{- "right-11" -}


right_11 : String
right_11 =
    "right-11"



{- "-right-11" -}


n_right_11 : String
n_right_11 =
    "-right-11"



{- "bottom-11" -}


bottom_11 : String
bottom_11 =
    "bottom-11"



{- "-bottom-11" -}


n_bottom_11 : String
n_bottom_11 =
    "-bottom-11"



{- "left-11" -}


left_11 : String
left_11 =
    "left-11"



{- "-left-11" -}


n_left_11 : String
n_left_11 =
    "-left-11"



{- "inset-12" -}


inset_12 : String
inset_12 =
    "inset-12"



{- "-inset-12" -}


n_inset_12 : String
n_inset_12 =
    "-inset-12"



{- "inset-x-12" -}


inset_x_12 : String
inset_x_12 =
    "inset-x-12"



{- "-inset-x-12" -}


n_inset_x_12 : String
n_inset_x_12 =
    "-inset-x-12"



{- "inset-y-12" -}


inset_y_12 : String
inset_y_12 =
    "inset-y-12"



{- "-inset-y-12" -}


n_inset_y_12 : String
n_inset_y_12 =
    "-inset-y-12"



{- "top-12" -}


top_12 : String
top_12 =
    "top-12"



{- "-top-12" -}


n_top_12 : String
n_top_12 =
    "-top-12"



{- "right-12" -}


right_12 : String
right_12 =
    "right-12"



{- "-right-12" -}


n_right_12 : String
n_right_12 =
    "-right-12"



{- "bottom-12" -}


bottom_12 : String
bottom_12 =
    "bottom-12"



{- "-bottom-12" -}


n_bottom_12 : String
n_bottom_12 =
    "-bottom-12"



{- "left-12" -}


left_12 : String
left_12 =
    "left-12"



{- "-left-12" -}


n_left_12 : String
n_left_12 =
    "-left-12"



{- "inset-14" -}


inset_14 : String
inset_14 =
    "inset-14"



{- "-inset-14" -}


n_inset_14 : String
n_inset_14 =
    "-inset-14"



{- "inset-x-14" -}


inset_x_14 : String
inset_x_14 =
    "inset-x-14"



{- "-inset-x-14" -}


n_inset_x_14 : String
n_inset_x_14 =
    "-inset-x-14"



{- "inset-y-14" -}


inset_y_14 : String
inset_y_14 =
    "inset-y-14"



{- "-inset-y-14" -}


n_inset_y_14 : String
n_inset_y_14 =
    "-inset-y-14"



{- "top-14" -}


top_14 : String
top_14 =
    "top-14"



{- "-top-14" -}


n_top_14 : String
n_top_14 =
    "-top-14"



{- "right-14" -}


right_14 : String
right_14 =
    "right-14"



{- "-right-14" -}


n_right_14 : String
n_right_14 =
    "-right-14"



{- "bottom-14" -}


bottom_14 : String
bottom_14 =
    "bottom-14"



{- "-bottom-14" -}


n_bottom_14 : String
n_bottom_14 =
    "-bottom-14"



{- "left-14" -}


left_14 : String
left_14 =
    "left-14"



{- "-left-14" -}


n_left_14 : String
n_left_14 =
    "-left-14"



{- "inset-16" -}


inset_16 : String
inset_16 =
    "inset-16"



{- "-inset-16" -}


n_inset_16 : String
n_inset_16 =
    "-inset-16"



{- "inset-x-16" -}


inset_x_16 : String
inset_x_16 =
    "inset-x-16"



{- "-inset-x-16" -}


n_inset_x_16 : String
n_inset_x_16 =
    "-inset-x-16"



{- "inset-y-16" -}


inset_y_16 : String
inset_y_16 =
    "inset-y-16"



{- "-inset-y-16" -}


n_inset_y_16 : String
n_inset_y_16 =
    "-inset-y-16"



{- "top-16" -}


top_16 : String
top_16 =
    "top-16"



{- "-top-16" -}


n_top_16 : String
n_top_16 =
    "-top-16"



{- "right-16" -}


right_16 : String
right_16 =
    "right-16"



{- "-right-16" -}


n_right_16 : String
n_right_16 =
    "-right-16"



{- "bottom-16" -}


bottom_16 : String
bottom_16 =
    "bottom-16"



{- "-bottom-16" -}


n_bottom_16 : String
n_bottom_16 =
    "-bottom-16"



{- "left-16" -}


left_16 : String
left_16 =
    "left-16"



{- "-left-16" -}


n_left_16 : String
n_left_16 =
    "-left-16"



{- "inset-20" -}


inset_20 : String
inset_20 =
    "inset-20"



{- "-inset-20" -}


n_inset_20 : String
n_inset_20 =
    "-inset-20"



{- "inset-x-20" -}


inset_x_20 : String
inset_x_20 =
    "inset-x-20"



{- "-inset-x-20" -}


n_inset_x_20 : String
n_inset_x_20 =
    "-inset-x-20"



{- "inset-y-20" -}


inset_y_20 : String
inset_y_20 =
    "inset-y-20"



{- "-inset-y-20" -}


n_inset_y_20 : String
n_inset_y_20 =
    "-inset-y-20"



{- "top-20" -}


top_20 : String
top_20 =
    "top-20"



{- "-top-20" -}


n_top_20 : String
n_top_20 =
    "-top-20"



{- "right-20" -}


right_20 : String
right_20 =
    "right-20"



{- "-right-20" -}


n_right_20 : String
n_right_20 =
    "-right-20"



{- "bottom-20" -}


bottom_20 : String
bottom_20 =
    "bottom-20"



{- "-bottom-20" -}


n_bottom_20 : String
n_bottom_20 =
    "-bottom-20"



{- "left-20" -}


left_20 : String
left_20 =
    "left-20"



{- "-left-20" -}


n_left_20 : String
n_left_20 =
    "-left-20"



{- "inset-24" -}


inset_24 : String
inset_24 =
    "inset-24"



{- "-inset-24" -}


n_inset_24 : String
n_inset_24 =
    "-inset-24"



{- "inset-x-24" -}


inset_x_24 : String
inset_x_24 =
    "inset-x-24"



{- "-inset-x-24" -}


n_inset_x_24 : String
n_inset_x_24 =
    "-inset-x-24"



{- "inset-y-24" -}


inset_y_24 : String
inset_y_24 =
    "inset-y-24"



{- "-inset-y-24" -}


n_inset_y_24 : String
n_inset_y_24 =
    "-inset-y-24"



{- "top-24" -}


top_24 : String
top_24 =
    "top-24"



{- "-top-24" -}


n_top_24 : String
n_top_24 =
    "-top-24"



{- "right-24" -}


right_24 : String
right_24 =
    "right-24"



{- "-right-24" -}


n_right_24 : String
n_right_24 =
    "-right-24"



{- "bottom-24" -}


bottom_24 : String
bottom_24 =
    "bottom-24"



{- "-bottom-24" -}


n_bottom_24 : String
n_bottom_24 =
    "-bottom-24"



{- "left-24" -}


left_24 : String
left_24 =
    "left-24"



{- "-left-24" -}


n_left_24 : String
n_left_24 =
    "-left-24"



{- "inset-28" -}


inset_28 : String
inset_28 =
    "inset-28"



{- "-inset-28" -}


n_inset_28 : String
n_inset_28 =
    "-inset-28"



{- "inset-x-28" -}


inset_x_28 : String
inset_x_28 =
    "inset-x-28"



{- "-inset-x-28" -}


n_inset_x_28 : String
n_inset_x_28 =
    "-inset-x-28"



{- "inset-y-28" -}


inset_y_28 : String
inset_y_28 =
    "inset-y-28"



{- "-inset-y-28" -}


n_inset_y_28 : String
n_inset_y_28 =
    "-inset-y-28"



{- "top-28" -}


top_28 : String
top_28 =
    "top-28"



{- "-top-28" -}


n_top_28 : String
n_top_28 =
    "-top-28"



{- "right-28" -}


right_28 : String
right_28 =
    "right-28"



{- "-right-28" -}


n_right_28 : String
n_right_28 =
    "-right-28"



{- "bottom-28" -}


bottom_28 : String
bottom_28 =
    "bottom-28"



{- "-bottom-28" -}


n_bottom_28 : String
n_bottom_28 =
    "-bottom-28"



{- "left-28" -}


left_28 : String
left_28 =
    "left-28"



{- "-left-28" -}


n_left_28 : String
n_left_28 =
    "-left-28"



{- "inset-32" -}


inset_32 : String
inset_32 =
    "inset-32"



{- "-inset-32" -}


n_inset_32 : String
n_inset_32 =
    "-inset-32"



{- "inset-x-32" -}


inset_x_32 : String
inset_x_32 =
    "inset-x-32"



{- "-inset-x-32" -}


n_inset_x_32 : String
n_inset_x_32 =
    "-inset-x-32"



{- "inset-y-32" -}


inset_y_32 : String
inset_y_32 =
    "inset-y-32"



{- "-inset-y-32" -}


n_inset_y_32 : String
n_inset_y_32 =
    "-inset-y-32"



{- "top-32" -}


top_32 : String
top_32 =
    "top-32"



{- "-top-32" -}


n_top_32 : String
n_top_32 =
    "-top-32"



{- "right-32" -}


right_32 : String
right_32 =
    "right-32"



{- "-right-32" -}


n_right_32 : String
n_right_32 =
    "-right-32"



{- "bottom-32" -}


bottom_32 : String
bottom_32 =
    "bottom-32"



{- "-bottom-32" -}


n_bottom_32 : String
n_bottom_32 =
    "-bottom-32"



{- "left-32" -}


left_32 : String
left_32 =
    "left-32"



{- "-left-32" -}


n_left_32 : String
n_left_32 =
    "-left-32"



{- "inset-36" -}


inset_36 : String
inset_36 =
    "inset-36"



{- "-inset-36" -}


n_inset_36 : String
n_inset_36 =
    "-inset-36"



{- "inset-x-36" -}


inset_x_36 : String
inset_x_36 =
    "inset-x-36"



{- "-inset-x-36" -}


n_inset_x_36 : String
n_inset_x_36 =
    "-inset-x-36"



{- "inset-y-36" -}


inset_y_36 : String
inset_y_36 =
    "inset-y-36"



{- "-inset-y-36" -}


n_inset_y_36 : String
n_inset_y_36 =
    "-inset-y-36"



{- "top-36" -}


top_36 : String
top_36 =
    "top-36"



{- "-top-36" -}


n_top_36 : String
n_top_36 =
    "-top-36"



{- "right-36" -}


right_36 : String
right_36 =
    "right-36"



{- "-right-36" -}


n_right_36 : String
n_right_36 =
    "-right-36"



{- "bottom-36" -}


bottom_36 : String
bottom_36 =
    "bottom-36"



{- "-bottom-36" -}


n_bottom_36 : String
n_bottom_36 =
    "-bottom-36"



{- "left-36" -}


left_36 : String
left_36 =
    "left-36"



{- "-left-36" -}


n_left_36 : String
n_left_36 =
    "-left-36"



{- "inset-40" -}


inset_40 : String
inset_40 =
    "inset-40"



{- "-inset-40" -}


n_inset_40 : String
n_inset_40 =
    "-inset-40"



{- "inset-x-40" -}


inset_x_40 : String
inset_x_40 =
    "inset-x-40"



{- "-inset-x-40" -}


n_inset_x_40 : String
n_inset_x_40 =
    "-inset-x-40"



{- "inset-y-40" -}


inset_y_40 : String
inset_y_40 =
    "inset-y-40"



{- "-inset-y-40" -}


n_inset_y_40 : String
n_inset_y_40 =
    "-inset-y-40"



{- "top-40" -}


top_40 : String
top_40 =
    "top-40"



{- "-top-40" -}


n_top_40 : String
n_top_40 =
    "-top-40"



{- "right-40" -}


right_40 : String
right_40 =
    "right-40"



{- "-right-40" -}


n_right_40 : String
n_right_40 =
    "-right-40"



{- "bottom-40" -}


bottom_40 : String
bottom_40 =
    "bottom-40"



{- "-bottom-40" -}


n_bottom_40 : String
n_bottom_40 =
    "-bottom-40"



{- "left-40" -}


left_40 : String
left_40 =
    "left-40"



{- "-left-40" -}


n_left_40 : String
n_left_40 =
    "-left-40"



{- "inset-44" -}


inset_44 : String
inset_44 =
    "inset-44"



{- "-inset-44" -}


n_inset_44 : String
n_inset_44 =
    "-inset-44"



{- "inset-x-44" -}


inset_x_44 : String
inset_x_44 =
    "inset-x-44"



{- "-inset-x-44" -}


n_inset_x_44 : String
n_inset_x_44 =
    "-inset-x-44"



{- "inset-y-44" -}


inset_y_44 : String
inset_y_44 =
    "inset-y-44"



{- "-inset-y-44" -}


n_inset_y_44 : String
n_inset_y_44 =
    "-inset-y-44"



{- "top-44" -}


top_44 : String
top_44 =
    "top-44"



{- "-top-44" -}


n_top_44 : String
n_top_44 =
    "-top-44"



{- "right-44" -}


right_44 : String
right_44 =
    "right-44"



{- "-right-44" -}


n_right_44 : String
n_right_44 =
    "-right-44"



{- "bottom-44" -}


bottom_44 : String
bottom_44 =
    "bottom-44"



{- "-bottom-44" -}


n_bottom_44 : String
n_bottom_44 =
    "-bottom-44"



{- "left-44" -}


left_44 : String
left_44 =
    "left-44"



{- "-left-44" -}


n_left_44 : String
n_left_44 =
    "-left-44"



{- "inset-48" -}


inset_48 : String
inset_48 =
    "inset-48"



{- "-inset-48" -}


n_inset_48 : String
n_inset_48 =
    "-inset-48"



{- "inset-x-48" -}


inset_x_48 : String
inset_x_48 =
    "inset-x-48"



{- "-inset-x-48" -}


n_inset_x_48 : String
n_inset_x_48 =
    "-inset-x-48"



{- "inset-y-48" -}


inset_y_48 : String
inset_y_48 =
    "inset-y-48"



{- "-inset-y-48" -}


n_inset_y_48 : String
n_inset_y_48 =
    "-inset-y-48"



{- "top-48" -}


top_48 : String
top_48 =
    "top-48"



{- "-top-48" -}


n_top_48 : String
n_top_48 =
    "-top-48"



{- "right-48" -}


right_48 : String
right_48 =
    "right-48"



{- "-right-48" -}


n_right_48 : String
n_right_48 =
    "-right-48"



{- "bottom-48" -}


bottom_48 : String
bottom_48 =
    "bottom-48"



{- "-bottom-48" -}


n_bottom_48 : String
n_bottom_48 =
    "-bottom-48"



{- "left-48" -}


left_48 : String
left_48 =
    "left-48"



{- "-left-48" -}


n_left_48 : String
n_left_48 =
    "-left-48"



{- "inset-52" -}


inset_52 : String
inset_52 =
    "inset-52"



{- "-inset-52" -}


n_inset_52 : String
n_inset_52 =
    "-inset-52"



{- "inset-x-52" -}


inset_x_52 : String
inset_x_52 =
    "inset-x-52"



{- "-inset-x-52" -}


n_inset_x_52 : String
n_inset_x_52 =
    "-inset-x-52"



{- "inset-y-52" -}


inset_y_52 : String
inset_y_52 =
    "inset-y-52"



{- "-inset-y-52" -}


n_inset_y_52 : String
n_inset_y_52 =
    "-inset-y-52"



{- "top-52" -}


top_52 : String
top_52 =
    "top-52"



{- "-top-52" -}


n_top_52 : String
n_top_52 =
    "-top-52"



{- "right-52" -}


right_52 : String
right_52 =
    "right-52"



{- "-right-52" -}


n_right_52 : String
n_right_52 =
    "-right-52"



{- "bottom-52" -}


bottom_52 : String
bottom_52 =
    "bottom-52"



{- "-bottom-52" -}


n_bottom_52 : String
n_bottom_52 =
    "-bottom-52"



{- "left-52" -}


left_52 : String
left_52 =
    "left-52"



{- "-left-52" -}


n_left_52 : String
n_left_52 =
    "-left-52"



{- "inset-56" -}


inset_56 : String
inset_56 =
    "inset-56"



{- "-inset-56" -}


n_inset_56 : String
n_inset_56 =
    "-inset-56"



{- "inset-x-56" -}


inset_x_56 : String
inset_x_56 =
    "inset-x-56"



{- "-inset-x-56" -}


n_inset_x_56 : String
n_inset_x_56 =
    "-inset-x-56"



{- "inset-y-56" -}


inset_y_56 : String
inset_y_56 =
    "inset-y-56"



{- "-inset-y-56" -}


n_inset_y_56 : String
n_inset_y_56 =
    "-inset-y-56"



{- "top-56" -}


top_56 : String
top_56 =
    "top-56"



{- "-top-56" -}


n_top_56 : String
n_top_56 =
    "-top-56"



{- "right-56" -}


right_56 : String
right_56 =
    "right-56"



{- "-right-56" -}


n_right_56 : String
n_right_56 =
    "-right-56"



{- "bottom-56" -}


bottom_56 : String
bottom_56 =
    "bottom-56"



{- "-bottom-56" -}


n_bottom_56 : String
n_bottom_56 =
    "-bottom-56"



{- "left-56" -}


left_56 : String
left_56 =
    "left-56"



{- "-left-56" -}


n_left_56 : String
n_left_56 =
    "-left-56"



{- "inset-60" -}


inset_60 : String
inset_60 =
    "inset-60"



{- "-inset-60" -}


n_inset_60 : String
n_inset_60 =
    "-inset-60"



{- "inset-x-60" -}


inset_x_60 : String
inset_x_60 =
    "inset-x-60"



{- "-inset-x-60" -}


n_inset_x_60 : String
n_inset_x_60 =
    "-inset-x-60"



{- "inset-y-60" -}


inset_y_60 : String
inset_y_60 =
    "inset-y-60"



{- "-inset-y-60" -}


n_inset_y_60 : String
n_inset_y_60 =
    "-inset-y-60"



{- "top-60" -}


top_60 : String
top_60 =
    "top-60"



{- "-top-60" -}


n_top_60 : String
n_top_60 =
    "-top-60"



{- "right-60" -}


right_60 : String
right_60 =
    "right-60"



{- "-right-60" -}


n_right_60 : String
n_right_60 =
    "-right-60"



{- "bottom-60" -}


bottom_60 : String
bottom_60 =
    "bottom-60"



{- "-bottom-60" -}


n_bottom_60 : String
n_bottom_60 =
    "-bottom-60"



{- "left-60" -}


left_60 : String
left_60 =
    "left-60"



{- "-left-60" -}


n_left_60 : String
n_left_60 =
    "-left-60"



{- "inset-64" -}


inset_64 : String
inset_64 =
    "inset-64"



{- "-inset-64" -}


n_inset_64 : String
n_inset_64 =
    "-inset-64"



{- "inset-x-64" -}


inset_x_64 : String
inset_x_64 =
    "inset-x-64"



{- "-inset-x-64" -}


n_inset_x_64 : String
n_inset_x_64 =
    "-inset-x-64"



{- "inset-y-64" -}


inset_y_64 : String
inset_y_64 =
    "inset-y-64"



{- "-inset-y-64" -}


n_inset_y_64 : String
n_inset_y_64 =
    "-inset-y-64"



{- "top-64" -}


top_64 : String
top_64 =
    "top-64"



{- "-top-64" -}


n_top_64 : String
n_top_64 =
    "-top-64"



{- "right-64" -}


right_64 : String
right_64 =
    "right-64"



{- "-right-64" -}


n_right_64 : String
n_right_64 =
    "-right-64"



{- "bottom-64" -}


bottom_64 : String
bottom_64 =
    "bottom-64"



{- "-bottom-64" -}


n_bottom_64 : String
n_bottom_64 =
    "-bottom-64"



{- "left-64" -}


left_64 : String
left_64 =
    "left-64"



{- "-left-64" -}


n_left_64 : String
n_left_64 =
    "-left-64"



{- "inset-72" -}


inset_72 : String
inset_72 =
    "inset-72"



{- "-inset-72" -}


n_inset_72 : String
n_inset_72 =
    "-inset-72"



{- "inset-x-72" -}


inset_x_72 : String
inset_x_72 =
    "inset-x-72"



{- "-inset-x-72" -}


n_inset_x_72 : String
n_inset_x_72 =
    "-inset-x-72"



{- "inset-y-72" -}


inset_y_72 : String
inset_y_72 =
    "inset-y-72"



{- "-inset-y-72" -}


n_inset_y_72 : String
n_inset_y_72 =
    "-inset-y-72"



{- "top-72" -}


top_72 : String
top_72 =
    "top-72"



{- "-top-72" -}


n_top_72 : String
n_top_72 =
    "-top-72"



{- "right-72" -}


right_72 : String
right_72 =
    "right-72"



{- "-right-72" -}


n_right_72 : String
n_right_72 =
    "-right-72"



{- "bottom-72" -}


bottom_72 : String
bottom_72 =
    "bottom-72"



{- "-bottom-72" -}


n_bottom_72 : String
n_bottom_72 =
    "-bottom-72"



{- "left-72" -}


left_72 : String
left_72 =
    "left-72"



{- "-left-72" -}


n_left_72 : String
n_left_72 =
    "-left-72"



{- "inset-80" -}


inset_80 : String
inset_80 =
    "inset-80"



{- "-inset-80" -}


n_inset_80 : String
n_inset_80 =
    "-inset-80"



{- "inset-x-80" -}


inset_x_80 : String
inset_x_80 =
    "inset-x-80"



{- "-inset-x-80" -}


n_inset_x_80 : String
n_inset_x_80 =
    "-inset-x-80"



{- "inset-y-80" -}


inset_y_80 : String
inset_y_80 =
    "inset-y-80"



{- "-inset-y-80" -}


n_inset_y_80 : String
n_inset_y_80 =
    "-inset-y-80"



{- "top-80" -}


top_80 : String
top_80 =
    "top-80"



{- "-top-80" -}


n_top_80 : String
n_top_80 =
    "-top-80"



{- "right-80" -}


right_80 : String
right_80 =
    "right-80"



{- "-right-80" -}


n_right_80 : String
n_right_80 =
    "-right-80"



{- "bottom-80" -}


bottom_80 : String
bottom_80 =
    "bottom-80"



{- "-bottom-80" -}


n_bottom_80 : String
n_bottom_80 =
    "-bottom-80"



{- "left-80" -}


left_80 : String
left_80 =
    "left-80"



{- "-left-80" -}


n_left_80 : String
n_left_80 =
    "-left-80"



{- "inset-96" -}


inset_96 : String
inset_96 =
    "inset-96"



{- "-inset-96" -}


n_inset_96 : String
n_inset_96 =
    "-inset-96"



{- "inset-x-96" -}


inset_x_96 : String
inset_x_96 =
    "inset-x-96"



{- "-inset-x-96" -}


n_inset_x_96 : String
n_inset_x_96 =
    "-inset-x-96"



{- "inset-y-96" -}


inset_y_96 : String
inset_y_96 =
    "inset-y-96"



{- "-inset-y-96" -}


n_inset_y_96 : String
n_inset_y_96 =
    "-inset-y-96"



{- "top-96" -}


top_96 : String
top_96 =
    "top-96"



{- "-top-96" -}


n_top_96 : String
n_top_96 =
    "-top-96"



{- "right-96" -}


right_96 : String
right_96 =
    "right-96"



{- "-right-96" -}


n_right_96 : String
n_right_96 =
    "-right-96"



{- "bottom-96" -}


bottom_96 : String
bottom_96 =
    "bottom-96"



{- "-bottom-96" -}


n_bottom_96 : String
n_bottom_96 =
    "-bottom-96"



{- "left-96" -}


left_96 : String
left_96 =
    "left-96"



{- "-left-96" -}


n_left_96 : String
n_left_96 =
    "-left-96"



{- "inset-auto" -}


inset_auto : String
inset_auto =
    "inset-auto"



{- "inset-1/2" -}


inset_1_slash_2 : String
inset_1_slash_2 =
    "inset-1/2"



{- "inset-1/3" -}


inset_1_slash_3 : String
inset_1_slash_3 =
    "inset-1/3"



{- "inset-2/3" -}


inset_2_slash_3 : String
inset_2_slash_3 =
    "inset-2/3"



{- "inset-1/4" -}


inset_1_slash_4 : String
inset_1_slash_4 =
    "inset-1/4"



{- "inset-2/4" -}


inset_2_slash_4 : String
inset_2_slash_4 =
    "inset-2/4"



{- "inset-3/4" -}


inset_3_slash_4 : String
inset_3_slash_4 =
    "inset-3/4"



{- "inset-full" -}


inset_full : String
inset_full =
    "inset-full"



{- "-inset-1/2" -}


n_inset_1_slash_2 : String
n_inset_1_slash_2 =
    "-inset-1/2"



{- "-inset-1/3" -}


n_inset_1_slash_3 : String
n_inset_1_slash_3 =
    "-inset-1/3"



{- "-inset-2/3" -}


n_inset_2_slash_3 : String
n_inset_2_slash_3 =
    "-inset-2/3"



{- "-inset-1/4" -}


n_inset_1_slash_4 : String
n_inset_1_slash_4 =
    "-inset-1/4"



{- "-inset-2/4" -}


n_inset_2_slash_4 : String
n_inset_2_slash_4 =
    "-inset-2/4"



{- "-inset-3/4" -}


n_inset_3_slash_4 : String
n_inset_3_slash_4 =
    "-inset-3/4"



{- "-inset-full" -}


n_inset_full : String
n_inset_full =
    "-inset-full"



{- "inset-x-auto" -}


inset_x_auto : String
inset_x_auto =
    "inset-x-auto"



{- "inset-x-1/2" -}


inset_x_1_slash_2 : String
inset_x_1_slash_2 =
    "inset-x-1/2"



{- "inset-x-1/3" -}


inset_x_1_slash_3 : String
inset_x_1_slash_3 =
    "inset-x-1/3"



{- "inset-x-2/3" -}


inset_x_2_slash_3 : String
inset_x_2_slash_3 =
    "inset-x-2/3"



{- "inset-x-1/4" -}


inset_x_1_slash_4 : String
inset_x_1_slash_4 =
    "inset-x-1/4"



{- "inset-x-2/4" -}


inset_x_2_slash_4 : String
inset_x_2_slash_4 =
    "inset-x-2/4"



{- "inset-x-3/4" -}


inset_x_3_slash_4 : String
inset_x_3_slash_4 =
    "inset-x-3/4"



{- "inset-x-full" -}


inset_x_full : String
inset_x_full =
    "inset-x-full"



{- "-inset-x-1/2" -}


n_inset_x_1_slash_2 : String
n_inset_x_1_slash_2 =
    "-inset-x-1/2"



{- "-inset-x-1/3" -}


n_inset_x_1_slash_3 : String
n_inset_x_1_slash_3 =
    "-inset-x-1/3"



{- "-inset-x-2/3" -}


n_inset_x_2_slash_3 : String
n_inset_x_2_slash_3 =
    "-inset-x-2/3"



{- "-inset-x-1/4" -}


n_inset_x_1_slash_4 : String
n_inset_x_1_slash_4 =
    "-inset-x-1/4"



{- "-inset-x-2/4" -}


n_inset_x_2_slash_4 : String
n_inset_x_2_slash_4 =
    "-inset-x-2/4"



{- "-inset-x-3/4" -}


n_inset_x_3_slash_4 : String
n_inset_x_3_slash_4 =
    "-inset-x-3/4"



{- "-inset-x-full" -}


n_inset_x_full : String
n_inset_x_full =
    "-inset-x-full"



{- "inset-y-auto" -}


inset_y_auto : String
inset_y_auto =
    "inset-y-auto"



{- "inset-y-1/2" -}


inset_y_1_slash_2 : String
inset_y_1_slash_2 =
    "inset-y-1/2"



{- "inset-y-1/3" -}


inset_y_1_slash_3 : String
inset_y_1_slash_3 =
    "inset-y-1/3"



{- "inset-y-2/3" -}


inset_y_2_slash_3 : String
inset_y_2_slash_3 =
    "inset-y-2/3"



{- "inset-y-1/4" -}


inset_y_1_slash_4 : String
inset_y_1_slash_4 =
    "inset-y-1/4"



{- "inset-y-2/4" -}


inset_y_2_slash_4 : String
inset_y_2_slash_4 =
    "inset-y-2/4"



{- "inset-y-3/4" -}


inset_y_3_slash_4 : String
inset_y_3_slash_4 =
    "inset-y-3/4"



{- "inset-y-full" -}


inset_y_full : String
inset_y_full =
    "inset-y-full"



{- "-inset-y-1/2" -}


n_inset_y_1_slash_2 : String
n_inset_y_1_slash_2 =
    "-inset-y-1/2"



{- "-inset-y-1/3" -}


n_inset_y_1_slash_3 : String
n_inset_y_1_slash_3 =
    "-inset-y-1/3"



{- "-inset-y-2/3" -}


n_inset_y_2_slash_3 : String
n_inset_y_2_slash_3 =
    "-inset-y-2/3"



{- "-inset-y-1/4" -}


n_inset_y_1_slash_4 : String
n_inset_y_1_slash_4 =
    "-inset-y-1/4"



{- "-inset-y-2/4" -}


n_inset_y_2_slash_4 : String
n_inset_y_2_slash_4 =
    "-inset-y-2/4"



{- "-inset-y-3/4" -}


n_inset_y_3_slash_4 : String
n_inset_y_3_slash_4 =
    "-inset-y-3/4"



{- "-inset-y-full" -}


n_inset_y_full : String
n_inset_y_full =
    "-inset-y-full"



{- "top-auto" -}


top_auto : String
top_auto =
    "top-auto"



{- "top-1/2" -}


top_1_slash_2 : String
top_1_slash_2 =
    "top-1/2"



{- "top-1/3" -}


top_1_slash_3 : String
top_1_slash_3 =
    "top-1/3"



{- "top-2/3" -}


top_2_slash_3 : String
top_2_slash_3 =
    "top-2/3"



{- "top-1/4" -}


top_1_slash_4 : String
top_1_slash_4 =
    "top-1/4"



{- "top-2/4" -}


top_2_slash_4 : String
top_2_slash_4 =
    "top-2/4"



{- "top-3/4" -}


top_3_slash_4 : String
top_3_slash_4 =
    "top-3/4"



{- "top-full" -}


top_full : String
top_full =
    "top-full"



{- "-top-1/2" -}


n_top_1_slash_2 : String
n_top_1_slash_2 =
    "-top-1/2"



{- "-top-1/3" -}


n_top_1_slash_3 : String
n_top_1_slash_3 =
    "-top-1/3"



{- "-top-2/3" -}


n_top_2_slash_3 : String
n_top_2_slash_3 =
    "-top-2/3"



{- "-top-1/4" -}


n_top_1_slash_4 : String
n_top_1_slash_4 =
    "-top-1/4"



{- "-top-2/4" -}


n_top_2_slash_4 : String
n_top_2_slash_4 =
    "-top-2/4"



{- "-top-3/4" -}


n_top_3_slash_4 : String
n_top_3_slash_4 =
    "-top-3/4"



{- "-top-full" -}


n_top_full : String
n_top_full =
    "-top-full"



{- "right-auto" -}


right_auto : String
right_auto =
    "right-auto"



{- "right-1/2" -}


right_1_slash_2 : String
right_1_slash_2 =
    "right-1/2"



{- "right-1/3" -}


right_1_slash_3 : String
right_1_slash_3 =
    "right-1/3"



{- "right-2/3" -}


right_2_slash_3 : String
right_2_slash_3 =
    "right-2/3"



{- "right-1/4" -}


right_1_slash_4 : String
right_1_slash_4 =
    "right-1/4"



{- "right-2/4" -}


right_2_slash_4 : String
right_2_slash_4 =
    "right-2/4"



{- "right-3/4" -}


right_3_slash_4 : String
right_3_slash_4 =
    "right-3/4"



{- "right-full" -}


right_full : String
right_full =
    "right-full"



{- "-right-1/2" -}


n_right_1_slash_2 : String
n_right_1_slash_2 =
    "-right-1/2"



{- "-right-1/3" -}


n_right_1_slash_3 : String
n_right_1_slash_3 =
    "-right-1/3"



{- "-right-2/3" -}


n_right_2_slash_3 : String
n_right_2_slash_3 =
    "-right-2/3"



{- "-right-1/4" -}


n_right_1_slash_4 : String
n_right_1_slash_4 =
    "-right-1/4"



{- "-right-2/4" -}


n_right_2_slash_4 : String
n_right_2_slash_4 =
    "-right-2/4"



{- "-right-3/4" -}


n_right_3_slash_4 : String
n_right_3_slash_4 =
    "-right-3/4"



{- "-right-full" -}


n_right_full : String
n_right_full =
    "-right-full"



{- "bottom-auto" -}


bottom_auto : String
bottom_auto =
    "bottom-auto"



{- "bottom-1/2" -}


bottom_1_slash_2 : String
bottom_1_slash_2 =
    "bottom-1/2"



{- "bottom-1/3" -}


bottom_1_slash_3 : String
bottom_1_slash_3 =
    "bottom-1/3"



{- "bottom-2/3" -}


bottom_2_slash_3 : String
bottom_2_slash_3 =
    "bottom-2/3"



{- "bottom-1/4" -}


bottom_1_slash_4 : String
bottom_1_slash_4 =
    "bottom-1/4"



{- "bottom-2/4" -}


bottom_2_slash_4 : String
bottom_2_slash_4 =
    "bottom-2/4"



{- "bottom-3/4" -}


bottom_3_slash_4 : String
bottom_3_slash_4 =
    "bottom-3/4"



{- "bottom-full" -}


bottom_full : String
bottom_full =
    "bottom-full"



{- "-bottom-1/2" -}


n_bottom_1_slash_2 : String
n_bottom_1_slash_2 =
    "-bottom-1/2"



{- "-bottom-1/3" -}


n_bottom_1_slash_3 : String
n_bottom_1_slash_3 =
    "-bottom-1/3"



{- "-bottom-2/3" -}


n_bottom_2_slash_3 : String
n_bottom_2_slash_3 =
    "-bottom-2/3"



{- "-bottom-1/4" -}


n_bottom_1_slash_4 : String
n_bottom_1_slash_4 =
    "-bottom-1/4"



{- "-bottom-2/4" -}


n_bottom_2_slash_4 : String
n_bottom_2_slash_4 =
    "-bottom-2/4"



{- "-bottom-3/4" -}


n_bottom_3_slash_4 : String
n_bottom_3_slash_4 =
    "-bottom-3/4"



{- "-bottom-full" -}


n_bottom_full : String
n_bottom_full =
    "-bottom-full"



{- "left-auto" -}


left_auto : String
left_auto =
    "left-auto"



{- "left-1/2" -}


left_1_slash_2 : String
left_1_slash_2 =
    "left-1/2"



{- "left-1/3" -}


left_1_slash_3 : String
left_1_slash_3 =
    "left-1/3"



{- "left-2/3" -}


left_2_slash_3 : String
left_2_slash_3 =
    "left-2/3"



{- "left-1/4" -}


left_1_slash_4 : String
left_1_slash_4 =
    "left-1/4"



{- "left-2/4" -}


left_2_slash_4 : String
left_2_slash_4 =
    "left-2/4"



{- "left-3/4" -}


left_3_slash_4 : String
left_3_slash_4 =
    "left-3/4"



{- "left-full" -}


left_full : String
left_full =
    "left-full"



{- "-left-1/2" -}


n_left_1_slash_2 : String
n_left_1_slash_2 =
    "-left-1/2"



{- "-left-1/3" -}


n_left_1_slash_3 : String
n_left_1_slash_3 =
    "-left-1/3"



{- "-left-2/3" -}


n_left_2_slash_3 : String
n_left_2_slash_3 =
    "-left-2/3"



{- "-left-1/4" -}


n_left_1_slash_4 : String
n_left_1_slash_4 =
    "-left-1/4"



{- "-left-2/4" -}


n_left_2_slash_4 : String
n_left_2_slash_4 =
    "-left-2/4"



{- "-left-3/4" -}


n_left_3_slash_4 : String
n_left_3_slash_4 =
    "-left-3/4"



{- "-left-full" -}


n_left_full : String
n_left_full =
    "-left-full"



-- Background Color (https://tailwindcss.com/docs/background-color)
{- "bg-transparent" -}


bg_transparent : String
bg_transparent =
    "bg-transparent"



{- "bg-current" -}


bg_current : String
bg_current =
    "bg-current"



{- "bg-black" -}


bg_black : String
bg_black =
    "bg-black"



{- "bg-white" -}


bg_white : String
bg_white =
    "bg-white"



{- "bg-gray-50" -}


bg_gray_50 : String
bg_gray_50 =
    "bg-gray-50"



{- "bg-gray-100" -}


bg_gray_100 : String
bg_gray_100 =
    "bg-gray-100"



{- "bg-gray-200" -}


bg_gray_200 : String
bg_gray_200 =
    "bg-gray-200"



{- "bg-gray-300" -}


bg_gray_300 : String
bg_gray_300 =
    "bg-gray-300"



{- "bg-gray-400" -}


bg_gray_400 : String
bg_gray_400 =
    "bg-gray-400"



{- "bg-gray-500" -}


bg_gray_500 : String
bg_gray_500 =
    "bg-gray-500"



{- "bg-gray-600" -}


bg_gray_600 : String
bg_gray_600 =
    "bg-gray-600"



{- "bg-gray-700" -}


bg_gray_700 : String
bg_gray_700 =
    "bg-gray-700"



{- "bg-gray-800" -}


bg_gray_800 : String
bg_gray_800 =
    "bg-gray-800"



{- "bg-gray-900" -}


bg_gray_900 : String
bg_gray_900 =
    "bg-gray-900"



{- "bg-red-50" -}


bg_red_50 : String
bg_red_50 =
    "bg-red-50"



{- "bg-red-100" -}


bg_red_100 : String
bg_red_100 =
    "bg-red-100"



{- "bg-red-200" -}


bg_red_200 : String
bg_red_200 =
    "bg-red-200"



{- "bg-red-300" -}


bg_red_300 : String
bg_red_300 =
    "bg-red-300"



{- "bg-red-400" -}


bg_red_400 : String
bg_red_400 =
    "bg-red-400"



{- "bg-red-500" -}


bg_red_500 : String
bg_red_500 =
    "bg-red-500"



{- "bg-red-600" -}


bg_red_600 : String
bg_red_600 =
    "bg-red-600"



{- "bg-red-700" -}


bg_red_700 : String
bg_red_700 =
    "bg-red-700"



{- "bg-red-800" -}


bg_red_800 : String
bg_red_800 =
    "bg-red-800"



{- "bg-red-900" -}


bg_red_900 : String
bg_red_900 =
    "bg-red-900"



{- "bg-yellow-50" -}


bg_yellow_50 : String
bg_yellow_50 =
    "bg-yellow-50"



{- "bg-yellow-100" -}


bg_yellow_100 : String
bg_yellow_100 =
    "bg-yellow-100"



{- "bg-yellow-200" -}


bg_yellow_200 : String
bg_yellow_200 =
    "bg-yellow-200"



{- "bg-yellow-300" -}


bg_yellow_300 : String
bg_yellow_300 =
    "bg-yellow-300"



{- "bg-yellow-400" -}


bg_yellow_400 : String
bg_yellow_400 =
    "bg-yellow-400"



{- "bg-yellow-500" -}


bg_yellow_500 : String
bg_yellow_500 =
    "bg-yellow-500"



{- "bg-yellow-600" -}


bg_yellow_600 : String
bg_yellow_600 =
    "bg-yellow-600"



{- "bg-yellow-700" -}


bg_yellow_700 : String
bg_yellow_700 =
    "bg-yellow-700"



{- "bg-yellow-800" -}


bg_yellow_800 : String
bg_yellow_800 =
    "bg-yellow-800"



{- "bg-yellow-900" -}


bg_yellow_900 : String
bg_yellow_900 =
    "bg-yellow-900"



{- "bg-green-50" -}


bg_green_50 : String
bg_green_50 =
    "bg-green-50"



{- "bg-green-100" -}


bg_green_100 : String
bg_green_100 =
    "bg-green-100"



{- "bg-green-200" -}


bg_green_200 : String
bg_green_200 =
    "bg-green-200"



{- "bg-green-300" -}


bg_green_300 : String
bg_green_300 =
    "bg-green-300"



{- "bg-green-400" -}


bg_green_400 : String
bg_green_400 =
    "bg-green-400"



{- "bg-green-500" -}


bg_green_500 : String
bg_green_500 =
    "bg-green-500"



{- "bg-green-600" -}


bg_green_600 : String
bg_green_600 =
    "bg-green-600"



{- "bg-green-700" -}


bg_green_700 : String
bg_green_700 =
    "bg-green-700"



{- "bg-green-800" -}


bg_green_800 : String
bg_green_800 =
    "bg-green-800"



{- "bg-green-900" -}


bg_green_900 : String
bg_green_900 =
    "bg-green-900"



{- "bg-blue-50" -}


bg_blue_50 : String
bg_blue_50 =
    "bg-blue-50"



{- "bg-blue-100" -}


bg_blue_100 : String
bg_blue_100 =
    "bg-blue-100"



{- "bg-blue-200" -}


bg_blue_200 : String
bg_blue_200 =
    "bg-blue-200"



{- "bg-blue-300" -}


bg_blue_300 : String
bg_blue_300 =
    "bg-blue-300"



{- "bg-blue-400" -}


bg_blue_400 : String
bg_blue_400 =
    "bg-blue-400"



{- "bg-blue-500" -}


bg_blue_500 : String
bg_blue_500 =
    "bg-blue-500"



{- "bg-blue-600" -}


bg_blue_600 : String
bg_blue_600 =
    "bg-blue-600"



{- "bg-blue-700" -}


bg_blue_700 : String
bg_blue_700 =
    "bg-blue-700"



{- "bg-blue-800" -}


bg_blue_800 : String
bg_blue_800 =
    "bg-blue-800"



{- "bg-blue-900" -}


bg_blue_900 : String
bg_blue_900 =
    "bg-blue-900"



{- "bg-indigo-50" -}


bg_indigo_50 : String
bg_indigo_50 =
    "bg-indigo-50"



{- "bg-indigo-100" -}


bg_indigo_100 : String
bg_indigo_100 =
    "bg-indigo-100"



{- "bg-indigo-200" -}


bg_indigo_200 : String
bg_indigo_200 =
    "bg-indigo-200"



{- "bg-indigo-300" -}


bg_indigo_300 : String
bg_indigo_300 =
    "bg-indigo-300"



{- "bg-indigo-400" -}


bg_indigo_400 : String
bg_indigo_400 =
    "bg-indigo-400"



{- "bg-indigo-500" -}


bg_indigo_500 : String
bg_indigo_500 =
    "bg-indigo-500"



{- "bg-indigo-600" -}


bg_indigo_600 : String
bg_indigo_600 =
    "bg-indigo-600"



{- "bg-indigo-700" -}


bg_indigo_700 : String
bg_indigo_700 =
    "bg-indigo-700"



{- "bg-indigo-800" -}


bg_indigo_800 : String
bg_indigo_800 =
    "bg-indigo-800"



{- "bg-indigo-900" -}


bg_indigo_900 : String
bg_indigo_900 =
    "bg-indigo-900"



{- "bg-purple-50" -}


bg_purple_50 : String
bg_purple_50 =
    "bg-purple-50"



{- "bg-purple-100" -}


bg_purple_100 : String
bg_purple_100 =
    "bg-purple-100"



{- "bg-purple-200" -}


bg_purple_200 : String
bg_purple_200 =
    "bg-purple-200"



{- "bg-purple-300" -}


bg_purple_300 : String
bg_purple_300 =
    "bg-purple-300"



{- "bg-purple-400" -}


bg_purple_400 : String
bg_purple_400 =
    "bg-purple-400"



{- "bg-purple-500" -}


bg_purple_500 : String
bg_purple_500 =
    "bg-purple-500"



{- "bg-purple-600" -}


bg_purple_600 : String
bg_purple_600 =
    "bg-purple-600"



{- "bg-purple-700" -}


bg_purple_700 : String
bg_purple_700 =
    "bg-purple-700"



{- "bg-purple-800" -}


bg_purple_800 : String
bg_purple_800 =
    "bg-purple-800"



{- "bg-purple-900" -}


bg_purple_900 : String
bg_purple_900 =
    "bg-purple-900"



{- "bg-pink-50" -}


bg_pink_50 : String
bg_pink_50 =
    "bg-pink-50"



{- "bg-pink-100" -}


bg_pink_100 : String
bg_pink_100 =
    "bg-pink-100"



{- "bg-pink-200" -}


bg_pink_200 : String
bg_pink_200 =
    "bg-pink-200"



{- "bg-pink-300" -}


bg_pink_300 : String
bg_pink_300 =
    "bg-pink-300"



{- "bg-pink-400" -}


bg_pink_400 : String
bg_pink_400 =
    "bg-pink-400"



{- "bg-pink-500" -}


bg_pink_500 : String
bg_pink_500 =
    "bg-pink-500"



{- "bg-pink-600" -}


bg_pink_600 : String
bg_pink_600 =
    "bg-pink-600"



{- "bg-pink-700" -}


bg_pink_700 : String
bg_pink_700 =
    "bg-pink-700"



{- "bg-pink-800" -}


bg_pink_800 : String
bg_pink_800 =
    "bg-pink-800"



{- "bg-pink-900" -}


bg_pink_900 : String
bg_pink_900 =
    "bg-pink-900"
