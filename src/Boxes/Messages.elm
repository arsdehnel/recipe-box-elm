module Boxes.Messages exposing (..)


import Http
import Boxes.Models exposing (BoxId, Box)


type Msg
    = FetchAllDone (List Box)
    | FetchAllFail Http.Error
    | ShowBoxes
    | ShowBox BoxId
    | ChangeLevel BoxId Int
    | SaveSuccess Box
    | SaveFail Http.Error    