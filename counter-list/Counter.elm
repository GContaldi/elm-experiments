module Counter exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

-- model definition
type alias Model = Int

-- actions definitions
type Msg
  = Increment
  | Decrement
  | Remove

-- init model function
model : Model
model =
  0

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1
    Decrement ->
      model - 1
    Remove ->
      model

-- view with remove function
viewWithRemove : Model -> Html Msg
viewWithRemove model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [
        style [ ("display", "inline") ]
      ] [ toString model |> text ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Remove ] [ text "Remove" ]
    ]
