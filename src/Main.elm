module Main exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Debug
import Html exposing (Html)
import Html.Attributes exposing (..)
import Model.Event
import Page.Event
import Page.Events
import Page.NotFound
import Route
import Url exposing (Url)
import View.Navbar exposing (navbar)



---- MODEL ----


type Model
    = Events Page.Events.Model
    | Event Page.Event.Model
    | NotFound Nav.Key


init : flags -> Url -> Nav.Key -> ( Model, Cmd Message )
init _ url navKey =
    handleRouteSelection navKey (Route.fromUrl url)


handleRouteSelection : Nav.Key -> Maybe Route.Route -> ( Model, Cmd Message )
handleRouteSelection navKey maybeRoute =
    case maybeRoute of
        Just Route.Events ->
            let
                ( m, load ) =
                    Page.Events.init navKey
            in
            ( Events m, Cmd.map GotEventsMsg load )

        Just (Route.Event eventId) ->
            let
                ( m, load ) =
                    Page.Event.init navKey eventId
            in
            ( Event m, Cmd.map GotEventMsg load )

        Nothing ->
            ( NotFound navKey, Cmd.none )


toNavKey : Model -> Nav.Key
toNavKey model =
    case model of
        Events eventsModel ->
            eventsModel.navKey

        Event eventModel ->
            eventModel.navKey

        NotFound navKey ->
            navKey



---- UPDATE ----


type Message
    = UrlChanged Url
    | GoTo UrlRequest
    | GotEventsMsg Page.Events.Msg
    | GotEventMsg Page.Event.Msg


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case ( model, msg ) of
        ( Events eventsModel, GotEventsMsg a ) ->
            ( Page.Events.update eventsModel a, Cmd.none ) |> updateWith Events GotEventsMsg model

        ( Event eventModel, GotEventMsg a ) ->
            ( Page.Event.update eventModel a, Cmd.none ) |> updateWith Event GotEventsMsg model

        ( _, UrlChanged url ) ->
            handleRouteSelection (toNavKey model) (Route.fromUrl url)

        ( _, GoTo (Browser.Internal url) ) ->
            case url.fragment of
                Nothing ->
                    -- If we got a link that didn't include a fragment,
                    -- it's from one of those (href "") attributes that
                    -- we have to include to make the RealWorld CSS work.
                    --
                    -- In an application doing path routing instead of
                    -- fragment-based routing, this entire
                    -- `case url.fragment of` expression this comment
                    -- is inside would be unnecessary.
                    ( model, Cmd.none )

                Just _ ->
                    ( model
                    , Nav.pushUrl (toNavKey model) (Url.toString url)
                    )

        ( _, GoTo (Browser.External href) ) ->
            ( model, Nav.load href )

        ( _, _ ) ->
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Message) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Message )
updateWith toModel toMsg _ ( subModel, subCmd ) =
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
            Html.map GotEventMsg (Page.Event.display eventModel)

        NotFound _ ->
            Page.NotFound.display


pageName : Model -> String
pageName model =
    case model of
        Events _ ->
            "Evénements"

        Event _ ->
            "Détails de l'événement"

        NotFound _ ->
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
