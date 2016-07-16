port module Dice exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { value: Int
  , maxValue: Int
  }

init : (Model, Cmd Msg)
init =
  (Model 1 6, Cmd.none)


-- UPDATE

type Msg
  = Roll
  | NewNumber Int


port roll : Int -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( model, roll model.maxValue )

    NewNumber newValue ->
      let
        newModel = { model | value = newValue }
      in
      ( newModel, Cmd.none )


-- SUBSCRIPTIONS

port randomNumber : (Int -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
  randomNumber NewNumber


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Roll ] [ text "Roll" ]
    , div [] [ toString model.value |> text ]
    ]
