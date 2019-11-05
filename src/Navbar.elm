module Navbar exposing (navbar)

import Html exposing (..)
import Html.Attributes exposing (..)


navbar : Html a
navbar =
    nav []
        [ div [ class "nav-wrapper" ]
            [ a [ href "#", class "brand-logo center" ]
                [ text "Logo" ]
            , ul [ id "nav-mobile", class "left hide-on-med-and-down" ]
                [ li []
                    [ a [ href "sass.html" ]
                        [ text "Sass" ]
                    ]
                , li []
                    [ a [ href "badges.html" ]
                        [ text "Components" ]
                    ]
                , li []
                    [ a [ href "collapsible.html" ]
                        [ text "JavaScript" ]
                    ]
                ]
            ]
        ]
