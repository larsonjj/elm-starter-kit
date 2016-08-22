module App.App exposing (..)

import Html exposing (..)
import App.Screens.Home.Home as Home
import App.Screens.Profile.Profile as Profile
import App.Screens.NotFound.NotFound as NotFound
import App.Routing as Routing
import Hop.Types exposing (Location)


-- Model


type alias Model =
    { homeModel : Home.Model
    , profileModel : Profile.Model
    , notFoundModel : NotFound.Model
    , route : Routing.Route
    , location : Location
    }


initialModel : ( Routing.Route, Location ) -> Model
initialModel ( route, location ) =
    { homeModel = Home.initialModel
    , profileModel = Profile.initialModel
    , notFoundModel = NotFound.initialModel
    , route = route
    , location = location
    }


{-|
Your init function will receive an initial payload from Navigation, this payload is the initial matched location.
Here we store the `route` and `location` in our model.
-}
init : ( Routing.Route, Location ) -> ( Model, Cmd Msg )
init ( route, location ) =
    ( initialModel ( route, location ), Cmd.none )



-- Messages


type Msg
    = Nothing



-- View


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Routing.HomeRoute ->
            Home.view model.homeModel

        Routing.ProfileRoute ->
            Profile.view model.profileModel

        Routing.NotFoundRoute ->
            NotFound.view model.notFoundModel



-- Update


update : Msg -> Model -> ( Model, Cmd a )
update a model =
    ( model, Cmd.none )



-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         HomeMsg subMsg ->
--             let
--                 ( updatedHome, cmd ) =
--                     Home.update subMsg model.home
--             in
--                 ( { model | home = updatedhome }, Cmd.none )
--         ProfileMsg subMsg ->
--             let
--                 ( updatedProfile, cmd ) =
--                     Profile.update subMsg model.home
--             in
--                 ( { model | home = updatedhome }, Cmd.map none )
-- Subscriptions


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none
