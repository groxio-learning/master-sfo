defmodule MasterWeb.GameLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Hello, from LiveView</h1>
    """
  end
end