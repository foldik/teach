import Browser
import Browser.Navigation
import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing(..)
import Url
import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string)
import Route exposing (Route)

main =
    Browser.application 
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }

-- MODEL

type Page 
    = NotFound
    | Login
    | Home
    | Students
    | Courses

type alias Model = 
    { page : Page
    , name : String
    , key : Browser.Navigation.Key
    , url : Url.Url
    }

init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model (getPage (Route.toRoute url)) "Init text" key url, Cmd.none )

getPage : Route -> Page
getPage route =
    case route of
        Route.Login ->
            Login
        Route.Home ->
            Home
        Route.Students ->
            Students
        Route.Courses ->
            Courses
        Route.NotFound ->
            NotFound
            
-- UPDATE

type Msg 
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NameChanged String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )
            
                Browser.External href ->
                    ( model, Browser.Navigation.load href )
    
        UrlChanged url ->
            ( { model | url = url, page = (getPage (Route.toRoute url)) }
            , Cmd.none
            )
        NameChanged newName ->
            ( { model | name = newName }
            , Cmd.none
            )

-- VIEW

view : Model -> Browser.Document Msg
view model =
    { title = "Title"
    , body = 
        [ navBar model
        , input [ onInput NameChanged ] []
        , pageView model
        ]
    }

-- NAVBAR

navBar : Model -> Html Msg
navBar model =
    div [] 
        [ ul [] 
            [ navItem Login model.page
            , navItem Home model.page 
            , navItem Students model.page
            , navItem Courses model.page
            , li [] [ text model.name ]
            ]
        ]

navItem : Page -> Page -> Html Msg 
navItem page actualPage = 
    let
        (name, link, active) =
            case page of
                NotFound ->
                    ("Not found", "/not-found", page == actualPage)
                Login ->
                    ("Login", "/login", page == actualPage)
                Home -> 
                    ("Home", "/", page == actualPage)
                Students ->
                    ("Students", "/students", page == actualPage)
                Courses ->
                    ("Courses", "/courses", page == actualPage)
    in
        li [] 
            [ a [ href link, style "color" ( if active then "red" else "blue" ) ] [ text name ] ]

-- PAGE VIEW

pageView : Model -> Html Msg
pageView model =
    let
        pageText =
            case model.page of
                NotFound ->
                    "Not found"
                Login ->
                    "Login"
                Home ->
                    "Home"
                Students ->
                    "Students"
                Courses ->
                    "Courses"   
    in
        div [] [ text pageText ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- COMMANDS
-- JSON
