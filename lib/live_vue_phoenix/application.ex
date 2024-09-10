defmodule LiveVuePhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveVuePhoenixWeb.Telemetry,
      LiveVuePhoenix.Repo,
      {DNSCluster, query: Application.get_env(:live_vue_phoenix, :dns_cluster_query) || :ignore},
      {NodeJS.Supervisor, [path: LiveVue.SSR.NodeJS.server_path(), pool_size: 4]},
      {Phoenix.PubSub, name: LiveVuePhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveVuePhoenix.Finch},
      # Start a worker by calling: LiveVuePhoenix.Worker.start_link(arg)
      # {LiveVuePhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveVuePhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveVuePhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveVuePhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
