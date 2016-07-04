module Boxes.Update exposing (..)

import Navigation
import Boxes.Messages exposing (Msg(..))
import Boxes.Models exposing (Box)
import Boxes.Commands exposing (save)
import Boxes.Models exposing (Box, BoxId)

update : Msg -> List Box -> ( List Box, Cmd Msg )
update action boxes =
    case action of
        FetchAllDone newBoxes ->
            ( newBoxes, Cmd.none )

        FetchAllFail error ->
            ( boxes, Cmd.none )

        ShowBoxes ->
            ( boxes, Navigation.modifyUrl "#boxes" )

        ShowBox id ->
            ( boxes, Navigation.modifyUrl ("#boxes/" ++ (toString id)) )

        ChangeLevel id howMuch ->
            ( boxes, changeLevelCommands id howMuch boxes |> Cmd.batch )

        SaveSuccess updatedBox ->
            ( updateBox updatedBox boxes, Cmd.none )

        SaveFail error ->
            ( boxes, Cmd.none )

changeLevelCommands : BoxId -> Int -> List Box -> List (Cmd Msg)
changeLevelCommands boxId howMuch =
    let
        cmdForBox existingBox =
            if existingBox.id == boxId then
                save { existingBox | readOrder = existingBox.readOrder + howMuch }
            else
                Cmd.none
    in
        List.map cmdForBox

updateBox : Box -> List Box -> List Box
updateBox updatedBox =
    let
        select existingBox =
            if existingBox.id == updatedBox.id then
                updatedBox
            else
                existingBox
    in
        List.map select        