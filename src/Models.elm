module Models exposing (..)

import Players.Models exposing (Player)
import Boxes.Models exposing (Box)
import Routing


type alias Model =
    { players : List Player
    , boxes : List Box
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { players = []
    , boxes = []
    , route = route
    }