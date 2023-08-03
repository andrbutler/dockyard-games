defmodule WordleTest do
  use ExUnit.Case
  doctest Games.Wordle

  describe "get_feedback/2" do

    test "all green" do
      assert Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
    end

    test "all grey" do
      assert Games.Wordle.feedback("aaaaa", "bbbbb") == [:grey, :grey, :grey, :grey, :grey]
    end

    test "all yellow" do
      assert Games.Wordle.feedback("abdce", "edcba") == [:yellow, :yellow, :yellow, :yellow, :yellow]
    end

    test "all color" do
      assert Games.Wordle.feedback("aaabb", "xaaaa") == [:grey, :green, :green, :yellow, :yellow]
    end
  end
end
