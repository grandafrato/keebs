defmodule Keebs.RawInput do
  @callback get_keyboard() :: list(String.t())
  @callback get_mouse_coords() :: {integer(), integer()}
  @callback get_mouse_buttons() :: list(boolean)

  def get_keyboard(), do: impl().get_keyboard()
  def get_mouse_coords(), do: impl().get_mouse_coords()
  def get_mouse_buttons(), do: impl().get_mouse_buttons()
  defp impl(), do: Application.get_env(:keebs, :raw_input, Keebs.NIF)
end
