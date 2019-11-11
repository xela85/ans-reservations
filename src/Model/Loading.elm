module Model.Loading exposing (Loading(..), display, fromHttpResult)

import Html exposing (..)
import Html.Attributes exposing (class)
import Http exposing (Error(..))


type Loading a
    = NotLoaded
    | Loaded a
    | Error String


fromHttpResult : Result Http.Error a -> Loading a
fromHttpResult result =
    case result of
        Ok data ->
            Loaded data

        Err err ->
            Error ("Impossible de charger les données : " ++ httpErrorToString err)


httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        BadUrl url ->
            "l'URL" ++ url ++ "est invalide."

        Timeout ->
            "le serveur n'a pas répondu à temps"

        NetworkError ->
            "problème réseau"

        BadStatus _ ->
            "erreur de la part du serveur"

        BadBody errorMessage ->
            errorMessage


display : Loading a -> (a -> Html msg) -> Html msg
display loading mapper =
    case loading of
        NotLoaded ->
            div [ class "center-align preloader-wrapper big active" ]
                [ div [ class "spinner-layer spinner-green-only" ]
                    [ div [ class "circle-clipper left" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "gap-patch" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    , div [ class "circle-clipper right" ]
                        [ div [ class "circle" ]
                            []
                        ]
                    ]
                ]

        Error str ->
            div [ class "container" ]
                [ div [ class "card-panel red white-text" ]
                    [ h3 [] [ text "Une erreur a été rencontrée" ]
                    , p [] [ b [] [ text "Veuillez contacter l'administrateur en lui fournissant les informations ci-dessous." ] ]
                    , span []
                        [ text str ]
                    ]
                ]

        Loaded data ->
            mapper data
