module App.Screens.Profile.Profile exposing (..)

import Html exposing (..)


-- Model


type alias Model =
    { pageName : String
    }


initialModel : Model
initialModel =
    { pageName = "Profile"
    }


init : ( Model, Cmd a )
init =
    ( initialModel, Cmd.none )



-- View


view : Model -> Html div
view model =
    div [] [ text (model.pageName ++ "Page") ]
