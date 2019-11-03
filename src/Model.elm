module Model exposing (Event, Model, Path, extractPath, example)

import Time exposing (Posix)


type Path
    = Path String

extractPath: Path -> String
extractPath (Path a) = a

type alias Event =
    { name : String
    , description : String
    , image : Path
    , date : Maybe Posix
    }


type alias Model =
    { events : List Event
    }


example : Model
example =
    { events =
        [ { name = "Evénement de test"
          , description = "Ceci est une description"
          , image = Path "%PUBLIC_URL%/img/ballon.jpg"
          , date = Nothing
          }
        ]   
    }
