module Page.Events exposing (display)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Messaging exposing (Message)
import Model exposing (Model)


display : Model -> Html Message
display model =
    div [ class "row" ]
        [ div [ class "col s12 m7" ] [] ]
