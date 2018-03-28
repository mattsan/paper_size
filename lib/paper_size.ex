defmodule PaperSize do
  @moduledoc """
  Documentation for PaperSize.

  see [Paper size - Wikipedia](https://en.wikipedia.org/wiki/Paper_size)

  ### millimeter

      | Format |  A series  |   B series  |  C series  |
      | ------ | ---------- | ----------- | ---------- |
      |    0   | 841 x 1189 | 1000 x 1414 | 917 x 1297 |
      |    1   | 594 x  841 |  707 x 1000 | 648 x  917 |
      |    2   | 420 x  594 |  500 x  707 | 458 x  648 |
      |    3   | 297 x  420 |  353 x  500 | 324 x  458 |
      |    4   | 210 x  297 |  250 x  353 | 229 x  324 |
      |    5   | 148 x  210 |  176 x  250 | 162 x  229 |
      |    6   | 105 x  148 |  125 x  176 | 114 x  162 |
      |    7   |  74 x  105 |   88 x  125 |  81 x  114 |
      |    8   |  52 x   74 |   62 x   88 |  57 x   81 |
      |    9   |  37 x   52 |   44 x   62 |  40 x   57 |
      |   10   |  26 x   37 |   31 x   44 |  28 x   40 |

  ### inch

      | Format |   A series  |   B series  |   C series  |
      | ------ | ----------- | ----------- | ----------- |
      |    0   | 33.1 x 46.8 | 39.4 x 55.7 | 36.1 x 51.1 |
      |    1   | 23.4 x 33.1 | 27.8 x 39.4 | 25.5 x 36.1 |
      |    2   | 16.5 x 23.4 | 19.7 x 27.8 | 18.0 x 25.5 |
      |    3   | 11.7 x 16.5 | 13.9 x 19.7 | 12.8 x 18.0 |
      |    4   | 8.27 x 11.7 | 9.84 x 13.9 | 9.02 x 12.8 |
      |    5   | 5.83 x 8.27 | 6.93 x 9.84 | 6.38 x 9.02 |
      |    6   | 4.13 x 5.83 | 4.92 x 6.93 | 4.49 x 6.38 |
      |    7   | 2.91 x 4.13 | 3.46 x 4.92 | 3.19 x 4.49 |
      |    8   | 2.05 x 2.91 | 2.44 x 3.46 | 2.24 x 3.19 |
      |    9   | 1.46 x 2.05 | 1.73 x 2.44 | 1.57 x 2.24 |
      |   10   | 1.02 x 1.46 | 1.22 x 1.73 | 1.10 x 1.57 |

  """

  @series %{
    a: ~w(1189 841 594 420 297 210 148 105 74 52 37 26) |> Enum.map(&String.to_integer/1),
    b: ~w(1414 1000 707 500 353 250 176 125 88 62 44 31) |> Enum.map(&String.to_integer/1),
    c: ~w(1297 917 648 458 324 229 162 114 81 57 40 28) |> Enum.map(&String.to_integer/1)
  }

  @type series_name :: :a | :b | :c
  @type size_pair :: {integer, integer}
  @type paper_size :: %{height: integer, width: integer}

  @doc """
  Get a paper size.

      iex> PaperSize.size(a: 4)
      %{height: 297, width: 210}
      iex> PaperSize.size(b: 5)
      %{height: 250, width: 176}
  """
  @spec size([{series_name, integer}]) :: paper_size
  def size([{series_name, n}]) when series_name in [:a, :b, :c] and 0 <= n and n <= 10 do
    {height, width} = series(series_name) |> Enum.at(n)
    %{height: height, width: width}
  end

  @doc """
  Get a paper size series.

      iex> PaperSize.series(:a)
      [
        {1189, 841},
        {841, 594},
        {594, 420},
        {420, 297},
        {297, 210},
        {210, 148},
        {148, 105},
        {105, 74},
        {74, 52},
        {52, 37},
        {37, 26}
      ]
  """
  @spec series(series_name) :: [size_pair]
  def series(series_name) when series_name in [:a, :b, :c] do
    [_ | widths] = @series[series_name]
    Enum.zip([@series[series_name], widths])
  end
end
