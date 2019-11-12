module Model.Basket exposing (Basket, addToBasket, empty, size)

import Model.Event as Event


type Basket
    = Basket (List Event.Id)


empty : Basket
empty =
    Basket []


size : Basket -> Int
size (Basket list) =
    List.length list


items : Basket -> List Event.Id
items (Basket list) =
    list


addToBasket : Event.Id -> Basket -> Basket
addToBasket eventId (Basket list) =
    eventId :: list |> Basket
