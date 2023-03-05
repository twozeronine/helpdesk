import Config

config :helpdesk, Helpdesk.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "helpdesk_test#{System.get_env("MIX_TEST_PATITION")}",
  port: 25432,
  pool: Ecto.Adapter.SQL.Sandbox,
  pool_size: 10
