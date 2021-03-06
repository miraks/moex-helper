defmodule MoexHelper.Mixfile do
  use Mix.Project

  def project do
    [
      app: :moex_helper,
      version: "0.2.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {MoexHelper, []},
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  defp deps do
    [
      {:phoenix, "~> 1.2.1"},
      {:phoenix_ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 3.0"},
      {:guardian, "~> 0.14.0"},
      {:poison, "~> 2.0"},
      {:httpoison, "~> 0.11.0"},
      {:con_cache, "~> 0.12.0"},
      {:quantum, "~> 1.8"},
      {:swoosh, "~> 0.5.0"},
      {:gen_smtp, "~> 0.11.0"},
      {:timex, "~> 3.1"},
      {:distillery, "~> 1.1", runtime: false},
      {:credo, "~> 0.5.3", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
