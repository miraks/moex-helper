defmodule MoexHelper.ErrorViewTest do
  use MoexHelper.ConnCase, async: true

  import Phoenix.View

  test "renders 404.json" do
    assert render(MoexHelper.ErrorView, "404.json", []) ==
           %{errors: %{detail: "Page not found"}}
  end

  test "render 500.json" do
    assert render(MoexHelper.ErrorView, "500.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end

  test "render any other" do
    assert render(MoexHelper.ErrorView, "505.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end
end
