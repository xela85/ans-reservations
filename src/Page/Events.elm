module Page.Events exposing (Model, Msg, display, init)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Model.Event as Event
import Model.Path as Path
import Utils.Loading as Loading


type alias Model =
    { events : Loading.Loading (List Event.Event) }


type Msg
    = NoOp


init : Model
init =
    { events = Loading.NotLoaded }


display : Model -> Html Msg
display model =
    div [ class "row" ]
        [ div [ class "col s12 m7" ]
            (case model.events of
                Loading.Loaded events ->
                    List.map displayEvent events

                Loading.NotLoaded ->
                    []
            )
        ]


displayEvent : Event.Event -> Html Msg
displayEvent event =
    div [ class "row" ]
        [ div [ class "col s12 m7" ]
            [ div [ class "card" ]
                [ div [ class "card-image activator" ]
                    [ img [ src (Path.extractString event.image) ]
                        []
                    , span [ class "card-title" ]
                        [ text event.name ]
                    , a [ class "btn-floating btn-large halfway-fab waves-effect waves-light red" ]
                        [ i [ class "material-icons" ]
                            [ text "add" ]
                        ]
                    ]
                , div [ class "card-action activator" ]
                    [ a [ href ("/events/" ++ Event.idToString event.id), class "dark-text" ]
                        [ text "Plus d'infos" ]
                    ]
                ]
            ]
        ]
