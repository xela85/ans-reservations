module Route exposing (Route(..), fromUrl, href)

import Html exposing (Attribute)
import Html.Attributes
import Model.Event as Event
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, int, oneOf, s)


type Route
    = Events
    | Event Event.Id


fromUrl : Url -> Maybe Route
fromUrl url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser


href : Route -> Attribute msg
href targetRoute =
    Html.Attributes.href (routeToString targetRoute)



-- Internal


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Events Parser.top
        , Parser.map Event (s "events" </> Event.urlParser)
        ]


routeToString : Route -> String
routeToString route =
    let
        pieces =
            case route of
                Events ->
                    []

                Event eventId ->
                    [ "events", Event.idToString eventId ]
    in
    "#/" ++ String.join "/" pieces
