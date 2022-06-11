Mox.defmock(Keebs.MockRawInput, for: Keebs.RawInput)
Application.put_env(:keebs, :raw_input, Keebs.MockRawInput)
ExUnit.start()
