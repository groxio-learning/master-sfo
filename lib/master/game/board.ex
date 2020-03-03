defmodule Master.Game.Board do
  defstruct answer: [1,2,3,4], guesses: []
  alias Master.Game.Score
  
  def new(answer \\ random_guess()), do: __struct__(answer: answer)
  def random_guess() do
    [1, 2, 3, 4, 5, 6, 7, 8] |> Enum.shuffle |> Enum.take(4)
  end
  
  def move(board, guess), do: %{board|guesses: [guess|board.guesses]}
  
  def won?(%{guesses: []}), do: false
  def won?(%{answer: answer, guesses: [guess|_]}) do
    Score.new(answer, guess) |> Score.winner? 
  end
  
  def finished?(board) do
    won?(board) || last_move?(board)
  end
  
  def last_move?(board) do
    Enum.count(board.guesses) == 10
  end
  
  def rows(board) do
    for guess <- board.guesses do
      [guess, Score.new(board.answer, guess)]
    end
    |> Enum.reverse
  end
  
  def state(board) do
    %{
      board: rows(board), 
      won: won?(board), 
      finished: finished?(board)
    }
  end
  
end