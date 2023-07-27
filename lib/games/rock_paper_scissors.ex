defmodule Games.RockPaperScissors do
  @moduledoc """
    1 player game of rock paper scissors, user makes choice ai choses randomly
  """

  @doc """
  starts the game
  """
  def play() do
    computer_choice = Enum.random(["rock", "paper", "scissors"])

    player_choice =
      IO.gets("Choose: rock, paper, or scissors: ") |> String.trim() |> String.downcase()

    check_result(player_choice, computer_choice)
  end

  @doc """
  checks result of matching player and computer choice
  ## Examples
   iex> Games.RockPaperScissors.check_result("paper", "paper")
    "It's a tie!"
   iex> Games.RockPaperScissors.check_result("paper", "rock")
  "Paper covers rock, YOU WIN!"
   iex> Games.RockPaperScissors.check_result("scissors", "paper")
      "Scissors cut paper, YOU WIN!"
   iex> Games.RockPaperScissors.check_result("rock", "paper")
      "Paper covers rock, YOU LOSE :("
   iex> Games.RockPaperScissors.check_result("apple", "paper")
  "Invalid choice, Try again!"
  """
  def check_result(computer_choice, computer_choice) do "It's a tie!" end
  def check_result("paper", computer_choice) do
    if computer_choice == "rock" do
      "Paper covers rock, YOU WIN!"
    else
      "Scissors cut paper, YOU LOSE :("
    end
  end

  def check_result("rock", computer_choice) do
    if computer_choice == "scissors" do
      "Rock breaks scissors, YOU WIN!"
    else
      "Paper covers rock, YOU LOSE :("
    end
  end

  def check_result("scissors", computer_choice) do
    if computer_choice == "rock" do
      "Scissors cut paper, YOU WIN!"
    else
      "Rock breaks scissors, YOU LOSE :("
    end
  end

  def check_result(_, _) do
    IO.puts("Invalid choice, Try again!")
    play()
  end
end
