module CounterList exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Events exposing (..)

import Counter

-- model definition
type alias Model =
  { counters : List IndexedCounter
  , uid : Int
  }

type alias IndexedCounter =
  { id : Int
  , model : Counter.Model
}

-- actions definitions
type Msg
  = Insert
  | Remove Int
  | Modify Int Counter.Msg

-- init model function
model: Model
model =
  { counters = [], uid = 0 }

update: Msg -> Model -> Model
update msg ({counters, uid} as model) =
  case msg of
    Insert ->
      { model
        | counters = counters ++ [ IndexedCounter uid Counter.model ]
        , uid = uid + 1
      }
    Remove id ->
      { model |
        counters = List.filter (\(counter) -> counter.id /= id) counters
      }
    Modify id msg ->
      case msg of
        Counter.Remove ->
          update (Remove id) model
        _ ->
          { model | counters = List.map (updateHelp id msg) counters }

updateHelp : Int -> Counter.Msg -> IndexedCounter -> IndexedCounter
updateHelp targetId msg { id, model } =
  let
    newModel = if targetId == id then Counter.update msg model else model
  in
    IndexedCounter id newModel

-- view function
view : Model -> Html Msg
view model =
  let
    insert =
      button [ onClick Insert ] [ text "Add" ]

    counters =
      List.map viewIndexedCounter model.counters
  in
    div [] (insert :: counters)

viewIndexedCounter : IndexedCounter -> Html Msg
viewIndexedCounter { id, model } =
  Html.App.map (Modify id) (Counter.viewWithRemove model)

-- glue code
main =
  Html.App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }
