defmodule F1GameTelemetry.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: F1GameTelemetry.Worker.start_link(arg)
      # {F1GameTelemetry.Worker, arg}
      {F1GameTelemetry.Listener, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: F1GameTelemetry.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
