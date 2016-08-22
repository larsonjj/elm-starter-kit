module App.Todo exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick)


-- Modal


type alias Model =
    { todo : String
    , todos : List String
    }


init : ( Model, Cmd msg )
init =
    ( { todo = "", todos = [] }, Cmd.none )



-- Messages


type Msg
    = UpdateText String
    | AddTodo
    | RemoveTodo String



-- View


todoListItem : String -> Html Msg
todoListItem todo =
    li []
        [ text todo
        , button [ onClick (RemoveTodo todo) ] [ text "X" ]
        ]


todoList : List String -> Html Msg
todoList todos =
    let
        children =
            List.map todoListItem todos
    in
        ul [] children


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput UpdateText ] []
        , button [ onClick AddTodo ] [ text "Add Todo" ]
        , todoList model.todos
        ]



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateText text ->
            ( { model | todo = text }, Cmd.none )

        AddTodo ->
            ( { model | todos = model.todo :: model.todos }, Cmd.none )

        RemoveTodo todo ->
            ( { model | todos = List.filter (\t -> t /= todo) model.todos }, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
