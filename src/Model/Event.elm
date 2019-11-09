module Model.Event exposing (Event, Id(..), fetchAll, idToString, urlParser)

import Http
import Json.Decode exposing (Decoder, field, int, list, map4, string)
import Model.Path exposing (Path(..))
import Time exposing (Posix)
import Url.Parser


type alias Event =
    { id : Id
    , name : String
    , description : String
    , image : Path
    }


type Id
    = Id Int


idToString : Id -> String
idToString (Id int) =
    String.fromInt int


urlParser : Url.Parser.Parser (Id -> a) a
urlParser =
    Url.Parser.custom "EVENTID" (\idStr -> Maybe.map Id (String.toInt idStr))


decoder : Decoder Event
decoder =
    map4 Event
        (Json.Decode.map Id (field "id" int))
        (field "name" string)
        (field "description" string)
        (Json.Decode.map Path (field "image" string))


fetch : Id -> (Result Http.Error (Maybe Event) -> msg) -> Cmd msg
fetch id eventBuilder =
    Result.map (Cmd.map eventBuilder) (fetchAll (\a -> a))

getById: Id -> List Event -> Maybe Event
getById id = List.filter (\element -> element.id == id)


fetchAll : (Result Http.Error (List Event) -> msg) -> Cmd msg
fetchAll eventBuilder =
    Http.get
        { url = "%PUBLIC_URL%/events.json"
        , expect = Http.expectJson eventBuilder (list decoder)
        }
