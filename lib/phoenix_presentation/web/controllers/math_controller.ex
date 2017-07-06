defmodule PhoenixPresentation.Web.MathController do
  use PhoenixPresentation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", result: 0
  end

  def new(conn, %{"math" => %{"number" => number} }) do
    result =
      number
      |> String.to_integer
      |> sum_of_natural_numbers

    render conn, "index.html", result: result
  end

  defp sum_of_natural_numbers(number) do
    if (number == 0) do
      number
    else
      number + sum_of_natural_numbers(number - 1)
    end
  end

end
