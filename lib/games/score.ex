defmodule Score do
  use GenServer
  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def add_points(pid, value) do
    Genserver.cast(pid, {:add, value})
  end

  def current_score(pid) do
    Genserver.call(pid, :get_score)
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
