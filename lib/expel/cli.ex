defmodule Expel.CLI do

  def main([]) do
    main([:stdio])
  end

  def main(files) do
    files |> Stream.map(&read_and_encode/1) |> Poison.encode! |> IO.puts
  end

  def read_and_encode(file) do
    read(file) |> encode(file)
  end

  defp read(:stdio) do
    IO.read(:stdio, :all)
  end

  defp read(filename) do
    File.read!(filename)
  end

  defp encode(string, filename) do
    %{file: filename, code: encoded(string)}
  end

  defp encoded(string) do
    Code.string_to_quoted!(string) |> Expel.Encoder.encode_quoted
  end

end
