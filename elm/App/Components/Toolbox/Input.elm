module App.Components.Toolbox.Input exposing (Model, Msg, Props, defaultProps, initialModel, update, view)

import Html exposing (Html, input, div, text, label, span)
import Html.Attributes exposing (type', value, placeholder, style, for, name)
import Html.Events exposing (onInput, onFocus, onBlur)
import App.Utils.Html exposing (onlyIf)


-- Model


type alias Props =
    { id : String
    , class : String
    , type' : String
    , initialValue : String
    , label : String
    , placeholder : String
    , error : String
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
    , class = "input"
    , type' = "text"
    , initialValue = ""
    , label = ""
    , placeholder = ""
    , error = ""
    }


initialModel : Props -> Model
initialModel props =
    { value = props.initialValue
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
    div []
        [ onlyIf (model.props.label /= "") (label [ for model.props.id ] [ text model.props.label ])
        , input
            [ type' model.props.type'
            , name model.props.id
            , placeholder model.props.placeholder
            , value model.value
            , onInput InputChange
            , onFocus InputFocus
            , onBlur InputBlur
            ]
            []
        , onlyIf (model.props.error /= "") (span [ style [ ( "color", "#c00" ) ] ] [ text model.props.error ])
        ]
