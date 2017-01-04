defmodule MoexHelper.Api.Private.OwnershipController do
  use MoexHelper.Web, :controller

  alias MoexHelper.OwnershipAction.Create
  alias MoexHelper.ErrorView

  def index(conn, _params) do
    ownerships = conn |> current_resource |> assoc(:ownerships) |> Repo.all
    render(conn, "index.json", ownerships: ownerships)
  end

  def create(conn, %{"ownership" => ownership_params}) do
    current_user = current_resource(conn)

    case Create.call(current_user, ownership_params) do
      {:ok, ownership} ->
        render(conn, "show.json", ownership: ownership)
      {:error, _changeset} ->
        conn
        |> put_status(400)
        |> render(ErrorView, "400.json")
    end
  end
end
