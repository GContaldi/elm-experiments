module Counter exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Events exposing (..)


-- model definition
type alias Model = Int

-- actions definitions
type Msg
  = Increment
  | Decrement

-- init model function
model: Model
model =
  0

update: Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1
    Decrement ->
      model - 1

-- view function
view: Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ toString model |> text ]
    , button [ onClick Increment ] [ text "+" ]
    ]

main =
  Html.App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
