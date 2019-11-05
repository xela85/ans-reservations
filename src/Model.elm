module Model exposing (..)

import Time exposing (Posix)


type Path
    = Path String


extractPath : Path -> String
extractPath (Path a) =
    a


type EventId
    = EventId Int


type alias Event =
    { id : EventId
    , name : String
    , description : String
    , image : Path
    , date : Maybe Posix
    }


type alias Model =
    { page : Page
    , events : List Event
    }


type Page
    = EventsPage
    | EventPage EventId


pageName : Page -> String
pageName page =
    case page of
        EventsPage ->
            "Evénements"

        EventPage _ ->
            "Détail de l'événement"


eventId : EventId
eventId =
    EventId 5


example : Model
example =
    { page = EventsPage
    , events =
        [ { id = EventId 1
          , name = "Evénement de test"
          , description = "Ceci est une description"
          , image = Path "%PUBLIC_URL%/img/ballon.jpg"
          , date = Nothing
          }
        ]
    }
