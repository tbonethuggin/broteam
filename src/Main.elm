import Time
import Task
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
  { workoutCurrent : Maybe Workout
  , workoutHistory : List Workout
  , timeZone : Time.Zone
  , currentDate : Maybe Date
  }

type alias Date =
  { year : Int
  , month : Int
  , day : Int
  }

posixToDate : Time.Zone -> Time.Posix -> Date
posixToDate zone posix =
  Date
    (Time.toYear zone posix)
    (monthToInt (Time.toMonth zone posix))
    (Time.toDay zone posix)

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

newWorkout : Date -> Workout
newWorkout date =
  Workout date []


monthToInt : Time.Month -> Int
monthToInt month =
  case month of
    Time.Jan -> 1
    Time.Feb -> 2
    Time.Mar -> 3
    Time.Apr -> 4
    Time.May -> 5
    Time.Jun -> 6
    Time.Jul -> 7
    Time.Aug -> 8
    Time.Sep -> 9
    Time.Oct -> 10
    Time.Nov -> 11
    Time.Dec -> 12

init : () -> (Model, Cmd Msg)
init _ =
  ( Model Maybe.Nothing [] Time.utc Maybe.Nothing
  , Task.perform SetTimeZone Time.here
  )

type Msg =
  SetTimeZone Time.Zone
  | SetTime Time.Posix

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetTimeZone newTimeZone ->
      ( { model | timeZone = newTimeZone }
      , Task.perform SetTime Time.now
      )
    SetTime currentTime ->
      let
        date = posixToDate model.timeZone currentTime
      in
        ( { model | currentDate = Maybe.Just date, workoutCurrent = Maybe.Just (newWorkout date) }
        , Cmd.none
        )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  let
    dateStr = case model.currentDate of
      Nothing ->
        ""
      Just date ->
        dateToString date
  in
    div []
      [ div [] [ text dateStr ]
      ]
