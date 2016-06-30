module Messages exposing (..)


import Players.Messages
import Boxes.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
    | BoxesMsg Boxes.Messages.Msg