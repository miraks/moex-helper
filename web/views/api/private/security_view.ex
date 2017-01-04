defmodule MoexHelper.Api.Private.SecurityView do
  use MoexHelper.Web, :view

  def render("security.json", %{security: security}) do
    %{
      id: security.id,
      isin: security.isin,
      data: security.data
    }
  end
end
