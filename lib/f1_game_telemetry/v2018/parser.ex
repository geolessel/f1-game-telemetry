defmodule F1GameTelemetry.V2018.Parser do
  alias F1GameTelemetry.V2018.{Header, Lap, Telemetry, Session, Status}

  def parse(data) do
    <<
      format           :: little-unsigned-integer-16,
      version          :: little-unsigned-integer-8,
      packet_id        :: little-unsigned-integer-8,
      session_id       :: little-unsigned-integer-64,
      session_time     :: little-float-32,
      frame            :: little-unsigned-integer-32,
      player_car_index :: little-unsigned-integer-8,
      rest             :: binary
    >> = data

    %Header{format: format,
            version: version,
            packet_id: packet_id,
            session_id: session_id,
            session_time: session_time,
            frame: frame,
            player_car_index: player_car_index}
    |> parse(rest)
  end

  # Packet ids
  # 0 motion
  # 1 session
  # 2 lap
  # 3 event
  # 4 participants
  # 5 car setups
  # 6 car telemetry
  # 7 car status

  def parse(%Header{packet_id: 1} = header, data), do: {:session, header, Session.parse(data)}
  def parse(%Header{packet_id: 2} = header, data), do: {:lap, header, Lap.parse(data)}
  def parse(%Header{packet_id: 6} = header, data), do: {:telemetry, header, Telemetry.parse(data)}
  def parse(%Header{packet_id: 7} = header, data), do: {:status, header, Status.parse(data)}
  def parse(_, _), do: :ok
end
