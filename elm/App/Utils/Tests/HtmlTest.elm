module App.Utils.Tests.HtmlTest exposing (testSuite)

import App.Utils.Html exposing (onlyIf)
import ElmTest exposing (Test, test, suite, assertEqual)
import Html exposing (Html)


testSuite : Test
testSuite =
    suite "App.Utils.Html"
        [ suite "onlyIf"
            [ test "should return an empty Html text node" <|
                assertEqual (Html.text "") (onlyIf False (Html.div [] []))
            , test "should return an Html div" <|
                assertEqual (Html.div [] []) (onlyIf True (Html.div [] []))
            ]
        ]
