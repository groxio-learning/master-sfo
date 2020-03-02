defmodule MasterWeb.GameLive do
  use Phoenix.LiveView
  alias Master.Counter
  import Phoenix.HTML, only: [raw: 1]

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Hello, from LiveView</h1>
    """
  end
end