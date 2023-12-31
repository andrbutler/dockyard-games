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

    result = check_result(player_choice, computer_choice)

    if result == "Invalid choice, Try again!" do
      IO.puts(result)
      play()
    else
      Games.init_menu(result)
    end
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
  def check_result(computer_choice, computer_choice) do
    Games.Score.add_points(1)
    "It's a tie!"
  end

  def check_result("paper", computer_choice) do
    if computer_choice == "rock" do
      Games.Score.add_points(3)
      "Paper covers rock, YOU WIN!"
    else
      "Scissors cut paper, YOU LOSE :("
    end
  end

  def check_result("rock", computer_choice) do
    if computer_choice == "scissors" do
      Games.Score.add_points(3)
      "Rock breaks scissors, YOU WIN!"
    else
      "Paper covers rock, YOU LOSE :("
    end
  end

  def check_result("scissors", computer_choice) do
    if computer_choice == "rock" do
      Games.Score.add_points(3)
      "Scissors cut paper, YOU WIN!"
    else
      "Rock breaks scissors, YOU LOSE :("
    end
  end

  def check_result(_, _) do
    "Invalid choice, Try again!"
  end
end
