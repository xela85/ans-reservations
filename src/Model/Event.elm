module Model.Event exposing (Event, Id(..), idToString, urlParser)

import Model.Path exposing (Path)
import Time exposing (Posix)
import Url.Parser


type alias Event =
    { id : Id
    , name : String
    , description : String
    , image : Path
    , date : Maybe Posix
    }


type Id
    = Id Int


idToString : Id -> String
idToString (Id int) =
    String.fromInt int


urlParser : Url.Parser.Parser (Id -> a) a
urlParser =
    Url.Parser.custom "EVENTID" (\idStr -> Maybe.map Id (String.toInt idStr))
