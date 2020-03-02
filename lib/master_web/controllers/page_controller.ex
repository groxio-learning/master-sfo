defmodule MasterWeb.PageController do
  use MasterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
