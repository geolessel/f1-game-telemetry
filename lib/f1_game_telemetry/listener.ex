defmodule F1GameTelemetry.Listener do
  alias F1GameTelemetry.V2018.Parser
  require Logger
  use GenServer

  @port Application.get_env(:f1_game_telemetry, :port, 20_777)

  # ┌────────────┐
  # │ Client API │
  # └────────────┘

  # replace :ok with initial state
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def register(listener) do
    GenServer.call(__MODULE__, {:register, listener})
  end


  # ┌──────────────────┐
  # │ Server Callbacks │
  # └──────────────────┘

  def init(_state) do
    {:ok, _socket} = :gen_udp.open(@port, [:binary])
    {:ok, %{listeners: []}}
  end

  def handle_call({:register, listener}, _, state) do
    {:reply, :ok, %{state | listeners: [listener | state.listeners]}}
  end

  # Handle UDP data
  def handle_info({:udp, _socket, _ip, _port, data}, state) do
    case Parser.parse(data) do
      {type, header, parsed_data} ->
        state.listeners
        |> Enum.each(fn listener ->
          Process.send(listener, {:f1_game_telemetry, {type, header, parsed_data}}, [])
        end)
      _ ->
        :ok
    end
          
    {:noreply, state}
  end

  # Ignore everything else
  def handle_info({_, _socket}, state) do
    {:noreply, state}
  end


  # ┌──────────────────┐
  # │ Helper Functions │
  # └──────────────────┘
end
