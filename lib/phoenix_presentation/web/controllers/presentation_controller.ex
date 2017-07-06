defmodule PhoenixPresentation.Web.PresentationController do
  use PhoenixPresentation.Web, :controller

  alias PhoenixPresentation.ContentParser.Markdown

  @slides Path.join(:code.priv_dir(:phoenix_presentation), "static/slides.md")

  def index(conn, params) do
    number = Map.get(params, "slide", "0") |> String.to_integer
    slide = Markdown.convert_slide(@slides, number)
    render conn, "slide.html", slide: slide
  end

end
