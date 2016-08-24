module App.Components.Input.Input exposing (Model, initialModel, update, view, Msg)

import Html exposing (Html, input, div, text)
import Html.Attributes exposing (type', value)
import Html.Events exposing (onInput)


-- Model


type alias Model =
    { value : String
    }


initialModel : Model
initialModel =
    { value = ""
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- Messages


type Msg
    = InputChange String



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChange newVal ->
            ( { model | value = newVal }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    input
        [ type' "text"
        , value model.value
        , onInput InputChange
        ]
        []
