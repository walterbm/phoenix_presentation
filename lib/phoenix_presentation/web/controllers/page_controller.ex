defmodule PhoenixPresentation.Web.PageController do
  use PhoenixPresentation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
