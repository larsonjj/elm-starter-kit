module Main exposing (..)

import Navigation
import App.App as App
import App.Routing as Routing
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)


{-|
Create a URL Parser for Navigation
Here we take `.href` from `Navigation.location` and send this to `Hop.matchUrl`.
`matchUrl` returns a tuple: (matched route, Hop location record). e.g.
    (User 1, { path = ["users", "1"], query = Dict.empty })
-}
urlParser : Navigation.Parser ( Routing.Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl Routing.routerConfig)


{-|
Navigation will call urlUpdate when the location changes.
This function gets the result from `urlParser`, which is a tuple with (Route, Hop.Types.Location)
Location is a record that has:
```elm
{
  path: List String,
  query: Hop.Types.Query
}
```
- `path` is an array of string that has the current path e.g. `["users", "1"]` for `"/users/1"`
- `query` Is dictionary of String String. You can access this information in your views to show the content.
Store these two things in the model. We store location because it is needed for matching a query string.
-}
urlUpdate : ( Routing.Route, Hop.Types.Location ) -> App.Model -> ( App.Model, Cmd App.Msg )
urlUpdate ( route, location ) model =
    ( { model | route = route, location = location }, Cmd.none )


main : Program Never
main =
    Navigation.program urlParser
        { init = App.init
        , view = App.view
        , update = App.update
        , urlUpdate = urlUpdate
        , subscriptions = App.subscriptions
        }
