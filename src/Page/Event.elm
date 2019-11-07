module Page.Event exposing (Model, display, init)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Messaging exposing (Message)
import Model.Event as Event
import Utils.Loading as Loading


type Model
    = Model (Loading.Loading Event.Event)


init : Model
init =
    Model Loading.NotLoaded


display : Model -> Html Message
display model =
    div [ class "row" ]
        [ div [ class "col s12 m7" ] [] ]
