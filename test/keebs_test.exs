defmodule KeebsTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  test "get_mouse_coords/0 returns a tuple with the mouse coordinates" do
    Keebs.MockRawInput
    |> expect(:get_mouse_coords, fn -> {450, 122} end)

    assert Keebs.get_mouse_coords() == {450, 122}
  end

  test "get_keyboard/0 returns a list of atoms representing all keys currently pressed" do
    Keebs.MockRawInput
    |> expect(:get_keyboard, fn -> ["Enter", "Key1", "RShift"] end)

    assert Keebs.get_keyboard() == [:enter, :key1, :rShift]
  end

  test "get_mouse_buttons/0 returns a map of which buttons are currently pressed" do
    Keebs.MockRawInput
    |> expect(:get_mouse_buttons, fn -> [false, true, false, false, false, false] end)

    assert Keebs.get_mouse_buttons() == %{
             button0: false,
             button1: true,
             button2: false,
             button3: false,
             button4: false,
             button5: false
           }
  end
end
