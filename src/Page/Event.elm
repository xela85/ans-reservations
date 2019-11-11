module Page.Event exposing (Model, Msg, display, init, update)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Mapbox.Cmd.Option as Opt
import Model.Event as Event
import Model.Loading as Loading
import Model.Path as Path
import Port.MapCommands as MapCommands
import View.Image exposing (fullWidthImage)
import View.Map


type alias Model =
    { navKey : Nav.Key
    , event : Loading.Loading (Maybe Event.Event)
    }


type Msg
    = GotEvent (Loading.Loading (Maybe Event.Event))
    | Click


init : Nav.Key -> Event.Id -> ( Model, Cmd Msg )
init navKey id =
    ( { navKey = navKey, event = Loading.NotLoaded }, Event.fetchById id (Loading.fromHttpResult >> GotEvent) )


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    case msg of
        GotEvent event ->
            ( { model | event = event }, Cmd.none )

        Click ->
            ( model, Cmd.none )


display : Model -> Html Msg
display model =
    Loading.display model.event displayEvent


displayEvent : Maybe Event.Event -> Html Msg
displayEvent maybeEvent =
    div []
        (case maybeEvent of
            Just event ->
                [ fullWidthImage event.image
                , div [ class "container" ]
                    [ h1 [ onClick Click ] [ text event.name ]
                    , p [] [ text event.description ]
                    , a [ class "waves-effect waves-light btn blue" ]
                        [ i [ class "material-icons left" ]
                            [ text "shopping_basket" ]
                        , "Ajouter au panier pour " ++ String.fromFloat event.price ++ " €" |> text
                        ]
                    , h3 [] [ text "Lieu" ]
                    , View.Map.map event.position.lngLat
                    ]
                ]

            Nothing ->
                [ text "L'évènement recherché n'a pas été trouvé" ]
        )
