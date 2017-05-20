# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :qa_page,
  ecto_repos: [QaPage.Repo]

# Configures the endpoint
config :qa_page, QaPage.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mop1B4VPvuJpRRCiLRZ6pH4NuG89WKRqiczWYJ+qmF/MoH8l67BcXxta2I+QNOz2",
  render_errors: [view: QaPage.ErrorView, accepts: ~w(json)],
  pubsub: [name: QaPage.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
