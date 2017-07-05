defmodule PhoenixPresentation.Web.PresentationController do
  use PhoenixPresentation.Web, :controller

  alias PhoenixPresentation.ContentParser.Markdown

  @slides "priv/static/slides.md"

  def index(conn, params) do
    number = Map.get(params, "slide", "0") |> String.to_integer
    slide = Markdown.convert_slide(@slides, number)
    render conn, "slide.html", slide: slide
  end

end
