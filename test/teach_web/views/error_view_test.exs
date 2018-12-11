defmodule TeachWeb.ErrorViewTest do
  use TeachWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(TeachWeb.ErrorView, "404.html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(TeachWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
