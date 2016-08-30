# Elm Notes

## Architecture

### Submodules

#### Input.elm

##### Current Implementation

***State***

- Manages own state within `Model`


***Props***

- Does not manage props within `Model.props`
- Props passed through to `Component.init`

##### Ideal Implementation

***State***

- Does not manage own state within `State`
    - `State` is just a type annotation and record to be used by Parent
- State passed through to `Component.init`

***Props***

- Does not manage props (aka config)
- config passed through to `Component.view`

Example Parent:

```elm
import Input

-- Model

inputState : Input.State
inputState =
    Input.initialState


type alias Model =
    { inputState : Input.State
    }


init : ( Model, Cmd Msg )
init =
    (
        { inputState: { inputState | value: "Some val" }
        }
    )


-- UPDATE


type Msg
  = SetInputState Input.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetInputState newState ->
      ( { model | inputState = newState }
      , Cmd.none
      )

-- VIEW


view : Model -> Html Msg
view { inputState } =
  div []
    [
      h1 [] [ text "Example Form" ]
      Input.view inputConfig inputState
    ]


inputConfig : Input.Config Msg
inputConfig =
  Input.config
    { messages: (SetInputState)
    }
```

Example Child:

```elm
module Input exposing (State, Config, view, config, initialState)

-- STATE


type State =
    { value : String
    , visited : Bool
    , touched : Bool
    , dirty : Bool
    , error: String
    }


initialState : State
initialState =
    { value : ""
    , visited : False
    , touched : False
    , dirty : False
    , error: ""
    }



-- CONFIG

type Config (inputMsg, focusMsg, blurMsg) =
    { messages = (State -> inputMsg, State -> focusMsg, State -> blurMsg)
    }


-- VIEW


view : Model -> Html Msg
view { config, state } =
    let
        (inputMsg, focusMsg, blurMsg) =
            config.messages
    in
    div []
        [
            input [
                value state.value 
                , onInput inputMsg
                , onFocus focusMsg
                , onBlur blurMsg
            ] 
            []
        ]

```
