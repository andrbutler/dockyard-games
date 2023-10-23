defmodule Games.Application do
  use Application
  def start(_type, _args) do
    children = 
      [
        {Games.Score, 0}
      ]
    
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
