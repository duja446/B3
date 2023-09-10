import Config

config :b3,
  file_folder: "./static"

import_config "#{config_env()}.exs"
