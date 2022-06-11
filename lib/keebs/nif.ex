defmodule Keebs.NIF do
  use Rustler, otp_app: :keebs, crate: "keebs_nif"

  def get_keyboard(), do: :erlang.nif_error(:nif_not_loaded)
  def get_mouse_coords(), do: :erlang.nif_error(:nif_not_loaded)
  def get_mouse_buttons(), do: :erlang.nif_error(:nif_not_loaded)
end
