module Tests exposing (testSuite)

import ElmTest exposing (Test, suite)
import App.Utils.Tests.HtmlTest


testSuite : Test
testSuite =
    suite "All tests"
        [ App.Utils.Tests.HtmlTest.testSuite
        ]
