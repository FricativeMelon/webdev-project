use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :project, ProjectWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :project, Project.Repo,
  username: "project",
  password: "too1Vued6zae",
  database: "project_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
