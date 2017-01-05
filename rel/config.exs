use Mix.Releases.Config,
  default_release: :moex_helper,
  default_environment: :prod

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: "config/prod.secret.cookie" |> File.read! |> String.trim_trailing |> String.to_atom
end

release :moex_helper do
  set version: current_version(:moex_helper)
end
