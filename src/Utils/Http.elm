module Utils.Http exposing (viewHttpResult)

import Html exposing (Html)
import Http


viewHttpResult : Result Http.Error a -> (a -> Html msg) -> Html msg
viewHttpResult httpRes mapper =
    case httpRes of
        Err _ ->
            [ text str ]

        Ok data ->
            mapper data
