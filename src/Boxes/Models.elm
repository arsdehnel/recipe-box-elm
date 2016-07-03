module Boxes.Models exposing (..)


type alias BoxId =
    Int

type alias UserId = 
    Int

type alias Box =
    { id : BoxId
    , userId : UserId
    , name : String
    , desc : String
    , readOrder : Int
    , statusCode : String
    }


new : Box
new =
    { id = 0
    , userId = 0
    , name = ""
    , desc = "New box"
    , readOrder = 9999
    , statusCode = "A"
    }