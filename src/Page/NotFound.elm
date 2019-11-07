module Page.NotFound exposing (display)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Messaging exposing (Message)


display : Html Message
display =
    div [ class "row" ]
        [ div [ class "col s12 m7" ] [ h1 [] [ text "Page non trouvée" ] ] ]
