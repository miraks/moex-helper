defmodule MoexHelper.Endpoint do
  use Phoenix.Endpoint, otp_app: :moex_helper

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_moex_helper_key",
    signing_salt: "UValN4iu"

  plug MoexHelper.Router
end
