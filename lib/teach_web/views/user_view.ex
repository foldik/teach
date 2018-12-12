defmodule TeachWeb.UserView do
    use TeachWeb, :view

    def render("show.json", %{ user: user }) do
        user
    end
end