alias Experimental.{Flow, GenStage}

defmodule ProducerConsumerTesting.DoublerTest do
  use ExUnit.Case, async: false

  alias ProducerConsumerTesting.Doubler

  setup [:start_doubler]

  ### This one hangs
  test "doubles the incoming data", %{doubler: doubler} do
    {:ok, step_1} =
      [2,4,6,8]
      |> Flow.from_enumerable
      |> Flow.into_stages([doubler])

    result = [step_1] |> GenStage.stream() |> Enum.to_list()

    assert result == [4,8,12,16]
  end

  ### This one passes, but is calling the callback api directly
  test "calling the callback api directly" do
    incoming_events = [2,4,6,8]

    {:noreply, result, _} = Doubler.handle_events(incoming_events, nil, nil)

    assert result == [4,8,12,16]
  end

  defp start_doubler(_) do
    {:ok, doubler} = Doubler.start_link
    [doubler: doubler]
  end
end
