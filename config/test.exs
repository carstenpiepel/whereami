import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :whereami, WhereAmIWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5Sl2Ta13R9mHKfH4E/cMeoZza886lp8hz3ty8Eq4YagyMRMEKBU25pS5Zp0troeX",
  server: false

# In test we don't send emails.
config :whereami, WhereAmI.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
