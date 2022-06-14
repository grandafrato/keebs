defmodule KeebsTest do
  alias Keebs.FakeRawInput
  use ExUnit.Case

  test "get_mouse_coords/0 returns a tuple with the mouse coordinates" do
    FakeRawInput.seed_values([], {450, 122}, [])

    assert Keebs.get_mouse_coords() == {450, 122}
  end

  test "get_keyboard/0 returns a list of atoms representing all keys currently pressed" do
    FakeRawInput.seed_values(["Enter", "Key1", "RShift"], {0, 0}, [])

    assert Keebs.get_keyboard() == [:enter, :key1, :rShift]
  end

  test "get_mouse_buttons/0 returns a map of which buttons are currently pressed" do
    FakeRawInput.seed_values([], {0, 0}, [false, true, false, false, false, false])

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
