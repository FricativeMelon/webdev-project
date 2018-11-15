defmodule Project.Game do
  def new do
    %{
      messages: [],
    }
  end

  def client_view(game) do
    %{
      messages: game.messages
    }
  end

  def message(game, letter) do
    messages = List.insert_at(game.messages, 0, letter)

    game
    |> Map.put(:messages, messages)
  end
end

