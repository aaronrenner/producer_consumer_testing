alias Experimental.{Flow, GenStage}

defmodule ProducerConsumerTesting.DoublerTest do
  use ExUnit.Case, async: false

  alias ProducerConsumerTesting.Doubler

  setup [:start_doubler]

  test "doubles the incoming data", %{doubler: doubler} do
    {:ok, step_1} = GenStage.from_enumerable([2,4,6,8])
    GenStage.sync_subscribe(doubler, to: step_1)
    assert [doubler] |> GenStage.stream() |> Enum.to_list() == [4, 8, 12, 16]
  end

  defp start_doubler(_) do
    {:ok, doubler} = Doubler.start_link
    [doubler: doubler]
  end
end
