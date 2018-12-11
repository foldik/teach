defmodule TeachWeb.PageController do
  use TeachWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
