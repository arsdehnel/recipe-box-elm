module Boxes.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Task
import Boxes.Models exposing (BoxId, Box)
import Boxes.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/api/v1/users/1/boxes"


collectionDecoder : Decode.Decoder (List Box)
collectionDecoder =
    Decode.list memberDecoder


saveUrl : BoxId -> String
saveUrl boxId =
    "http://localhost:4000/api/v1/users/1/boxes/" ++ (toString boxId)


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
            , ( "name", Encode.string box.name )
            , ( "level", Encode.int box.level )
            ]
    in
        list
            |> Encode.object        

memberDecoder : Decode.Decoder Box
memberDecoder =
    Decode.object3 Box
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("level" := Decode.int)