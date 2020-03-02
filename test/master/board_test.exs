defmodule GameTest do
  use ExUnit.Case
  alias Master.Game.Board
  alias Master.Game.Score
  
  test "Game should have a struct" do
    assert %Board{}.__struct__ == Board
  end
  
  test "Game should have sensible defaults" do
    assert %Board{}.guesses == []
    assert %Board{}.answer == [1, 2, 3, 4]
  end

  test "Score should have a struct" do
    assert %Score{}.__struct__ == Score
  end
  
  test "Score should have reds and whites attributes" do
    assert :reds   in Map.keys( %Score{} )
    assert :whites in Map.keys( %Score{} )
  end
end