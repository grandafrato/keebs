defmodule Keebs.FakeRawInput do
  use Agent
  @behaviour Keebs.RawInput

  def start_link() do
    Agent.start_link(fn -> %{keyboard: [], mouse_coords: {0, 0}, mouse_buttons: []} end,
      name: __MODULE__
    )
  end

  def seed_values(keyboard, coords, buttons) do
    Agent.update(__MODULE__, fn _ ->
      %{keyboard: keyboard, mouse_coords: coords, mouse_buttons: buttons}
    end)
  end

  @impl true
  def get_keyboard(), do: Agent.get(__MODULE__, &Map.get(&1, :keyboard))

  @impl true
  def get_mouse_coords(), do: Agent.get(__MODULE__, &Map.get(&1, :mouse_coords))

  @impl true
  def get_mouse_buttons(), do: Agent.get(__MODULE__, &Map.get(&1, :mouse_buttons))
end
