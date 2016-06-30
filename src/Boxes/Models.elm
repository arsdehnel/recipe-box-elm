module Boxes.Models exposing (..)


type alias BoxId =
    Int


type alias Box =
    { id : BoxId
    , name : String
    , level : Int
    }


new : Box
new =
    { id = 0
    , name = ""
    , level = 1
    }