defmodule DivingIntoHttp2Web.PageController do
  use DivingIntoHttp2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
