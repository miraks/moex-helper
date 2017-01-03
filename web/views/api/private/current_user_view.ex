defmodule MoexHelper.Api.Private.CurrentUserView do
  use MoexHelper.Web, :view

  alias MoexHelper.Api.Private.AccountView

  def render("show.json", %{current_user: current_user}) do
    %{current_user: render_one(current_user, __MODULE__, "current_user.json")}
  end

  def render("current_user.json", %{current_user: current_user}) do
    %{
      id: current_user.id,
      email: current_user.email,
      accounts: render_many(current_user.accounts, AccountView, "account.json")
    }
  end
end
