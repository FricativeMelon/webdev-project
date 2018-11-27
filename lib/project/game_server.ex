defmodule Project.GameServer do
  use GenServer

  alias Project.Game

  ## Client Interface
  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def view(game) do
    GenServer.call(__MODULE__, {:view, game})
  end

  def message(game, letter) do
    GenServer.call(__MODULE__, {:message, game, letter})
  end

  ## Implementations
  def init(state) do
    {:ok, state}
  end

  def handle_call({:view, game}, _from, state) do
    gg = Map.get(state, game, Game.new)
    {:reply, Game.client_view(gg), Map.put(state, game, gg)}
  end

  def handle_call({:message, game, letter}, _from, state) do
    gg = Map.get(state, game, Game.new)
    |> Game.message(letter)
    vv = Game.client_view(gg)
    {:reply, vv, Map.put(state, game, gg)}
  end
end
