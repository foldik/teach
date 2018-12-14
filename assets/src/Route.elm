module Route exposing (Route(..), toRoute)

import Url exposing (Url)
import Url.Parser exposing (Parser, parse, oneOf, map, top, s)

type Route
    = Home
    | Login
    | Students 
    | Courses
    | NotFound

routes : Parser (Route -> a) a
routes =
    oneOf
        [ map Home top
        , map Login (s "login")
        , map Students (s "students")
        , map Courses (s "courses")
        ]

toRoute : Url -> Route
toRoute url =
    Maybe.withDefault NotFound (parse routes url)