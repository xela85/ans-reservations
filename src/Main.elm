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
        , div [ class "container" ] [ h1 [] [ text "coucou" ] ]
        , div [ class "row" ]
            [ div [ class "col s12 m7" ] (List.map displayEvent model.events) ]
        ]
    }


displayEvent : Model.Event -> Html Msg
displayEvent event =
    div [ class "row" ]
        [ div [ class "col s12 m7" ]
            [ div [ class "card" ]
                [ div [ class "card-image" ]
                    [ img [ src (Model.extractPath event.image) ]
                        []
                    , span [ class "card-title" ]
                        [ text event.name ]
                    ]
                , div [ class "card-content" ]
                    [ p []
                        [ text event.description ]
                    ]
                , div [ class "card-action" ]
                    [ a [ href "#" ]
                        [ text "This is a link" ]
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
