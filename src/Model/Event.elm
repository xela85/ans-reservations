module Model.Event exposing (Event, Id(..), fetchAll, fetchById, idToString, urlParser)

import Http
import Json.Decode exposing (Decoder, field, float, int, list, map6, string)
import LngLat
import Model.Path exposing (Path(..))
import Model.Position as Position exposing (Position)
import Time exposing (Posix)
import Url.Parser


type alias Event =
    { id : Id
    , name : String
    , description : String
    , position : Position
    , price : Float
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
    map6 Event
        (Json.Decode.map Id (field "id" int))
        (field "name" string)
        (field "description" string)
        (field "position" Position.decoder)
        (field "price" float)
        (Json.Decode.map Path (field "image" string))


fetchById : Id -> (Result Http.Error (Maybe Event) -> msg) -> Cmd msg
fetchById id eventBuilder =
    let
        getById =
            List.filter (\element -> element.id == id) >> List.head
    in
    Cmd.map (Result.map getById >> eventBuilder) (fetchAll identity)


fetchAll : (Result Http.Error (List Event) -> msg) -> Cmd msg
fetchAll eventBuilder =
    Http.get
        { url = "%PUBLIC_URL%/events.json"
        , expect = Http.expectJson eventBuilder (list decoder)
        }
