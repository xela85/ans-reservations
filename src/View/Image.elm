module View.Image exposing (fullWidthImage, image)

import Html exposing (div, img)
import Html.Attributes exposing (class, src)
import Model.Path as Path exposing (Path)


image : List (Html.Attribute msg) -> Path -> Html.Html msg
image attributes path =
    img (attributes ++ [ Path.extractString path |> src ]) []


fullWidthImage : Path -> Html.Html msg
fullWidthImage path =
    div [ class "full-width-container" ] [ image [] path ]
