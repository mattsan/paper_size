defmodule PaperSize.CLI do
  def main(args) do
    args
    |> Enum.map(&parse_format/1)
    |> Enum.each(&puts_paper_size/1)
  end

  @spec puts_paper_size({PaperSize.series_name(), PaperSize.series_rank()} | String.t()) :: :ok

  def puts_paper_size({series_name, :all}) do
    Enum.each(0..10, &puts_paper_size({series_name, &1}))
  end

  def puts_paper_size({series_name, n} = arg)
      when series_name in [:a, :b, :c] and n in 0..10 do
    name = String.upcase("#{series_name}#{n}")
    %{height: height, width: width} = PaperSize.size([arg])
    IO.puts("    #{name} = height #{height} mm x width #{width} mm")
  end

  def puts_paper_size(arg) do
    IO.puts("    #{arg}   unknown peper type")
  end

  @spec parse_format(String.t()) :: {:error, term} | {PaperSize.series_name(), integer} | term

  def parse_format(format) do
    case Regex.named_captures(~r/^(?<series>[abc])(?<rank>(10|[0-9]))?$/i, format) do
      %{"rank" => rank, "series" => series} ->
        series_name = series |> String.downcase() |> String.to_existing_atom()
        n =
          case Integer.parse(rank) do
            :error -> :all
            {n, ""} -> n
          end
        {series_name, n}

      _ ->
        format
    end
  end
end
