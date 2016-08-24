module App.Screens.Profile.Profile exposing (..)

import Html exposing (div, h1, form, button, text, Html)
import Html.App
import Html.Attributes exposing (id, type')
import App.Components.Input.Input as Input


-- Model


type alias Model =
    { pageName : String
    , inputModel : Input.Model
    }


initialModel : Model
initialModel =
    { pageName = "Profile"
    , inputModel = Input.initialModel
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- Messages


type Msg
    = InputMsg Input.Msg



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputMsg subMsg ->
            let
                ( updatedInputModel, inputCmd ) =
                    Input.update subMsg model.inputModel
            in
                ( { model | inputModel = updatedInputModel }, Cmd.map InputMsg inputCmd )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (model.pageName ++ "Page") ]
        , form [ id "profile-form" ]
            [ Html.App.map InputMsg (Input.view model.inputModel)
            , button [ type' "submit" ] [ text "Submit" ]
            ]
        ]
