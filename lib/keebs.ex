defmodule Keebs do
  defdelegate get_mouse_coords(), to: Keebs.RawInput

  @spec get_keyboard() :: list(atom)
  def get_keyboard() do
    Enum.map(Keebs.RawInput.get_keyboard(), fn key_string ->
      key_string
      |> String.split_at(1)
      |> then(fn {first, rest} -> "#{String.downcase(first)}#{rest}" end)
      |> String.to_atom()
    end)
  end

  @type mouse_button() :: :button0 | :button1 | :button2 | :button3 | :button4 | :button5

  @spec get_mouse_buttons() :: %{mouse_button() => boolean()}
  def get_mouse_buttons() do
    Keebs.RawInput.get_mouse_buttons()
    |> Enum.with_index()
    |> Enum.map(fn {val, index} ->
      button =
        case index do
          0 -> :button0
          1 -> :button1
          2 -> :button2
          3 -> :button3
          4 -> :button4
          5 -> :button5
        end

      {button, val}
    end)
    |> Enum.reduce(%{}, fn {button, val}, acc -> Map.put(acc, button, val) end)
  end
end
