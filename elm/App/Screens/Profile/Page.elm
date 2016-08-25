module App.Screens.Profile.Page exposing (..)

import Html exposing (div, h1, form, button, text, Html)
import Html.App
import Html.Attributes exposing (id, type')
import App.Components.Input as Input exposing (defaultProps)


-- Model


type alias Model =
    { pageName : String
    , firstNameModel : Input.Model
    , lastNameModel : Input.Model
    }


initialModel : Model
initialModel =
    { pageName = "Profile"
    , firstNameModel =
        Input.initialModel
            { defaultProps
                | label = "First Name"
                , id = "first-name"
                , initialValue = "Jake"
            }
    , lastNameModel =
        Input.initialModel
            { defaultProps
                | label = "Last Name"
                , id = "last-name"
                , initialValue = "Larson"
            }
    }



-- Messages


type Msg
    = FirstNameInputMsg Input.Msg
    | LastNameInputMsg Input.Msg



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FirstNameInputMsg subMsg ->
            let
                ( updatedInputModel, firstNameCmd ) =
                    Input.update subMsg model.firstNameModel
            in
                ( { model | firstNameModel = updatedInputModel }, Cmd.map FirstNameInputMsg firstNameCmd )

        LastNameInputMsg subMsg ->
            let
                ( updatedInputModel, lastNameCmd ) =
                    Input.update subMsg model.lastNameModel
            in
                ( { model | lastNameModel = updatedInputModel }, Cmd.map LastNameInputMsg lastNameCmd )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (model.pageName ++ "Page") ]
        , form [ id "profile-form" ]
            [ Html.App.map FirstNameInputMsg (Input.view model.firstNameModel)
            , Html.App.map LastNameInputMsg (Input.view model.lastNameModel)
            , button [ type' "submit" ] [ text "Submit" ]
            ]
        ]
