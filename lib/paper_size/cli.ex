defmodule PaperSize.CLI do
  def main(args) do
    args
    |> Enum.map(&split_arg/1)
    |> Enum.each(&puts_paper_size/1)
  end

  def puts_paper_size({series_name, n} = arg)
      when series_name in [:a, :b, :c] and 0 <= n and n <= 10 do
    name = String.upcase("#{series_name}#{n}")
    %{height: height, width: width} = PaperSize.size([arg])
    IO.puts("    #{name} = height #{height} mm x width #{width} mm")
  end

  def puts_paper_size(arg) do
    IO.puts("    #{arg}   unknown peper type")
  end

  defp split_arg(arg) do
    result =
      with <<s, rest::bits>> <- String.downcase(arg),
           series_name <- List.to_existing_atom([s]),
           {n, ""} <- :string.to_integer(rest),
           do: {series_name, n}

    case result do
      {:error, _} -> arg
      {_, _} -> result
      _ -> arg
    end
  end
end
