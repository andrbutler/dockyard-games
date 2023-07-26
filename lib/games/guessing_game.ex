defmodule Games.GuessingGame do
  @moduledoc """
  Documentation for `Games`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Games.hello()
      :world

  """
  def generate_answer do
    Enum.random(1..10)
  end
  def generate_answer(num) do 
    num
  end

  def play() do
    {tries, answer, message} = init_state()
    check_answer(tries, answer, message)
    
  end
  def init_state do
    tries = 0
    answer = generate_answer()
    message = "Guess A number between 1 and 10"
    {tries, answer, message}
  end
  def check_answer(5, answer, _) do
    IO.puts("Sorry, you ran out of guesses! :(\n the correct answer was: #{answer}. Better Luck next time!\nGoodbye!")
  end

    def check_answer(tries, answer, message) do
      IO.puts("You have #{5 - tries} guesses left!")
      tries = tries + 1
      guess = IO.gets("#{message}:")
              |> String.strip()
              |> String.to_integer()

      IO.inspect(guess)
      cond do
        guess < answer -> check_answer(tries, answer, "Your Guess was too low, try again")
        guess > answer -> check_answer(tries, answer, "Your Guess was too high, try again")
        guess == answer -> IO.puts("Congratualtions! You guessed the correct answer! Thanks for playing!")
      end
  end

end