defmodule MasterWeb.LinkLive do
  use Phoenix.LiveView
  alias Master.Counter

  def mount(_params, _session, socket) do
    {
      :ok, 
      assign(socket, count: 0)
    }
  end

  def render(assigns) do
    ~L"""
    <h1>The timer is: <%= @count %></h1>
    <button class="button" phx-click="tick">+</button>
    """
  end
  
  def advance(socket) do
    count = socket.assigns.count
    assign(socket, count: Counter.inc(count))
  end
  
  def handle_event("tick", _, socket) do
    {:noreply, advance(socket)}
  end
  def handle_info(:tick, socket) do
    {:noreply, advance(socket)}
  end
end