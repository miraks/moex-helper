use Mix.Config

config :moex_helper,
  ecto_repos: [MoexHelper.Repo]

config :moex_helper, MoexHelper.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MoexHelper.ErrorView, accepts: ~w(json)]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :generators,
  binary_id: true

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  issuer: "MoexHelper",
  ttl: {1, :year},
  verify_issuer: true,
  secret_key: File.read!("config/#{Mix.env}.secret.key"),
  serializer: MoexHelper.GuardianSerializer

config :quantum, cron: [
  security_sync: [
    schedule: "@hourly",
    task: {MoexHelper.Tasks.SyncSecurities, :call}
  ],
  email_stats: [
    schedule: "10 7 * * *",
    task: {MoexHelper.Tasks.EmailStats, :call}
  ],
  create_coupons: [
    schedule: "10 6 * * *",
    task: {MoexHelper.Tasks.CreareCoupons, :call}
  ]
]

import_config "#{Mix.env}.exs"
