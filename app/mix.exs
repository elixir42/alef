defmodule Alef.Mixfile do
  use Mix.Project

  def project do
    [app: :alef,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: Alef],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [applications: [:logger, :ibrowse]]
  end

  defp deps do
    [{:tesla, "~> 0.6.0"},
     {:ibrowse, "~> 4.2"}]
  end
end
