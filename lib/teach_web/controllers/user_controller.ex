defmodule TeachWeb.UserController do
    use TeachWeb, :controller

    def get_user_details(conn, _params) do
        user = 
            %{ username: "Bob", avatar: "/avatar/url", roles: [ "mentor" ] }
        conn
        |> render("show.json", user: user)
    end

end