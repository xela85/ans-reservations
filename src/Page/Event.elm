module Page.Event exposing (Model, Msg, display, init, update)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Mapbox.Cmd.Option as Opt
import Maybe.Extra exposing (toList)
import Model.Basket as Basket
import Model.Event as Event
import Model.Loading as Loading
import Model.Location exposing (Location)
import Model.Path as Path
import Model.Session as Session exposing (Session)
import Port.MapCommands as MapCommands
import View.Image exposing (fullWidthImage)
import View.Map


type alias Model =
    { session : Session
    , event : Loading.Loading (Maybe Event.Event)
    }


type Msg
    = GotEvent (Loading.Loading (Maybe Event.Event))
    | AddedToBasket Event.Event


init : Session -> Event.Id -> ( Model, Cmd Msg )
init session id =
    ( { session = session, event = Loading.NotLoaded }, Event.fetchById id (Loading.fromHttpResult >> GotEvent) )


update : Model -> Msg -> ( Model, Cmd Msg )
update model msg =
    let
        newModel =
            case msg of
                GotEvent event ->
                    { model | event = event }

                AddedToBasket event ->
                    { model | session = Session.modifyBasket model.session (Basket.addToBasket event.id) }
    in
    ( newModel, Cmd.none )


display : Model -> Html Msg
display model =
    Loading.display model.event viewEvent


viewEvent : Maybe Event.Event -> Html Msg
viewEvent maybeEvent =
    div []
        (case maybeEvent of
            Just event ->
                [ fullWidthImage event.image
                , div [ class "container" ]
                    [ h1 [] [ text event.name ]
                    , viewPrice event
                    , p [] [ text event.description ]
                    , viewEventLocation event.location
                    ]
                ]

            Nothing ->
                [ text "L'évènement recherché n'a pas été trouvé" ]
        )


viewPrice : Event.Event -> Html Msg
viewPrice event =
    div [ class "price-container" ]
        [ span [ class "price" ] [ String.fromFloat event.price ++ " €" |> text ]
        , button [ AddedToBasket event |> onClick, class "waves-effect waves-light btn blue" ]
            [ i [ class "material-icons left" ]
                [ text "shopping_basket" ]
            , text "Ajouter au panier"
            ]
        , button [ class "waves-effect waves-light btn green" ]
            [ i [ class "material-icons left" ]
                [ text "credit_card" ]
            , text "Achat instantané"
            ]
        ]


viewEventLocation : Location -> Html Msg
viewEventLocation position =
    h3 [] [ text "Lieu" ]
        :: toList (Maybe.map (\elem -> b [] [ text elem, br [] [] ]) position.name)
        ++ [ text position.street
           , br [] []
           , position.postalCode ++ " " ++ position.city |> text
           , div [ class "map-container" ] [ View.Map.map position.lngLat ]
           ]
        |> div []
