defmodule PhoenixPresentation.Web.LayoutView do
  use PhoenixPresentation.Web, :view

  def view_name(conn) do
    conn
    |> view_module
    |> Phoenix.Naming.resource_name
    |> String.replace("_view", "")
  end

end
