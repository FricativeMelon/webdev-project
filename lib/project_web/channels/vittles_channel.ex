defmodule ProjectWeb.VittlesChannel do
  use ProjectWeb, :channel

  alias Project.GameServer

  def join("vittles:" <> game, payload, socket) do
    if authorized?(payload) do
      socket = assign(socket, :game, game)
      view = GameServer.view(game)
      {:ok, %{"join" => game, "game" => view}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("message", %{"letter" => ll}, socket) do
    view = GameServer.message(socket.assigns[:game], ll)
    broadcast(socket, "update", %{"game" => view})
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
