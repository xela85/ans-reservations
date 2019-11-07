module Main exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Html exposing (Html)
import Html.Attributes exposing (..)
import Model.Event as Event
import Navbar exposing (navbar)
import Page.Event
import Page.Events
import Page.NotFound
import Route
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, int, map, oneOf, s, top)



---- MODEL ----


type Model
    = Events Page.Events.Model
    | Event Page.Event.Model
    | NotFound


init : flags -> Url -> Nav.Key -> ( Model, Cmd Message )
init _ url _ =
    handleRouteSelection (Route.fromUrl url)


handleRouteSelection : Maybe Route.Route -> ( Model, Cmd Message )
handleRouteSelection maybeRoute =
    case maybeRoute of
        Just Route.Events ->
            let
                ( m, load ) =
                    Page.Events.init
            in
            ( Events m, Cmd.map GotEventsMsg load )

        Just (Route.Event _) ->
            ( Event Page.Event.init, Cmd.none )

        Nothing ->
            ( NotFound, Cmd.none )



---- UPDATE ----


type Message
    = NoOp
    | UrlChanged Url
    | GoTo UrlRequest
    | GotEventsMsg Page.Events.Msg


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case ( model, msg ) of
        ( Events eventsModel, GotEventsMsg a ) ->
            ( Page.Events.update eventsModel a, Cmd.none ) |> updateWith Events GotEventsMsg model

        ( _, UrlChanged url ) ->
            handleRouteSelection (Route.fromUrl url)

        ( _, _ ) ->
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Message) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Message )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )



---- VIEW ----


body : Model -> Html Message
body model =
    case model of
        Events eventsModel ->
            Html.map GotEventsMsg (Page.Events.display eventsModel)

        Event eventModel ->
            Page.Event.display eventModel

        NotFound ->
            Page.NotFound.display


pageName : Model -> String
pageName model =
    case model of
        Events _ ->
            "Evénements"

        Event eventId ->
            "Détails de l'événement "

        NotFound ->
            "Page non trouvée"


view : Model -> Browser.Document Message
view model =
    { title = pageName model
    , body =
        [ navbar
        , body model
        ]
    }



---- PROGRAM ----


main : Program () Model Message
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = GoTo
        , onUrlChange = UrlChanged
        }
