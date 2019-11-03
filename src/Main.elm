module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model, example)
import Navbar exposing (navbar)
import Url exposing (Url)



---- MODEL ----


init : flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( example, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Réservations"
    , body =
        [ navbar
        , div [ class "row" ]
            [ div [ class "col s12 m7" ] (List.map displayEvent model.events) ]
        ]
    }


displayEvent : Model.Event -> Html Msg
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



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = always NoOp
        , onUrlChange = always NoOp
        }
