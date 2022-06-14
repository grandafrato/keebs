Application.put_env(:keebs, :raw_input, Keebs.FakeRawInput)
Keebs.FakeRawInput.start_link()
ExUnit.start()
