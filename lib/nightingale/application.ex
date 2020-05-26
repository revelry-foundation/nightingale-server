defmodule Nightingale.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    setup()

    # Define workers and child supervisors to be supervised
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Nightingale.PubSub},
      # Start the Ecto repository
      supervisor(Nightingale.Repo, []),
      # Start the endpoint when the application starts
      supervisor(NightingaleWeb.Endpoint, []),
      # Start your own worker by calling: Nightingale.Worker.start_link(arg1, arg2, arg3)
      # worker(Nightingale.Worker, [arg1, arg2, arg3]),
      {Cluster.Supervisor, [cluster_topologies(), [name: Nightingale.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nightingale.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NightingaleWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp cluster_topologies do
    enabled = Application.get_env(:nightingale, :cluster_enabled)
    topologies = Application.get_env(:nightingale, :cluster_topologies)

    if enabled, do: topologies, else: []
  end

  defp setup do
    NightingaleWeb.PipelineInstrumenter.setup()
    NightingaleWeb.Repo.Instrumenter.setup()
    Prometheus.Registry.register_collector(:prometheus_process_collector)
    NightingaleWeb.MetricsExporter.setup()

    :ok =
      :telemetry.attach(
        "prometheus-ecto",
        [:nightingale, :repo, :query],
        &NightingaleWeb.Repo.Instrumenter.handle_event/4,
        %{}
      )
  end
end
