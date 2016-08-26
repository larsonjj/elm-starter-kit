module App.Components.Toolbox.RadioGroup exposing (Model, Msg, Props, defaultProps, initialModel, update, view)

import Html exposing (Html, input, div, text, label, span, option)
import Html.Attributes exposing (type', value, placeholder, style, for, name, checked, id)
import Html.Events exposing (onInput, onFocus, onBlur)
import App.Utils.Html exposing (onlyIf)


-- Model


type alias Option =
    { label : String, value : String }


type alias Options =
    List Option


type alias Props =
    { id : String
    , name : String
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
    , name = "radio"
    , class = "radio"
    , initialValue = ""
    , label = ""
    , placeholder = ""
    , error = ""
    , options =
        [ { label = "Radio 1", value = "value1" }
        , { label = "Radio 2", value = "value2" }
        ]
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

        radios : List (Html Msg)
        radios =
            renderOptions ( model.props.name, initialValue ) model.props.options
    in
        div []
            [ onlyIf (model.props.label /= "") (label [ for model.props.id ] [ text model.props.label ])
            , div [] radios
            , onlyIf (model.props.error /= "") (span [ style [ ( "color", "#c00" ) ] ] [ text model.props.error ])
            ]


renderOptions : ( String, String ) -> Options -> List (Html Msg)
renderOptions ( id', initialValue ) options =
    let
        toggle index option =
            if option.value == initialValue then
                renderOption ( id', index, True ) option
            else
                renderOption ( id', index, False ) option
    in
        List.indexedMap toggle options


renderOption : ( String, Int, Bool ) -> Option -> Html Msg
renderOption ( id', index, checked' ) option =
    div []
        [ input
            [ id (id' ++ (toString index))
            , name id'
            , checked checked'
            , value option.value
            , type' "radio"
            , onInput InputChange
            , onFocus InputFocus
            , onBlur InputBlur
            ]
            []
        , onlyIf (option.label /= "") (label [ for id' ] [ text option.label ])
        ]
