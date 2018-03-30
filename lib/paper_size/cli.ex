defmodule PaperSize.CLI do
  def main(args) do
    args
    |> Enum.map(&parse_arg/1)
    |> Enum.each(&puts_paper_size/1)
  end

  @spec puts_paper_size({PaperSize.series_name(), PaperSize.series_rank()} | String.t()) :: :ok

  def puts_paper_size({series_name, n} = arg)
      when series_name in [:a, :b, :c] and n in 0..10 do
    name = String.upcase("#{series_name}#{n}")
    %{height: height, width: width} = PaperSize.size([arg])
    IO.puts("    #{name} = height #{height} mm x width #{width} mm")
  end

  def puts_paper_size(arg) do
    IO.puts("    #{arg}   unknown peper type")
  end

  @spec parse_arg(String.t()) :: {:error, term} | {PaperSize.series_name(), integer} | term

  def parse_arg(arg) do
    result =
      with <<s, rest::bits>> <- String.downcase(arg),
           series_name <- to_series_name(s),
           {n, ""} <- :string.to_integer(rest),
           do: {series_name, n}

    case result do
      {:error, _} -> arg
      {_, _} -> result
      _ -> arg
    end
  end

  @spec to_series_name(PaperSize.series_name() | term) :: atom

  defp to_series_name(?a), do: :a
  defp to_series_name(?b), do: :b
  defp to_series_name(?c), do: :c
  defp to_series_name(_), do: :error
end
