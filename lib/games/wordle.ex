defmodule Games.Wordle do
  def play do
   word_list = ["Cense", "Chalk", "Scrub", "Plaza", "Posed", "Stump", "Juror", "Rutic", "Demur", "Lotus", "Magic", "Madly", "Nomad", "Screw", "Milch", 
   "Fifth", "Noyer", "Denim", "Spawn", "Sajou", "Chore", "Pekan", "Spoon", "Stain", "Hooky", "Burro", "Earal", "Crier", "Calix", "Tally", "Chalk", 
   "Feria", "Under", "Runer", "Jakie", "Rimer", "Gular", "Shram", "Sahui", "Spall", "Sizer", "Spark", "Women", "Hindi", "Soote", "Uvula", "Shaly", 
   "Huzza", "Asian", "Hendy"]
   answer = Enum.random(word_list)
   guess = IO.gets("Enter a five letter word: ")
   guesses = [{String.trim(guess), feedback(answer, guess)}]
    IO.inspect(guesses)
    if List.last(guesses) == {[:green, :green, :green, :green, :green], guess} do
      "You Win!"
    else
      play(1, guesses, answer)
    end
  end
  def play(6, guesses, answer) do
    print_guesses_so_far(guesses)
    IO.puts("You Lose :(, Answer was: #{answer}.")
    IO.puts("Better Luck, next time!")
  end
  def play(5, guesses, answer) do
    IO.puts("1 guess left!")
    print_guesses_so_far(guesses)
   guess = IO.gets("Enter a five letter word: ")
    guesses = [{String.trim(guess), feedback(answer, guess)} | guesses] |> Enum.reverse()
    if List.last(guesses) == {[:green, :green, :green, :green, :green], guess} do
      "You Win!"
    else
      play(6, guesses, answer)
    end
  end
  def play(tries, guesses, answer) do
    IO.puts("#{6 - tries} guesses left!")
    print_guesses_so_far(guesses)
   guess = IO.gets("Enter a five letter word: ")
    guesses = [{String.trim(guess), feedback(answer, guess)} | guesses] |> Enum.reverse()
    IO.inspect(guesses)
    if List.last(guesses) == {[:green, :green, :green, :green, :green], guess} do
      "You Win!"
    else
      play(tries + 1, guesses, answer)
    end
  end
  def feedback(answer, guess) do
    [:yellow, :yellow, :green, :grey, :green]
  end
  def print_formated(word, color_map) do
    word_as_list = for {letter, color} <- Enum.zip(String.codepoints(word), color_map) do
      case color do
        :green -> IO.ANSI.format([:green_background, letter])
        :yellow -> IO.ANSI.format([:yellow_background, letter])
        :grey -> IO.ANSI.format([:light_black_background, letter])
      end
    end
    IO.puts(List.to_string(word_as_list))
  end
  def print_guesses_so_far(guesses) do
    Enum.map(guesses, fn {word, color_map} -> print_formated(word, color_map) end)
  end
end

