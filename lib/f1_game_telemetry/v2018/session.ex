defmodule F1GameTelemetry.V2018.Session do
  # uint8           m_weather;              	// Weather - 0 = clear, 1 = light cloud, 2 = overcast
  #                                         	// 3 = light rain, 4 = heavy rain, 5 = storm
  # int8	    m_trackTemperature;    	// Track temp. in degrees celsius
  # int8	    m_airTemperature;      	// Air temp. in degrees celsius
  # uint8           m_totalLaps;           	// Total number of laps in this race
  # uint16          m_trackLength;           	// Track length in metres
  # uint8           m_sessionType;         	// 0 = unknown, 1 = P1, 2 = P2, 3 = P3, 4 = Short P
  #                                         	// 5 = Q1, 6 = Q2, 7 = Q3, 8 = Short Q, 9 = OSQ
  #                                         	// 10 = R, 11 = R2, 12 = Time Trial
  # int8            m_trackId;         		// -1 for unknown, 0-21 for tracks, see appendix
  # uint8           m_era;                  	// Era, 0 = modern, 1 = classic
  # uint16          m_sessionTimeLeft;    	// Time left in session in seconds
  # uint16          m_sessionDuration;     	// Session duration in seconds
  # uint8           m_pitSpeedLimit;      	// Pit speed limit in kilometres per hour
  # uint8           m_gamePaused;               // Whether the game is paused
  # uint8           m_isSpectating;        	// Whether the player is spectating
  # uint8           m_spectatorCarIndex;  	// Index of the car being spectated
  # uint8           m_sliProNativeSupport;	// SLI Pro support, 0 = inactive, 1 = active
  # uint8           m_numMarshalZones;         	// Number of marshal zones to follow
  # MarshalZone     m_marshalZones[21];         // List of marshal zones – max 21
  # uint8           m_safetyCarStatus;          // 0 = no safety car, 1 = full safety car
  #                                             // 2 = virtual safety car
  # uint8          m_networkGame;              // 0 = offline, 1 = online

  defstruct [
    weather: 0,
    track_temp: 0,
    air_temp: 0,
    total_laps: 0,
    track_length: 0,
    session_type: 0,
    track_id: -1,
    era: 0,
    session_time_left: 0,
    session_duration: 0,
    pit_speed_limit: 0,
    game_paused: 0,
    player_is_spectating: 0,
    spectator_car_index: 0,
    sli_pro_native_support: 0,
    num_marshal_zones: 0,
    marshal_zones: [],
    safety_car_status: 0,
    network_game: 0
  ]

  def parse(
    <<
      weather             :: little-unsigned-integer-8,
      track_temp          :: little-signed-integer-8,
      air_temp            :: little-signed-integer-8,
      total_laps          :: little-signed-integer-8,
      track_length        :: little-unsigned-integer-16,
      session_type        :: little-unsigned-integer-8,
      track_id            :: little-signed-integer-8,
      era                 :: little-unsigned-integer-8,
      session_time_left   :: little-unsigned-integer-16,
      session_duration    :: little-unsigned-integer-16,
      pit_speed_limit     :: little-unsigned-integer-8,
      game_paused         :: little-unsigned-integer-8,
      is_spectating       :: little-unsigned-integer-8,
      spectator_car_index :: little-unsigned-integer-8,
      num_marshal_zones   :: little-unsigned-integer-8,
      rest                :: binary
    >>
  ) do
    # {marshal_zones, rest} = parse(:marshal_zones, num_marshal_zones, rest)
    # <<
    #   safety_car_status :: little-unsigned-integer-8,
    #   network_game      :: little-unsigned-integer-8
    # >> = rest

    %__MODULE__{
      weather: weather,
      track_temp: track_temp,
      air_temp: air_temp,
      total_laps: total_laps,
      track_length: track_length,
      session_type: session_type,
      track_id: track_id,
      era: era,
      session_time_left: session_time_left,
      session_duration: session_duration,
      pit_speed_limit: pit_speed_limit,
      game_paused: game_paused,
      player_is_spectating: is_spectating,
      spectator_car_index: spectator_car_index,
      num_marshal_zones: num_marshal_zones,
      # marshal_zones: marshal_zones,
      # safety_car_status: safety_car_status,
      # network_game: network_game
    }
  end

  # def parse(:marshal_zones, -1, rest), do: {:done, rest}
  # def parse(:marshal_zones, num_marshal_zones, data) do
  #   <<
  #     zone_start :: little-float-32,
  #     zone_flag :: little-unsigned-integer-8,
  #     rest :: binary
  #   >> = data

  #   [
  #     %{
  #       zone_start: zone_start,
  #       zone_flag: zone_flag
  #     }
  #     |
  #     parse(:marshal_zones, num_marshal_zones - 1, rest)
  #   ]
  # end

  #   {marshal_zones, rest}

  #   Enum.flat_map_reduce(1..num_marshal_zones, [], fn(data, acc) ->
  #     <<
  #     zone_start :: little-float-32,
  #     zone_flag :: little-unsighed-integer-8,
  #     rest :: binary
  #   end)
  #   [
  #     %{
  #       zone_start: zone_start,
  #       zone_flag: zone_flag
  #     }
  #     |
  #     parse(:marshal_zones, rest)
  #   ]
  # end

  # def parse(:marshal_zones, []), do: []
end
