defmodule Keebs.MixProject do
  use Mix.Project

  def project do
    [
      app: :keebs,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/grandafrato/keebs"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:rustler, "~> 0.25.0"}
    ]
  end

  defp description() do
    "A library to poll for the current state of the keyboard and mouse."
  end

  defp package() do
    [
      licenses: ["MIT"],
      files: ~w(lib priv .formatter.exs mix.exs README* LICENSE* native),
      links: %{"Github" => "https://github.com/grandafrato/keebs"}
    ]
  end
end
