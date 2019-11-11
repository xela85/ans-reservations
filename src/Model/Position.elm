module Model.Position exposing (Position, decoder)

import Json.Decode exposing (Decoder, field, float, map2, string)
import LngLat exposing (LngLat)


type alias Position =
    { address : String
    , lngLat : LngLat
    }


lngLatDecoder =
    map2 LngLat
        (field "lat" float)
        (field "long" float)


decoder : Decoder Position
decoder =
    map2 Position
        (field "address" string)
        (field "gps" lngLatDecoder)
