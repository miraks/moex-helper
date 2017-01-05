use Mix.Releases.Config,
  default_release: :moex_helper,
  default_environment: :prod

environment :prod do
  set include_erts: true
  set include_src: false
end

release :moex_helper do
  set version: current_version(:moex_helper)
end
