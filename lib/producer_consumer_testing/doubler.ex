alias Experimental.GenStage

defmodule ProducerConsumerTesting.Doubler do
  use GenStage

  ### Public API

  def start_link do
    GenStage.start_link(__MODULE__, nil)
  end

  ### Callbacks
  def init(state) do
    {:producer_consumer, state}
  end

  def handle_events(events, _from, state) do
    events = Enum.map(events, & &1 * 2)
    {:noreply, events, state}
  end
end
