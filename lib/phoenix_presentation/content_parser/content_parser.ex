defmodule PhoenixPresentation.ContentParser.Markdown do

  def convert_slide(markdown_file, slide \\ 0) do
    markdown_file
    |> read_file
    |> String.split(~r{\n#})
    |> Enum.at(slide)
    |> to_html
  end

  defp to_html(nil), do: nil
  defp to_html(markdown_text) when is_binary(markdown_text) do
    Earmark.as_html!(markdown_text, %Earmark.Options{code_class_prefix: "lang- language-"})
  end

  defp read_file(path) do
    File.read! path
  end

end
