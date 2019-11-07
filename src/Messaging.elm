module Messaging exposing (..)

import Browser exposing (UrlRequest)
import Page.Events
import Url exposing (Url)


type Message
    = NoOp
    | UrlChanged Url
    | GoTo UrlRequest
    | GotEventsMsg Page.Events.Msg
