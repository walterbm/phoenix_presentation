defmodule PhoenixPresentation.Web.PresentationController do
  use PhoenixPresentation.Web, :controller

  alias PhoenixPresentation.ContentParser.Markdown

  @slides "static/slides.md"

  def index(conn, params) do
    slide_path = Path.join(:code.priv_dir(:phoenix_presentation, @slides))
    number = Map.get(params, "slide", "0") |> String.to_integer
    slide = Markdown.convert_slide(slide_path, number)
    render conn, "slide.html", slide: slide
  end

end
