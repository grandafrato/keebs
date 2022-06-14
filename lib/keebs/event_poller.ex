defmodule Keebs.EventPoller do
  # TODO: Only send input on change
  use GenServer

  # API

  @spec start_link(list(pid()), non_neg_integer(), GenServer.options()) :: GenServer.on_start()
  def start_link(pids, timeout \\ 0, opts \\ []) do
    GenServer.start_link(__MODULE__, {pids, timeout}, opts)
  end

  @spec register_listener(pid(), pid()) :: :ok
  def register_listener(poller, listener) do
    GenServer.cast(poller, {:new_listener, listener})
  end

  # GenServer Backend

  @impl true
  def init({pids, timeout}) do
    Process.send_after(self(), :update, timeout)
    {:ok, {pids, timeout}}
  end

  @impl true
  def handle_cast({:new_listener, listener}, {listeners, timeout}) do
    {:noreply, {[listener | listeners], timeout}}
  end

  @impl true
  def handle_info(:update, {listeners, timeout}) do
    Process.send_after(self(), :update, timeout)

    Enum.each(listeners, fn listener ->
      send(listener, {:input_keyboard, Keebs.get_keyboard()})
      send(listener, {:input_mouse_coords, Keebs.get_mouse_coords()})
      send(listener, {:input_mouse_buttons, Keebs.get_mouse_buttons()})
    end)

    {:noreply, {listeners, timeout}}
  end
end
