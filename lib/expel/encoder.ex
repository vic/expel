defmodule Expel.Encoder do

  def encode_quoted(quoted) do
    encode(quoted)
  end

  def json_encode(quoted) do
    encode(quoted) |> Poison.encode
  end

  defp encode(nil), do: nil
  defp encode(true), do: true
  defp encode(false), do: false
  defp encode(x) when is_integer(x), do: %{integer: x}
  defp encode(x) when is_float(x), do: %{float: x}
  defp encode(x) when is_binary(x), do: %{binary: x}
  defp encode(x) when is_atom(x), do: %{atom: x}
  defp encode(x) when is_tuple(x), do: %{tuple: encode_enum(x)}
  defp encode(x) when is_list(x), do: %{list: encode_enum(x)}

  defp encode_enum(x) when is_tuple(x) do
    x |> Tuple.to_list |> Enum.map(&encode/1)
  end

  defp encode_enum(x) when is_list(x) do
    Enum.map(x, &encode/1)
  end


end
