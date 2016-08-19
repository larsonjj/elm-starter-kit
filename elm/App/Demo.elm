module App.Demo exposing
  ( init
  , update
  , view
  , subscriptions
  , Model
  , Msg
  )
{-| A demo module showcasing Semantic UI and Elm integration.-}

import Html exposing (Html, text, h1, h2, h3, section, p, button, div, i, input,
  a, label, Attribute)
import Html.Attributes exposing (class, type', checked, href)
import Html.Events exposing (onClick, onCheck, targetChecked)

type Msg =
    ShowDemo
  | HideDemo
  | CheckboxChanged Bool

type alias Model =
  { demoVisible: Bool
  , checkboxChecked: Bool
  }

init : (Model, Cmd a)
init =
  noFx
    { demoVisible = True
    , checkboxChecked = False
    }

update : Msg -> Model -> (Model, Cmd a)
update action model =
  case action of
    ShowDemo -> noFx <| { model | demoVisible = True }
    HideDemo -> noFx <| { model | demoVisible = False }
    CheckboxChanged checked -> noFx <| { model | checkboxChecked = checked }

subscriptions : Model -> Sub Msg
subscriptions = always Sub.none

view : Model -> Html Msg
view model =
  section []
    [ h1 [] [ text "Welcome to Elm App Boilerplate" ]
    , p []
        [ text "This is a demo page of "
        , a [ href "https://github.com/gkubisa/elm-app-boilerplate" ]
            [ text "elm-app-boilerplate" ]
        , text ", which is auto-generated on each release."
        ]
    , p [] [ text "Happy coding! :-)" ]
    , viewDemo model
    ]

viewDemo : Model -> Html Msg
viewDemo model =
  section [] <|
    [ h2 []
        [ text "Semantic UI Demo" ]
    , p []
        [ text """Some examples showing how Semantic UI can integrate with Elm,
          including using Semantic UI modules in the content which is
          dynamically added and removed by Elm."""
        ]
    , p []
        [ button
            [ onClick << hideOrShowMsg <| model ]
            [ text << actionLabel << hideOrShowMsg <| model ]
        ]
    ]
      `List.append`
        if model.demoVisible
          then
            [ viewAccordionDemo model
            , viewCheckboxDemo model
            , viewFlagDemo model
            ]
          else
            []

viewAccordionDemo : Model -> Html Msg
viewAccordionDemo model =
  section []
    [ h3 [] [ text "Accordion Demo" ]
    , p [] [ text """This accordion is managed automatically in the JavaScript
      code of `elm-app-boilerplate` and relies on `MutationObserver` to detected
      when the module needs to be initialized or refreshed.""" ]
    , div [ class "ui styled accordion" ]
      [ div [ class "title" ]
        [ i [ class "dropdown icon" ] []
        , text "What is a dog?"
        ]
      , div [ class "content" ]
        [ p [] [ text """A dog is a type of domesticated animal. Known for its
          loyalty and faithfulness, it can be found as a welcome guest in many
          households across the world.""" ]
        ]
      , div [ class "title" ]
        [ i [ class "dropdown icon" ] []
        , text "What kinds of dogs are there?"
        ]
      , div [ class "content" ]
        [ p [] [ text """There are many breeds of dogs. Each breed varies in
          size and temperament. Owners often select a breed of dog that they
          find to be compatible with their own lifestyle and desires from a
          companion.""" ]
        ]
      , div [ class "title" ]
        [ i [ class "dropdown icon" ] []
        , text "How do you acquire a dog?"
        ]
      , div [ class "content" ]
        [ p [] [ text """Three common ways for a prospective owner to acquire a
          dog is from pet shops, private owners, or shelters.""" ]
        , p [] [ text """A pet shop may be the most convenient way to buy a dog.
          Buying a dog from a private owner allows you to assess the pedigree
          and upbringing of your dog before choosing to take it home. Lastly,
          finding your dog from a shelter, helps give a good home to a dog who
          may not find one so readily.""" ]
        ]
      ]
    ]

viewCheckboxDemo : Model -> Html Msg
viewCheckboxDemo model =
  section []
    [ h3 [] [ text "Checkbox demo" ]
    , p []
      [
        div [ class "ui checkbox" ]
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

viewFlagDemo : Model -> Html Msg
viewFlagDemo model =
  section []
    [ h3 [] [ text "Flags demo" ]
    , p []
        [ i [ class "ie flag" ] []
        , i [ class "france flag" ] []
        , i [ class "pl flag" ] []
        ]
    ]

noFx : Model -> (Model, Cmd a)
noFx model =
  (model, Cmd.none)

hideOrShowMsg : Model -> Msg
hideOrShowMsg model =
  if model.demoVisible
    then HideDemo
    else ShowDemo

actionLabel : Msg -> String
actionLabel action =
  case action of
    ShowDemo -> "Show Demo"
    HideDemo -> "Hide Demo"
    CheckboxChanged checked -> "Checkbox Changed"

checkboxDescription : Bool -> String
checkboxDescription checked =
  if checked
    then "The checkbox is checked"
    else "The checkbox is not checked"
