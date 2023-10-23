defmodule Games.Score do
  use GenServer
  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def add_points(value) do
    GenServer.cast(__MODULE__, {:add, value})
  end

  def current_score() do
    GenServer.call(__MODULE__, :get_score)
  end

  @impl true
  def init(state) do 
    {:ok, state}
  end

  @impl true
  def handle_cast({:add, value}, state) do
    {:noreply, state + value}
  end

  @impl true
  def handle_call(:get_score, _from, state) do
    {:reply, state, state}
  end
end
