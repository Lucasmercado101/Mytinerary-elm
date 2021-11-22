module Pages.Cities exposing (Model, init, view)

import Html exposing (div, h1, text)
import Html.Attributes exposing (class)
import Platform.Cmd exposing (Cmd)


type Model
    = NoModel


init : ( Model, Cmd msg )
init =
    ( NoModel, Cmd.none )


view : Html.Html msg
view =
    div []
        [ h1 [ class "has-text-centered title" ] [ text "Cities" ]
        ]
