defmodule Expel.CLITest do

  use ExUnit.Case

  test "encodes this file" do
    assert %{file: _, code: _} = Expel.CLI.read_and_encode(__ENV__.file)
  end

end
