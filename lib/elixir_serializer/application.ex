defmodule ElixirSerializer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirSerializerWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:elixir_serializer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirSerializer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirSerializer.Finch},
      # Start a worker by calling: ElixirSerializer.Worker.start_link(arg)
      # {ElixirSerializer.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirSerializerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirSerializer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirSerializerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
