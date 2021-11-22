module Pages.Cities exposing (Model, init, view)

import Html exposing (div, text)
import Platform.Cmd exposing (Cmd)


type Model
    = NoModel


init : ( Model, Cmd msg )
init =
    ( NoModel, Cmd.none )


view : List (Html.Html msg)
view =
    [ div [] [ text "cities" ] ]
