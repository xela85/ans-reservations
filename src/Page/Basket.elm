module Page.Events exposing (Model, Msg, display, init, update)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Model.Event as Event
import Model.Loading as Loading
import Model.Path as Path
import Model.Session exposing (Session)
import Route
import View.Image exposing (image)


type alias Model =
    { session : Session, events : Loading.Loading (List Event.Event) }


type Msg
    = GotEvents (Loading.Loading (List Event.Event))


init : Nav.Key -> ( Model, Cmd Msg )
init session =
    ( { session = session, events = Loading.NotLoaded }, Event.fetchById id (Loading.fromHttpResult >> GotEvent) )


fetchBasket : Basket -> Cmd Msg
fetchBasket basket =
    Cmd.batch (List.map (\event -> Event.fetchById event.id Loading.fromHttpResult) (Basket.items basket))


update : Model -> Msg -> Model
update model msg =
    case msg of
        GotEvents events ->
            { model | events = events }


display : Model -> Html Msg
display model =
    div []
        [ h2 [] [ text "Liste des événements" ]
        , Loading.display model.events (List.map displayEvent >> div [ class "row" ])
        ]


displayEvent : Event.Event -> Html Msg
displayEvent event =
    div [ class "col l4 m6 s12" ]
        [ div [ class "card event-card" ]
            [ div [ class "card-image activator" ]
                [ image [] event.image
                , span [ class "card-title" ]
                    [ text event.name ]
                , a [ class "btn-floating btn-large halfway-fab waves-effect waves-light red" ]
                    [ i [ class "material-icons" ]
                        [ text "add" ]
                    ]
                ]
            , div [ class "card-action activator" ]
                [ a [ Route.href (Route.Event event.id), class "dark-text" ]
                    [ text "Plus d'infos" ]
                ]
            ]
        ]
