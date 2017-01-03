defmodule MoexHelper.SecurityAction.Search do
  alias MoexHelper.ISS.Client

  @columns ~W(isin shortname name emitent_title)

  def call(query) do
    Client.search(query, @columns)
  end
end
