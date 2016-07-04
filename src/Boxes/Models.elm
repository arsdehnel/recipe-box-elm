module Boxes.Models exposing (..)


type alias BoxId =
    Int

type alias UserId = 
    Int

type alias Box =
    { id : BoxId
    , userid : UserId
    , name : String
    , desc : String
    , readorder : Int
    , statuscode : String
    }


new : Box
new =
    { id = 0
    , userid = 0
    , name = ""
    , desc = "New box"
    , readorder = 9999
    , statuscode = "A"
    }