use Mix.Config

config :logger, level: :info

config :moex_helper, MoexHelper.Endpoint,
  server: true,
  version: Mix.Project.config[:version]

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
    task: {MoexHelper.Tasks.CreateCoupons, :call}
  ]
]

import_config "prod.secret.exs"
