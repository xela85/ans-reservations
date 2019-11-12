module Model.Session exposing (Session, modifyBasket, new)

import Browser.Navigation as Nav
import Model.Basket as Basket exposing (Basket)
import Model.Event as Event


type alias Session =
    { nav : Nav.Key
    , basket : Basket
    }


new : Nav.Key -> Session
new navKey =
    { nav = navKey
    , basket = Basket.empty
    }


modifyBasket : Session -> (Basket -> Basket) -> Session
modifyBasket session modificator =
    { session | basket = modificator session.basket }
