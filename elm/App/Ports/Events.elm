port module Ports exposing (..)

{--USAGE

See README.md #Dispatch/Respond section

--}
-- dispatchSomeMessage will create a command with a
-- string payload representing an important message
-- to broadcast to listening components.


port dispatch : String -> Cmd msg



-- receiveSomeMessage is the port which our components
-- subscribe to receive the dispatched message


port respond : (String -> msg) -> Sub msg
