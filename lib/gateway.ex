defmodule Annon do
  @moduledoc """
  This is an entry point of Annons application.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Annon.DB.Configs.Repo, []),
      supervisor(Annon.DB.Logger.Repo, []),
      http_endpoint_spec(Annon.ManagementRouter, :management_http),
      http_endpoint_spec(Annon.PublicRouter, :public_http),
      http_endpoint_spec(Annon.PrivateRouter, :private_http),
      worker(Annon.AutoClustering, [])
    ]

    opts = [strategy: :one_for_one, name: Annon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp http_endpoint_spec(router, config) do
    Plug.Adapters.Cowboy.child_spec(:http, router, [], Confex.get_map(:gateway, config))
  end
end
