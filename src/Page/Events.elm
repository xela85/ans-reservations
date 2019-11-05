module Page.Events exposing (display)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Messaging exposing (Message)
import Model exposing (Model)


display : Model -> Html Message
display model =
    div [ class "row" ]
        [ div [ class "col s12 m7" ] (List.map displayEvent model.events) ]


displayEvent : Model.Event -> Html Message
displayEvent event =
    div [ class "row" ]
        [ div [ class "col s12 m7" ]
            [ div [ class "card" ]
                [ div [ class "card-image activator" ]
                    [ img [ src (Model.extractPath event.image) ]
                        []
                    , span [ class "card-title" ]
                        [ text event.name ]
                    , a [ class "btn-floating btn-large halfway-fab waves-effect waves-light red" ]
                        [ i [ class "material-icons" ]
                            [ text "add" ]
                        ]
                    ]
                , div [ class "card-action activator" ]
                    [ a [ href "#", class "dark-text" ]
                        [ text "Plus d'infos" ]
                    ]
                ]
            ]
        ]
