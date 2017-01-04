defmodule MoexHelper.Mixfile do
  use Mix.Project

  def project do
    [
      app: :moex_helper,
      version: "0.1.0",
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases,
      deps: deps
    ]
  end

  def application do
    [
      mod: {MoexHelper, []},
      applications: [
        :phoenix, :cowboy, :logger, :phoenix_ecto, :postgrex, :httpoison, :con_cache, :quantum, :swoosh, :gen_smtp,
        :timex
      ]
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
      {:httpoison, "~> 0.10.0"},
      {:con_cache, "~> 0.11.1"},
      {:quantum, "~> 1.8"},
      {:swoosh, "~> 0.4.0"},
      {:timex, "~> 3.1"},
      {:credo, "~> 0.5.3", only: [:dev, :test]}
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
