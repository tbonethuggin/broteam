import Time
import Browser

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type alias Model =
  { workoutCurrent : Workout
  , workoutHistory : List Workout
  }

type alias Date =
  { year : Int
  , month : Int
  , day : Int
  }

dateToString : Date -> String
dateToString date =
  (String.fromInt date.year)
  ++ "-" ++ (String.fromInt date.month)
  ++ "-" ++ (String.fromInt date.day)

type Exercise
  = Lift { name : String, weight : Int, sets : Int, reps : Int }
--  | Cardio { name : String, intensity : Int, length : Int }

type alias Workout =
  { date : Date
  , exercises : List Exercise
  }

newWorkout : Workout
newWorkout =
  Workout (Date 2018 4 1) []

init : () -> (Model, Cmd Msg)
init _ =
  ( Model newWorkout []
  , Cmd.none
  )

type Msg =
  Increment
  | Decrement

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  div []
    [ div [] [ text (dateToString model.workoutCurrent.date) ]
    ]
