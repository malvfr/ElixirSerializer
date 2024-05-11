defmodule ElixirSerializerWeb.SerializerLive do
  use ElixirSerializerWeb, :live_view

  require Logger

  def mount(params, session, socket) do
    {:ok, socket}
  end
end
