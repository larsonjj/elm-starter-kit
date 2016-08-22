module App.Routing exposing (..)

import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)


--Hop.Matchers exposes functions for building route matchers

import Hop.Matchers exposing (..)


-- ROUTES


{-|
Define your routes as union types
You need to provide a route for when the current URL doesn't match any known route i.e. NotFoundRoute
-}
type Route
    = HomeRoute
    | ProfileRoute
    | NotFoundRoute


{-|
Define matchers
For example:
    match1 AboutRoute "/about"
Will match "/about" and return AboutRoute
    match2 UserRoute "/users/" int
Will match "/users/1" and return (UserRoute 1)
`int` is a matcher that matches only integers, for a string use `str` e.g.
    match2 UserRoute "/users/" str
Would match "/users/abc"
-}
matchers : List (PathMatcher Route)
matchers =
    [ match1 HomeRoute ""
    , match1 ProfileRoute "/profile"
    ]


{-|
Define your router configuration
Use `hash = True` for hash routing e.g. `#/users/1`
Use `hash = False` for push state e.g. `/users/1`
The `basePath` is only used for path routing.
This is useful if you application is not located at the root of a url e.g. `/app/v1/users/1` where `/app/v1` is the base path.
- `matchers` is your list of matchers defined above.
- `notFound` is a route that will be returned when the path doesn't match any known route.
-}
routerConfig : Config Route
routerConfig =
    { hash = True
    , basePath = ""
    , matchers = matchers
    , notFound = NotFoundRoute
    }



-- MESSAGES


{-|
Add messages for navigation and changing the query
-}
type Msg
    = NavigateTo String
    | SetQuery Query



-- MODEL


{-|
Add route and location to your model.
- `Location` is a `Hop.Types.Location` record (not Navigation.Location)
- `Route` is your Route union type
This is needed because:
- Some navigation functions in Hop need this information to rebuild the current location.
- Your views will need information about the current route.
- Your views might need information about the current query string.
-}
type alias Model =
    { location : Location
    , route : Route
    }
