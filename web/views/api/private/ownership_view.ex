defmodule MoexHelper.Api.Private.OwnershipView do
  use MoexHelper.Web, :view

  def render("show.json", %{ownership: ownership}) do
    %{ownership: render_one(ownership, __MODULE__, "ownership.json")}
  end

  def render("ownership.json", %{ownership: ownership}) do
    %{
      id: ownership.id,
      amount: ownership.amount,
      price: ownership.price,
      comment: ownership.comment
    }
  end
end
