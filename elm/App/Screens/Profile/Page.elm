module App.Screens.Profile.Page exposing (..)

import Html exposing (div, h1, form, button, text, Html)
import Html.App
import Html.Attributes exposing (id, type')
import App.Components.Input as Input
import App.Components.Checkbox as Checkbox


-- Model


type alias Model =
    { pageName : String
    , firstNameModel : Input.Model
    , lastNameModel : Input.Model
    , employedModel : Checkbox.Model
    }


inputDefaultProps : Input.Props
inputDefaultProps =
    Input.defaultProps


checkboxDefaultProps : Checkbox.Props
checkboxDefaultProps =
    Checkbox.defaultProps


initialModel : Model
initialModel =
    { pageName = "Profile"
    , firstNameModel =
        Input.initialModel
            { inputDefaultProps
                | label = "First Name"
                , id = "first-name"
                , initialValue = "Jake"
            }
    , lastNameModel =
        Input.initialModel
            { inputDefaultProps
                | label = "Last Name"
                , id = "last-name"
                , initialValue = "Larson"
            }
    , employedModel =
        Checkbox.initialModel
            { checkboxDefaultProps
                | label = "Employed"
                , id = "employed"
                , initialChecked = False
            }
    }



-- Messages


type Msg
    = FirstNameInputMsg Input.Msg
    | LastNameInputMsg Input.Msg
    | EmployedCheckBoxMsg Checkbox.Msg



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FirstNameInputMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    Input.update subMsg model.firstNameModel
            in
                ( { model | firstNameModel = newModel }, Cmd.map FirstNameInputMsg newCmd )

        LastNameInputMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    Input.update subMsg model.lastNameModel
            in
                ( { model | lastNameModel = newModel }, Cmd.map LastNameInputMsg newCmd )

        EmployedCheckBoxMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    Checkbox.update subMsg model.employedModel
            in
                ( { model | employedModel = newModel }, Cmd.map EmployedCheckBoxMsg newCmd )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (model.pageName ++ "Page") ]
        , form [ id "profile-form" ]
            [ Html.App.map FirstNameInputMsg (Input.view model.firstNameModel)
            , Html.App.map LastNameInputMsg (Input.view model.lastNameModel)
            , Html.App.map EmployedCheckBoxMsg (Checkbox.view model.employedModel)
            , button [ type' "submit" ] [ text "Submit" ]
            ]
        ]
