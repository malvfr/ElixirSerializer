defmodule ElixirToolsWeb.SerializerLive do
  use ElixirToolsWeb, :live_view

  require Logger

  def mount(params, session, socket) do
    {:ok, socket}
  end
end
