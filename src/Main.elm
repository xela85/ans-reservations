module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Messaging exposing (..)
import Model exposing (Model, example)
import Navbar exposing (navbar)
import Page.Events
import Url exposing (Url)



---- MODEL ----


init : flags -> Url -> Nav.Key -> ( Model, Cmd Message )
init _ _ _ =
    ( example, Cmd.none )



---- UPDATE ----


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Browser.Document Message
view model =
    { title = Model.pageName model.page
    , body =
        [ navbar
        , Page.Events.display model
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
