module App.Components.Toolbox.Checkbox exposing (Model, Msg, Props, defaultProps, initialModel, update, view)

import Html exposing (Html, input, div, text, label, span)
import Html.Attributes exposing (type', checked, placeholder, style, for, name)
import Html.Events exposing (onCheck, onFocus, onBlur)
import App.Utils.Html exposing (onlyIf)


-- Model


type alias Props =
    { id : String
    , class : String
    , type' : String
    , initialChecked : Bool
    , label : String
    , placeholder : String
    , error : String
    }


type alias Model =
    { checked : Bool
    , visited : Bool
    , touched : Bool
    , dirty : Bool
    , props : Props
    }


defaultProps : Props
defaultProps =
    { id = ""
    , class = "checkbox"
    , type' = "checkbox"
    , initialChecked = False
    , label = ""
    , placeholder = ""
    , error = ""
    }


initialModel : Props -> Model
initialModel props =
    { checked = False
    , visited = False
    , touched = False
    , dirty = False
    , props = Maybe.withDefault defaultProps (Just props)
    }



-- Messages


type Msg
    = CheckboxChange Bool
    | CheckboxFocus
    | CheckboxBlur



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckboxChange newChecked ->
            ( { model | checked = newChecked, dirty = True }, Cmd.none )

        CheckboxFocus ->
            ( { model | touched = True }, Cmd.none )

        CheckboxBlur ->
            ( { model | visited = True }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    let
        initialChecked : Bool
        initialChecked =
            if model.checked == False && not model.dirty then
                model.props.initialChecked
            else
                model.checked
    in
        div []
            [ onlyIf (model.props.label /= "") (label [ for model.props.id ] [ text model.props.label ])
            , input
                [ type' model.props.type'
                , name model.props.id
                , placeholder model.props.placeholder
                , checked initialChecked
                , onCheck CheckboxChange
                , onFocus CheckboxFocus
                , onBlur CheckboxBlur
                ]
                []
            , onlyIf (model.props.error /= "") (span [ style [ ( "color", "#c00" ) ] ] [ text model.props.error ])
            ]
