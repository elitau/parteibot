defmodule Parteibot.PageController do
  use Parteibot.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
