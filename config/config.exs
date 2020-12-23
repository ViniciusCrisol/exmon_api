use Mix.Config

config :ex_mon,
  ecto_repos: [ExMon.Repo]

config :ex_mon, ExMonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/AZYHD62FfnkoOOJPCYbsn4r20fk4Nl2X2K2AZIWuik3DBlnBCoY4+PpofOoAMLo",
  render_errors: [view: ExMonWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExMon.PubSub,
  live_view: [signing_salt: "H91b+/Cn"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"

config :ex_mon, ExMonWeb.Auth.Guardian,
  issuer: "ex_mon",
  secret_key: "ntcliUkYeo1bNJMnZ6gd82BsxCQPLQ6pjwTZRdrhwVnd+d1uSR2s/8LzUnzhfQYt"

config :ex_mon, ExMonWeb.Auth.Pipeline,
  module: ExMonWeb.Auth.Guardian,
  error_handler: ExMonWeb.Auth.ErrorHandler
