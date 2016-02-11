defmodule Potion.Decoder do

  def decode_quoted(json) do
    json
    |> Poison.decode
    |> case do
         {:ok, value} -> {:ok, decode(value)}
         x -> x
    end
  end

  defp decode(nil), do: nil
  defp decode(true), do: true
  defp decode(false), do: false
  defp decode(%{"integer" => x}), do: x
  defp decode(%{"binary" => x}), do: x
  defp decode(%{"atom" => x}), do: String.to_atom(x)

  defp decode(%{"tuple" => x}) do
    Enum.map(x, &decode/1) |> List.to_tuple
  end

  defp decode(%{"list" => x}) do
    Enum.map(x, &decode/1)
  end

end
