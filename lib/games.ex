defmodule Games do
  @moduledoc """
  collection of three games(Wordle, Guess the number, Tic-Tac-Toe) User can select from this menu, games run in command line.
  """

  @doc """
  main function runs from cli
  """
  def main(_args) do
    init_menu()
  end

  @doc """
  initlizes the menu and displays final message from game if it exists
  """
  def init_menu() do
    user_choice =
      get_selection()
      |> String.replace(~r/\s/, "")
      |> String.replace(",", "")
      |> String.downcase()
      |> parse_selection()

    execute_selection(user_choice)
  end

  def init_menu(message) do
    IO.puts(message)

    user_choice =
      get_selection()
      |> String.replace(~r/\s/, "")
      |> String.replace(",", "")
      |> String.downcase()
      |> parse_selection()

    execute_selection(user_choice)
  end

  @doc """
  displays choice and gets user input.
  """
  def get_selection() do
    IO.puts(
      "\n\nPlease select game(you can enter the name, the number or the leter in parentheses):\n"
    )

    IO.puts(
      "\t1. (W)ordle\n\t2. (R)ock, Paper, Scissors\n\t3.(G)uessing Game\n\tenter (S)top to quit"
    )

    IO.gets("What do you want to play?\n")
  end

  @doc """
  converts user choice into atom to pass to execute_selection function.
  """
  def parse_selection(choice) do
    cond do
      choice == "wordle" or choice == "w" or choice == "1" -> :Wordle
      choice == "rockpaperscissors" or choice == "r" or choice == "2" -> :RPS
      choice == "guessinggame" or choice == "g" or choice == "3" -> :Guessing
      choice == "stop" or choice == "s" -> :quit
      true -> :error
    end
  end

  @doc """
  starts the game of users choice or exits the games program
  """
  def execute_selection(:error) do
    IO.puts("Invalid selection, Please try again.")
    init_menu()
  end

  def execute_selection(:Wordle) do
    IO.puts("Let's Play Wordle!\n\n\n")
    Games.Wordle.play()
  end

  def execute_selection(:RPS) do
    IO.puts("Let's Play Rock, Paper, Scissors!\n\n\n")
    Games.RockPaperScissors.play()
  end

  def execute_selection(:Guessing) do
    IO.puts("Try to Guess the Number!\n\n\n")
    Games.GuessingGame.play()
  end

  def execute_selection(:quit) do
    IO.puts("Let's Play again:)! Goodbye!")
    exit(:normal)
  end
end
