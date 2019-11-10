module Page.NotFound exposing (display)

import Html exposing (..)
import Html.Attributes exposing (..)


display : Html msg
display =
    div [ class "row" ]
        [ div [ class "col s12 m7" ] [ h1 [] [ text "Page non trouvée" ] ] ]
