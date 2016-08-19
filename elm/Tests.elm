module Tests exposing (testSuite)

import ElmTest exposing (Test, suite)
import String
import App.Tests.SampleTest


testSuite : Test
testSuite =
    suite "All tests"
        [ App.Tests.SampleTest.testSuite
        ]
