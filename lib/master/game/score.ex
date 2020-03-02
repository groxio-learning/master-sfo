defmodule Master.Game.Score do
  defstruct [:reds, :whites]
  
  def new(answer, guess) do
    __struct__(
      reds: red_count(answer, guess), 
      whites: white_count(answer, guess)
    )
  end
  
  def winner?(%{reds: 4}), do: true
  def winner?(_), do: false
  
  def red_count(answer, guess) do
    answer
    |> Enum.zip(guess)
    |> Enum.count(fn {x, y} -> x == y end)
  end
  
  def miss_count(answer, guess) do
    Enum.count(guess -- answer)
  end
  
  def white_count(answer, guess) do
    Enum.count(answer) - red_count(answer, guess) - miss_count(answer, guess)
  end
end