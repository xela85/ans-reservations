module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html)
import Html.Attributes exposing (..)
import Messaging exposing (..)
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
            ( Events Page.Events.init, Cmd.none )

        Just (Route.Event _) ->
            ( Event Page.Event.init, Cmd.none )

        Nothing ->
            ( NotFound, Cmd.none )



---- UPDATE ----


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


body : Model -> Html Message
body model =
    case model of
        Events eventsModel ->
            Page.Events.display eventsModel

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
