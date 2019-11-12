module View.Navbar exposing (navbar)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model.Basket as Basket
import Model.Session exposing (Session)
import Route


navbar : Session -> Html a
navbar session =
    div [ class "navbar-fixed" ]
        [ nav []
            [ div [ class "nav-wrapper" ]
                [ a [ href "#", class "brand-logo center" ]
                    [ text "Logo" ]
                , ul [ id "nav-mobile", class "left hide-on-med-and-down" ]
                    [ li []
                        [ a [ Route.href Route.Events ]
                            [ text "Evénements" ]
                        ]
                    ]
                , ul [ class "right hide-on-med-and-down" ]
                    [ li []
                        [ a [ href "sass.html" ]
                            [ i [ class "material-icons left" ]
                                [ text "shopping_basket" ]
                            , Basket.size session.basket |> String.fromInt |> text
                            ]
                        ]
                    ]
                ]
            ]
        ]
