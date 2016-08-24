module App.Components.Checkbox.Checkbox exposing (..)

import Html exposing (..)


-- Model


type alias Model =
    { component : String
    }


initialModel : Model
initialModel =
    { component = "Checkbox"
    }


init : ( Model, Cmd a )
init =
    ( initialModel, Cmd.none )



-- View


view : Model -> Html div
view model =
    div [] [ text (model.component ++ "Component") ]
