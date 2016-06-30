module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)
import Players.Models exposing (PlayerId)
import Boxes.Models exposing (BoxId)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | BoxesRoute
    | BoxRoute BoxId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format BoxesRoute (s "")
        , format PlayerRoute (s "players" </> int)
        , format PlayersRoute (s "players")
        , format BoxRoute (s "players" </> int)
        , format BoxesRoute (s "boxes")
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute