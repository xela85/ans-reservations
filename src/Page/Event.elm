module Page.Event exposing (Model, Msg, display, init, update)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Model.Event as Event
import Model.Path as Path
import Route
import Utils.Loading as Loading
import View.Image exposing (fullWidthImage)


type alias Model =
    { navKey : Nav.Key
    , event : Loading.Loading (Maybe Event.Event)
    }


type Msg
    = GotEvent (Loading.Loading (Maybe Event.Event))


init : Nav.Key -> Event.Id -> ( Model, Cmd Msg )
init navKey id =
    ( { navKey = navKey, event = Loading.NotLoaded }, Event.fetchById id (Loading.fromHttpResult >> GotEvent) )


update : Model -> Msg -> Model
update model msg =
    case msg of
        GotEvent event ->
            { model | event = event }


display : Model -> Html Msg
display model =
    Loading.display model.event displayEvent


displayEvent : Maybe Event.Event -> Html Msg
displayEvent maybeEvent =
    div []
        (case maybeEvent of
            Just event ->
                [ fullWidthImage event.image
                , div [ class "container" ] [ h1 [] [ text event.name ] ]
                ]

            Nothing ->
                [ text "L'évènement recherché n'a pas été trouvé" ]
        )
