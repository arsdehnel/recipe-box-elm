module Boxes.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import String
import Task
import Boxes.Models exposing (BoxId, Box)
import Boxes.Messages exposing (..)
--import Debug

fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    Debug.log "string" "http://localhost:4000/boxes-simple"

--stringToInt : Decode.Decoder String -> Decode.Decoder Int
--stringToInt d =
--    Decode.customDecoder d String.toInt

collectionDecoder : Decode.Decoder (List Box)
collectionDecoder =
    Decode.list memberDecoder

--collectionDecoder : Decode.Decoder (List Box)
--collectionDecoder =
--    Decode.object1 identity
--      ("data" := Decode.list memberDecoder)


saveUrl : BoxId -> String
saveUrl boxId =
    "http://localhost:4000/boxes-simple/" ++ (toString boxId)


saveTask : Box -> Task.Task Http.Error Box
saveTask box =
    let
        body =
            memberEncoded box
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PATCH"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = saveUrl box.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson memberDecoder


save : Box -> Cmd Msg
save box =
    saveTask box
        |> Task.perform SaveFail SaveSuccess


memberEncoded : Box -> Encode.Value
memberEncoded box =
    let
        list =
            [ ( "id", Encode.int box.id )
            , ( "userId", Encode.int box.userId )
            , ( "name", Encode.string box.name )
            , ( "desc", Encode.string box.desc )
            , ( "order", Encode.int box.order )
            ]
    in
        list
            |> Encode.object        

memberDecoder : Decode.Decoder Box
memberDecoder =
    Decode.object5 Box
        ("id" := Decode.int)
        ("user-id" := Decode.int)
        ("desc" := Decode.string)
        ("name" := Decode.string)
        ("order" := Decode.int)

--memberDecoder : Decode.Decoder Box
--memberDecoder =
--    Decode.object6 Box
--        ("id" := Decode.string |> stringToInt)
--        (Decode.at ["attributes", "user-id"] Decode.int)
--        (Decode.at ["attributes", "name"] Decode.string)
--        (Decode.at ["attributes", "desc"] Decode.string)
--        (Decode.at ["attributes", "read-order"] Decode.int)
--        (Decode.at ["attributes", "status-code"] Decode.string)

--decoder : Decoder Model
--decoder =
--  Decode.object5 Model
--    ("id" := Decode.string |> stringToInt )
--    (Decode.at ["attributes", "invitation_id"] Decode.int)
--    (Decode.at ["attributes", "name"] Decode.string)
--    (Decode.at ["attributes", "provider"] Decode.string)
--    (Decode.at ["attributes", "provider_user_id"] Decode.string |> stringToInt)        