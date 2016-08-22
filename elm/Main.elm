module Main exposing (..)

import Html.App
import App.Todo as Todo


main : Program Never
main =
    Html.App.program
        { init = Todo.init
        , view = Todo.view
        , update = Todo.update
        , subscriptions = Todo.subscriptions
        }
