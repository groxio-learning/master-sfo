defmodule MasterWeb.TimerLive do
  use Phoenix.LiveView
  alias Master.Counter
  import Phoenix.HTML, only: [raw: 1]

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)
    {
      :ok, 
      assign(socket, count: 0)
    }
  end

  def render(assigns) do
    ~L"""
    <h1>The timer is: <%= @count %></h1>
    """
  end
  
  def advance(socket) do
    count = socket.assigns.count
    IO.inspect socket.assigns
    assign(socket, count: Counter.inc(count))
  end
  
  def handle_info(:tick, socket) do
    {:noreply, advance(socket)}
  end
end