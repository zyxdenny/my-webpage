module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html
import Url
import Url.Parser exposing (Parser, parse, (</>), int, map, oneOf, s, string)

import Page.Home


-- Route
type Route =
  Home
  | Blog String
  | Photo String
  | Recipe String
  | PageNotFound


routeParser =
  oneOf
    [ map Home (s "home")
    , map Blog (s "blog" </> string)
    , map Photo (s "photo" </> string)
    , map Recipe (s "recipe" </> string)
    ]


toRoute : String -> Route
toRoute string =
  case (Url.fromString string) of
    Nothing ->
      PageNotFound

    Just url ->
      Maybe.withDefault PageNotFound (parse routeParser url)


main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }


type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , route : Route
  }


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  case url.path of
    "/" ->
      ( Model key url Home, Nav.pushUrl key "/home" )

    _ ->
      ( Model key url (toRoute (Url.toString url)), Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      case url.path of
        "/" ->
          ( { model | url = url, route = toRoute (Url.toString url) }
          , Nav.pushUrl model.key "/home"
          )

        _ ->
          ( { model | url = url, route = toRoute (Url.toString url) }
          , Cmd.none
          )


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


view : Model -> Browser.Document msg
view model =
  case model.route of
    Home ->
      Page.Home.view ()

    PageNotFound ->
      { title = "Page Not Found"
      , body = [ Html.div [] [ Html.text "404" ] ]
      }

    Blog _ ->
      { title = "yo"
      , body = [ Html.div [] [ Html.text "Welcome" ] ]
      }

    _ ->
      { title = "yo"
      , body = [ Html.div [] [ Html.text "Welcome" ] ]
      }

