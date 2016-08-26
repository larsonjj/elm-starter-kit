module App.Components.Toolbox.Dropdown exposing (Model, Msg, Props, defaultProps, initialModel, update, view)

import Html exposing (Html, select, div, text, label, span, option)
import Html.Attributes exposing (type', value, placeholder, style, for, name, selected)
import Html.Events exposing (onInput, onFocus, onBlur)
import App.Utils.Html exposing (onlyIf)


-- Model


type alias Option =
    { label : String, value : String }


type alias Options =
    List Option


type alias Props =
    { id : String
    , class : String
    , initialValue : String
    , label : String
    , placeholder : String
    , error : String
    , options : Options
    }


type alias Model =
    { value : String
    , visited : Bool
    , touched : Bool
    , dirty : Bool
    , props : Props
    }


defaultProps : Props
defaultProps =
    { id = ""
    , class = "dropdown"
    , initialValue = ""
    , label = ""
    , placeholder = ""
    , error = ""
    , options = [ { label = "Select", value = "" } ]
    }


initialModel : Props -> Model
initialModel props =
    { value = ""
    , visited = False
    , touched = False
    , dirty = False
    , props = Maybe.withDefault defaultProps (Just props)
    }



-- Messages


type Msg
    = InputChange String
    | InputFocus
    | InputBlur



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChange newVal ->
            ( { model | value = newVal, dirty = True }, Cmd.none )

        InputFocus ->
            ( { model | touched = True }, Cmd.none )

        InputBlur ->
            ( { model | visited = True }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    let
        initialValue : String
        initialValue =
            if model.value == "" && not model.dirty then
                model.props.initialValue
            else
                model.value

        options : List (Html Msg)
        options =
            renderOptions initialValue model.props.options
    in
        div []
            [ onlyIf (model.props.label /= "") (label [ for model.props.id ] [ text model.props.label ])
            , select
                [ name model.props.id
                , placeholder model.props.placeholder
                , value initialValue
                , onInput InputChange
                , onFocus InputFocus
                , onBlur InputBlur
                ]
                options
            , onlyIf (model.props.error /= "") (span [ style [ ( "color", "#c00" ) ] ] [ text model.props.error ])
            ]


renderOptions : String -> Options -> List (Html Msg)
renderOptions initialValue options =
    let
        toggle index option =
            if option.value == initialValue then
                renderOption True option
            else
                renderOption False option
    in
        List.indexedMap toggle options


renderOption : Bool -> Option -> Html a
renderOption selected' { label, value } =
    option [ Html.Attributes.value value, selected selected' ] [ text label ]
