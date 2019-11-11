module Model.Location exposing (Location, decoder)

import Json.Decode exposing (Decoder, field, float, map2, map5, maybe, string)
import LngLat exposing (LngLat)


type alias Location =
    { name : Maybe String
    , street : String
    , postalCode : String
    , city : String
    , lngLat : LngLat
    }


lngLatDecoder =
    map2 LngLat
        (field "long" float)
        (field "lat" float)


decoder : Decoder Location
decoder =
    map5 Location
        (field "name" string |> maybe)
        (field "street" string)
        (field "postalCode" string)
        (field "city" string)
        (field "gps" lngLatDecoder)
