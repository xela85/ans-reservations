module Navbar exposing (navbar)

import Html exposing (..)
import Html.Attributes exposing (..)
import Route


navbar : Html a
navbar =
    nav []
        [ div [ class "nav-wrapper" ]
            [ a [ href "#", class "brand-logo center" ]
                [ text "Logo" ]
            , ul [ id "nav-mobile", class "left hide-on-med-and-down" ]
                [ li []
                    [ a [ Route.href Route.Events ]
                        [ text "Evénements" ]
                    ]
                ]
            ]
        ]
