module App.Utils.Html exposing (..)

import Html exposing (Html)


onlyIf : Bool -> Html a -> Html a
onlyIf condition html =
    if condition then
        html
    else
        Html.text ""
