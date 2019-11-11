module View.Map exposing (map)

import Html exposing (Html)
import LngLat exposing (LngLat)
import Mapbox.Element as Map exposing (id)
import Mapbox.Style exposing (Style(..))
import View.MapStyle.Light as SelectedStyle


map : LngLat -> Html msg
map =
    SelectedStyle.style >> Map.map [ id "my-map" ]
