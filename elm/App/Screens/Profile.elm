module App.Screens.Profile exposing (..)

import Html exposing (div, h1, form, button, text, Html)
import Html.App
import Html.Attributes exposing (id, type')
import App.Components.Toolbox.Input as Input
import App.Components.Toolbox.Checkbox as Checkbox
import App.Components.Toolbox.Dropdown as Dropdown
import App.Components.Toolbox.RadioGroup as RadioGroup


-- Model


type alias Model =
    { pageName : String
    , firstNameModel : Input.Model
    , lastNameModel : Input.Model
    , employedModel : Checkbox.Model
    , platformModel : Dropdown.Model
    , genderModel : RadioGroup.Model
    }


inputDefaultProps : Input.Props
inputDefaultProps =
    Input.defaultProps


checkboxDefaultProps : Checkbox.Props
checkboxDefaultProps =
    Checkbox.defaultProps


dropdownDefaultProps : Dropdown.Props
dropdownDefaultProps =
    Dropdown.defaultProps


radioGroupDefaultProps : RadioGroup.Props
radioGroupDefaultProps =
    RadioGroup.defaultProps


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
    , platformModel =
        Dropdown.initialModel
            { dropdownDefaultProps
                | label = "Employed"
                , id = "employed"
                , options =
                    [ { label = "Select platform", value = "" }
                    , { label = "iOS", value = "ios" }
                    , { label = "Android", value = "android" }
                    ]
            }
    , genderModel =
        RadioGroup.initialModel
            { radioGroupDefaultProps
                | label = "Gender"
                , name = "gender"
                , initialValue = "male"
                , options =
                    [ { label = "Male", value = "male" }
                    , { label = "Female", value = "female" }
                    , { label = "Other", value = "other" }
                    ]
            }
    }



-- Messages


type Msg
    = FirstNameInputMsg Input.Msg
    | LastNameInputMsg Input.Msg
    | EmployedCheckBoxMsg Checkbox.Msg
    | PlatformDropdownMsg Dropdown.Msg
    | GenderRadioGroupMsg RadioGroup.Msg



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

        PlatformDropdownMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    Dropdown.update subMsg model.platformModel
            in
                ( { model | platformModel = newModel }, Cmd.map PlatformDropdownMsg newCmd )

        GenderRadioGroupMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    RadioGroup.update subMsg model.genderModel
            in
                ( { model | genderModel = newModel }, Cmd.map GenderRadioGroupMsg newCmd )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (model.pageName ++ "Page") ]
        , form [ id "profile-form" ]
            [ Html.App.map FirstNameInputMsg (Input.view model.firstNameModel)
            , Html.App.map LastNameInputMsg (Input.view model.lastNameModel)
            , Html.App.map EmployedCheckBoxMsg (Checkbox.view model.employedModel)
            , Html.App.map PlatformDropdownMsg (Dropdown.view model.platformModel)
            , Html.App.map GenderRadioGroupMsg (RadioGroup.view model.genderModel)
            , button [ type' "submit" ] [ text "Submit" ]
            ]
        ]
