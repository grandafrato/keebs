defmodule Keebs.EventPollerTest do
  alias Keebs.EventPoller
  alias Keebs.FakeRawInput
  use ExUnit.Case

  setup do
    FakeRawInput.seed_values(["W", "A", "S", "D"], {0, 0}, [
      false,
      true,
      false,
      false,
      false,
      false
    ])
  end

  test "will send key events to the registered listeners" do
    test_proc = self()

    EventPoller.start_link(
      Enum.map(
        1..100,
        fn _ ->
          spawn(fn ->
            receive do
              {:input_keyboard, [:w, :a, :s, :d]} ->
                send(test_proc, :keyboard_pass)
            end

            receive do
              {:input_mouse_coords, {0, 0}} ->
                send(test_proc, :mouse_coords_pass)
            end

            receive do
              {:input_mouse_buttons, %{button1: true}} ->
                send(test_proc, :mouse_buttons_pass)
            end
          end)
        end
      )
    )

    assert_receive :keyboard_pass
    assert_receive :mouse_coords_pass
    assert_receive :mouse_buttons_pass
  end

  test "register_listener/2 will add the given process as a listener" do
    {:ok, poller} = EventPoller.start_link([])

    EventPoller.register_listener(poller, self())

    assert_receive {:input_keyboard, _}
    assert_receive {:input_mouse_coords, _}
    assert_receive {:input_mouse_buttons, _}
  end

  test "start_link gives an option to set the polling timeout" do
    EventPoller.start_link([self()], 90)
    refute_received _
    assert_receive _, 180
  end
end
