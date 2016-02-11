defmodule Potion.EncoderTest do

  use ExUnit.Case

  test "encodes true value into valid json form" do
    quote(do: true) |> assert_encode_quoted
  end

  test "encodes false value into valid json form" do
    quote(do: false) |> assert_encode_quoted
  end

  test "encodes quoted integer into valid json form" do
    quote(do: 1) |> assert_encode_quoted
  end

  test "encodes quoted integer into valid json form" do
    quote(do: 98.5) |> assert_encode_quoted
  end

  test "encodes quoted string into valid json form" do
    quote(do: "hola") |> assert_encode_quoted
  end

  test "encodes quoted atom into valid json form" do
    quote(do: :hola) |> assert_encode_quoted
  end

  test "encodes quoted tuple of two into valid json form" do
    quote(do: {:a, 2}) |> assert_encode_quoted
  end

  test "encodes quoted list of two into valid json form" do
    quote(do: [:a, 2]) |> assert_encode_quoted
  end

  test "encodes quoted keyword list of two into valid json form" do
    quote(do: [a: 1, b: 2]) |> assert_encode_quoted
  end

  test "encodes quoted struct into valid json form" do
    quote(do: %{__struct__: Foo.Bar}) |> assert_encode_quoted
  end

  test "encodes quoted map into valid json form" do
    quote(do: %{"hello" => :"world"}) |> assert_encode_quoted
  end

  test "encodes this file as valid json" do
    File.read!(__ENV__.file)
    |> Code.string_to_quoted!
    |> assert_encode_quoted
  end

  defp assert_encode_quoted(quoted) do
    {:ok, json} = Potion.Encoder.encode_quoted(quoted)
    {:ok, form} = Potion.Decoder.decode_quoted(json)
    unless quoted == form do
      flunk("""
      Expected quoted expression

      #{inspect quoted}

      encoded to json

      #{inspect json}

      not to be decoded as

      #{form}
      """)
    end
  end

end
