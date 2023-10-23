defmodule Games.Wordle do
  @moduledoc """
  Game that generates a random 5 letter word based on a word list. User has six tries to guess the word, feedback is
  provide based on each letter in guess as follows: green if letter in guess is correct, yellow if letter exists in
  answer but is in the wrong position(only occurs for the number of that letter that exist in the answer, subsequent
  uses of the same letter will be marked as grey), grey if letter does not exist in answer.
  """
  @doc """
  initalizes the game, sets a answer, and asks user for the first guess.
  """
  def play do
    word_list = [
      "Cense",
      "Chalk",
      "Scrub",
      "Plaza",
      "Posed",
      "Stump",
      "Juror",
      "Rutic",
      "Demur",
      "Lotus",
      "Magic",
      "Madly",
      "Nomad",
      "Screw",
      "Milch",
      "Fifth",
      "Noyer",
      "Denim",
      "Spawn",
      "Sajou",
      "Chore",
      "Pekan",
      "Spoon",
      "Stain",
      "Hooky",
      "Burro",
      "Earal",
      "Crier",
      "Calix",
      "Tally",
      "Chalk",
      "Feria",
      "Under",
      "Runer",
      "Jakie",
      "Rimer",
      "Gular",
      "Shram",
      "Sahui",
      "Spall",
      "Sizer",
      "Spark",
      "Women",
      "Hindi",
      "Soote",
      "Uvula",
      "Shaly",
      "Huzza",
      "Asian",
      "Hendy"
    ]

    answer = Enum.random(word_list) |> String.downcase()
    guess = IO.gets("Enter a five letter word: ")
    guesses = [{String.trim(guess), feedback(answer, guess)}]

    if List.last(guesses) == {String.trim(guess), [:green, :green, :green, :green, :green]} do
      Games.init_menu("You Win!")
    else
      play(1, guesses, answer)
    end
  end

  @doc """
  occurs when user has failed to guess the answer in the six tries given. prints all prior guesses and ends game.
  """
  def play(6, guesses, answer) do
    print_guesses_so_far(guesses)
    IO.puts("You Lose :(, Answer was: #{answer}.")
    Games.init_menu("Better Luck, next time!")
  end

  def play(5, guesses, answer) do
    IO.puts("1 guess left!")
    print_guesses_so_far(guesses)
    guess = IO.gets("Enter a five letter word: ")
    guesses = [{String.trim(guess), feedback(answer, guess)} | guesses] |> Enum.reverse()

    if List.last(guesses) == {String.trim(guess), [:green, :green, :green, :green, :green]} do
      Games.init_menu("You Win!")
    else
      play(6, guesses, answer)
    end
  end

  def play(tries, guesses, answer) do
    IO.puts("#{6 - tries} guesses left!")
    print_guesses_so_far(guesses)
    guess = IO.gets("Enter a five letter word: ")
    guesses = [{String.trim(guess), feedback(answer, guess)} | guesses] |> Enum.reverse()

    if List.last(guesses) == {String.trim(guess), [:green, :green, :green, :green, :green]} do
      Games.Score.add_points(9)
      Games.init_menu("You Win!")
    else
      play(tries + 1, guesses, answer)
    end
  end

  @doc """
  compares users guess to answer and returns a list of colors representing correct(green), incorrect(grey), and existing but
  incorrectly positioned letters(yellow) as a list of colors
  """
  def feedback(answer, guess) do
    checked =
      for {a_char, g_char} <- Enum.zip(String.codepoints(answer), String.codepoints(guess)) do
        if a_char == g_char do
          :green
        else
          :grey
        end
      end

    answer_without_green = remove_correct(String.codepoints(answer), checked)
    # Current solution does not handle situation where same letter can be yellow and grey
    # result = Enum.map(Enum.zip(checked, String.codepoints(guess)), fn {color, guess_char} ->
    # existing_index = Enum.member?(answer_without_green, guess_char)
    # cond do
    # color == :green -> :green
    # existing_index == true -> :yellow
    # true -> :grey
    # end
    # end)
    # result
    check_for_yellow(0, checked, String.codepoints(guess), answer_without_green, [])
  end

  def check_for_yellow(5, _, _, _, result) do
    result
  end

  @doc """
  iterates over guess to determine if letter exists in answer, if it is in the correct position, and if it exists but
  it has been guess a greater number of times then exists in the answer, and sets the color accordingly.
  """
  def check_for_yellow(count, result_no_yellow, guess, answer_list, result) do
    guess_char = Enum.at(guess, count)
    current_color = Enum.at(result_no_yellow, count)
    existing_index = Enum.member?(answer_list, guess_char)

    answer_list =
      if existing_index == true and current_color != :green do
        List.delete(answer_list, guess_char)
      else
        answer_list
      end

    color =
      cond do
        current_color == :green -> [:green]
        existing_index == true -> [:yellow]
        true -> [:grey]
      end

    result = result ++ color
    check_for_yellow(count + 1, result_no_yellow, guess, answer_list, result)
  end

  @doc """
  helper function to create a copy of guess with correct(green) letters removed
  """
  def remove_correct(answer_as_list, checked) do
    Enum.map(Enum.zip(answer_as_list, checked), fn {char, color} ->
      if color != :green do
        char
      else
        nil
      end
    end)
    |> Enum.filter(fn item -> item != nil end)
  end

  @doc """
  prints guess with color representing each letters correctness as a background square behind each letter.
  """
  def print_formated(word, color_map) do
    word_as_list =
      for {letter, color} <- Enum.zip(String.codepoints(word), color_map) do
        case color do
          :green -> IO.ANSI.format([:green_background, letter])
          :yellow -> IO.ANSI.format([:yellow_background, letter])
          :grey -> IO.ANSI.format([:light_black_background, letter])
        end
      end

    IO.puts(List.to_string(word_as_list))
  end

  @doc """
  prints all prior guesses.
  """

  def print_guesses_so_far(guesses) do
    Enum.map(guesses, fn {word, color_map} -> print_formated(word, color_map) end)
  end
end
