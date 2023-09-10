defmodule B3.Endpoint do

  use Plug.Router

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:urlencoded, :multipart], pass: ["*/*"]
  plug :match 
  plug :dispatch 

  get "/files/:file_name" do
    file_path = get_file_path(file_name)
    if File.exists?(file_path) do
      send_file(conn, 200, file_path)
    else
      send_resp(conn, 404, "File #{file_name} not found")
    end
  end

  post "/upload" do
    upload(conn, conn.body_params)
  end

  get "/list" do
    send_resp(conn, 200, File.ls!(Application.get_env(:b3, :file_folder)))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
  
  def upload(conn, %{"name" => name, "file" => upload, "quality" => quality}) do
    valid_types = ["image/png", "image/jpeg"]
    if upload.content_type in valid_types do
      upload.path
      |> Mogrify.open()
      |> Mogrify.quality(quality)
      |> Mogrify.save([path: get_file_path(name)])
      send_resp(conn, 200, "Successfully uploaded #{name} (available at files/#{name})")
    else
      send_resp(conn, 400, "Server only accepts #{inspect valid_types} files")
    end
  end

  defp get_file_path(file) do
    Path.join(Application.get_env(:b3, :file_folder), file)
  end
end

