defmodule PhoenixPresentation.Web.ChatController do
  use PhoenixPresentation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
