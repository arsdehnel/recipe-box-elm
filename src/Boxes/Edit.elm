module Boxes.Edit exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, value, href)
import Boxes.Models exposing (..)
import Boxes.Messages exposing (..)


view : Box -> Html.Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Box -> Html.Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Box -> Html.Html Msg
form box =
    div [ class "m3" ]
        [ h1 [] [ text box.name ]
        , formLevel box
        ]


formLevel : Box -> Html.Html Msg
formLevel box =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString box.level) ]
            , btnLevelDecrease box
            , btnLevelIncrease box
            ]
        ]


btnLevelDecrease : Box -> Html.Html Msg
btnLevelDecrease box =
    a [ class "btn ml1 h1", onClick (ChangeLevel box.id -1) ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Box -> Html.Html Msg
btnLevelIncrease box =
    a [ class "btn ml1 h1", onClick (ChangeLevel box.id 1) ]
        [ i [ class "fa fa-plus-circle" ] [] ]

listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowBoxes
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]        