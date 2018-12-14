import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Http
import Json.Decode exposing (Decoder, map2, field, string, list)


main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view 
    }


-- MODEL

type alias UserDetails = 
  { username : String
  , roles : List String
  }

type Model 
  = Loading
  | Failure
  | Loaded UserDetails
  

init : () -> (Model, Cmd Msg)
init _ =
  (Loading, getUserDetails)


-- UPDATE

type Msg = GotUserDetails (Result Http.Error UserDetails)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotUserDetails result ->
      case result of
        Ok userDetails ->
          (Loaded userDetails, Cmd.none)
        
        Err _ ->
          (Failure, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW

view : Model -> Html Msg
view model =
  case model of
      Loading ->
        div [] [ text "Loading" ]
  
      Failure ->
        div [] [ text "Application couldn't start. :(" ]

      Loaded userDetails ->
        div []
          [ menuView userDetails ]


menuView : UserDetails -> Html Msg
menuView userDetails = 
  nav [ classList [("navbar", True), ("is-primary", True)] ]
    [ div [ class "navbar-brand" ] 
        [ a [ classList [("navbar-burger", True), ("burger", True)]] 
            [ span [] [] 
            , span [] []
            , span [] []
            ]
        ]
    , div [ class "navbar-menu" ]
        [ div [ class "navbar-start" ]
            [ a [ class "navbar-item" ] [ text "Home" ] ]
        , div [ class "navbar-end" ]
            [ span [ class "navbar-item" ] [ text userDetails.username ]
            , div [ class "navbar-item" ]
                [ div [ class "buttons" ] 
                    [ a [ classList [("button", True), ("is-light", True)] ] [ text "Log out" ] ] 
                ] 
            ] 
        ] 
    ]


-- HTTP

getUserDetails : Cmd Msg
getUserDetails = 
  Http.get
      { url = "/api/user-details"
      , expect = Http.expectJson GotUserDetails userDetailsDecoder 
      }

userDetailsDecoder : Decoder UserDetails
userDetailsDecoder =
  map2 UserDetails
    (field "username" string)
    (field "roles" (list string))