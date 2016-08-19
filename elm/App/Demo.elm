module App.Demo
    exposing
        ( init
        , update
        , view
        , subscriptions
        , Model
        , Msg
        )

{-| A demo module showcasing Semantic UI and Elm integration.
-}

import Html
    exposing
        ( Html
        , text
        , h1
        , h2
        , h3
        , section
        , p
        , button
        , div
        , i
        , input
        , a
        , label
        , Attribute
        )
import Html.Attributes exposing (class, type', checked, href)
import Html.Events exposing (onClick, onCheck, targetChecked)


type Msg
    = CheckboxChanged Bool


type alias Model =
    { checkboxChecked : Bool
    }


init : ( Model, Cmd a )
init =
    noFx
        { checkboxChecked = False
        }


update : Msg -> Model -> ( Model, Cmd a )
update action model =
    case action of
        CheckboxChanged checked ->
            noFx <| { model | checkboxChecked = checked }


subscriptions : Model -> Sub Msg
subscriptions =
    always Sub.none


view : Model -> Html Msg
view model =
    section []
        [ h1 [] [ text "Elm Starter Kit" ]
        , p [] [ text "Happy coding! :-)" ]
        , viewCheckboxDemo model
        ]


viewCheckboxDemo : Model -> Html Msg
viewCheckboxDemo model =
    section []
        [ h3 [] [ text "Checkbox demo" ]
        , p []
            [ div [ class "ui checkbox" ]
                [ input
                    [ type' "checkbox"
                    , class "hidden"
                    , checked model.checkboxChecked
                    , onCheck CheckboxChanged
                    ]
                    []
                , label [] [ text "Make my profile visible" ]
                ]
            ]
        , p [] [ text << checkboxDescription <| model.checkboxChecked ]
        ]


noFx : Model -> ( Model, Cmd a )
noFx model =
    ( model, Cmd.none )


actionLabel : Msg -> String
actionLabel action =
    case action of
        CheckboxChanged checked ->
            "Checkbox Changed"


checkboxDescription : Bool -> String
checkboxDescription checked =
    if checked then
        "The checkbox is checked"
    else
        "The checkbox is not checked"
