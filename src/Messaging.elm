module Messaging exposing (..)

import Browser exposing (UrlRequest)
import Model exposing (..)
import Url exposing (Url)


type Message
    = NoOp
    | UrlChanged Url
    | GoTo UrlRequest
