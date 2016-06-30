module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update
import Boxes.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
            let
                ( updatedPlayers, cmd ) =
                    Players.Update.update subMsg model.players
            in
                ( { model | players = updatedPlayers }, Cmd.map PlayersMsg cmd )
        BoxesMsg subMsg ->
            let
                ( updatedBoxes, cmd ) =
                    Boxes.Update.update subMsg model.boxes
            in
                ( { model | boxes = updatedBoxes }, Cmd.map BoxesMsg cmd )