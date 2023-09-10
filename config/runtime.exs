import Config

if config_env() == :prod do
  file_folder = System.get_env("FILE_FOLDER") || 
    Path.expand("~/b3_files") 

  config :b3, 
    file_folder: file_folder
  
end
