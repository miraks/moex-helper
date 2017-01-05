use Mix.Config

config :logger, level: :info

config :moex_helper, MoexHelper.Endpoint,
  server: true,
  version: Mix.Project.config[:version]

import_config "prod.secret.exs"
