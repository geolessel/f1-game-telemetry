defmodule F1GameTelemetry.V2018.Lap do
  # float       m_lastLapTime;           // Last lap time in seconds
  # float       m_currentLapTime;        // Current time around the lap in seconds
  # float       m_bestLapTime;           // Best lap time of the session in seconds
  # float       m_sector1Time;           // Sector 1 time in seconds
  # float       m_sector2Time;           // Sector 2 time in seconds
  # float       m_lapDistance;           // Distance vehicle is around current lap in metres – could
  #                                      // be negative if line hasn’t been crossed yet
  # float       m_totalDistance;         // Total distance travelled in session in metres – could
  #                                      // be negative if line hasn’t been crossed yet
  # float       m_safetyCarDelta;        // Delta in seconds for safety car
  # uint8       m_carPosition;           // Car race position
  # uint8       m_currentLapNum;         // Current lap number
  # uint8       m_pitStatus;             // 0 = none, 1 = pitting, 2 = in pit area
  # uint8       m_sector;                // 0 = sector1, 1 = sector2, 2 = sector3
  # uint8       m_currentLapInvalid;     // Current lap invalid - 0 = valid, 1 = invalid
  # uint8       m_penalties;             // Accumulated time penalties in seconds to be added
  # uint8       m_gridPosition;          // Grid position the vehicle started the race in
  # uint8       m_driverStatus;          // Status of driver - 0 = in garage, 1 = flying lap
  #                                      // 2 = in lap, 3 = out lap, 4 = on track
  # uint8       m_resultStatus;          // Result status - 0 = invalid, 1 = inactive, 2 = active
  #                                      // 3 = finished, 4 = disqualified, 5 = not classified
  #                                      // 6 = retired

  defstruct last_lap_time: 0.0,
            current_lap_time: 0.0,
            best_lap_time: 0.0,
            sector_1_time: 0.0,
            sector_2_time: 0.0,
            lap_distance: 0.0,
            total_distance: 0.0,
            safety_car_delta: 0.0,
            car_position: 0,
            current_lap_number: 0,
            pit_status: 0,
            sector: 0,
            current_lap_invalid: 0,
            penalties: 0,
            grid_position: 0,
            driver_status: 0,
            result_status: 0

  def parse(<<
        last_lap_time::little-float-32,
        current_lap_time::little-float-32,
        best_lap_time::little-float-32,
        sector_1_time::little-float-32,
        sector_2_time::little-float-32,
        lap_distance::little-float-32,
        total_distance::little-float-32,
        safety_car_delta::little-float-32,
        car_position::little-unsigned-integer-8,
        current_lap_number::little-unsigned-integer-8,
        pit_status::little-unsigned-integer-8,
        sector::little-unsigned-integer-8,
        current_lap_invalid::little-unsigned-integer-8,
        penalties::little-unsigned-integer-8,
        grid_position::little-unsigned-integer-8,
        driver_status::little-unsigned-integer-8,
        result_status::little-unsigned-integer-8,
        rest::binary
      >>) do
    [
      %__MODULE__{
        last_lap_time: last_lap_time,
        current_lap_time: current_lap_time,
        best_lap_time: best_lap_time,
        sector_1_time: sector_1_time,
        sector_2_time: sector_2_time,
        lap_distance: lap_distance,
        total_distance: total_distance,
        safety_car_delta: safety_car_delta,
        car_position: car_position,
        current_lap_number: current_lap_number,
        pit_status: pit_status,
        sector: sector,
        current_lap_invalid: current_lap_invalid,
        penalties: penalties,
        grid_position: grid_position,
        driver_status: driver_status,
        result_status: result_status
      }
      | parse(rest)
    ]
  end

  def parse(_), do: []

  def test_data do
    <<
0xe2, 0x07, 0x01, 0x02, 0xb8, 0x3c, 0xa4, 0x04, 0x3f, 0x54, 0xd8, 0xba, 0x5e, 0xd0, 0x13, 0x42, 0xa2, 0x01, 0x00, 0x00, 0x13, 0x00, 0x00, 0x00, 0x00, 0xbe, 0xab, 0xcc, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa8, 0xed, 0xc1, 0x00, 0xa8, 0xed, 0xc1, 0x00, 0x00, 0x00, 0x80, 0x0f, 0x01, 0x00, 0x00, 0x00, 0x02, 0x0a, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x37, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x74, 0xc3, 0x41, 0x00, 0x00, 0x00, 0x00, 0x02, 0x97, 0xac, 0x44, 0x02, 0x97, 0xac, 0x44, 0x00, 0x00, 0x00, 0x80, 0x01, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x14, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0xd8, 0xc1, 0x00, 0x04, 0xd8, 0xc1, 0x00, 0x00, 0x00, 0x80, 0x07, 0x01, 0x00, 0x00, 0x00, 0x04, 0x06, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x91, 0x20, 0x80, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xb5, 0xa0, 0xc2, 0xc0, 0xb5, 0xa0, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x0a, 0x01, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x40, 0xae, 0x9e, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x62, 0x40, 0xc2, 0x80, 0x62, 0x40, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x0b, 0x01, 0x00, 0x00, 0x00, 0x00, 0x0f, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x51, 0x05, 0xca, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xb9, 0x10, 0xc2, 0x80, 0xb9, 0x10, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x12, 0x01, 0x00, 0x00, 0x00, 0x00, 0x0d, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x37, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0xc6, 0xe3, 0xc6, 0x41, 0x00, 0x00, 0x00, 0x00, 0x78, 0x90, 0xa9, 0x44, 0x78, 0x90, 0xa9, 0x44, 0x00, 0x00, 0x00, 0x80, 0x02, 0x01, 0x00, 0x01, 0x00, 0x00, 0x01, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x9c, 0x4b, 0x3a, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xe4, 0x86, 0xc2, 0xc0, 0xe4, 0x86, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x0d, 0x01, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0xc5, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x67, 0xfe, 0xc1, 0x00, 0x67, 0xfe, 0xc1, 0x00, 0x00, 0x00, 0x80, 0x10, 0x01, 0x00, 0x00, 0x00, 0x00, 0x09, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x37, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0x45, 0xd0, 0xcc, 0x41, 0x00, 0x00, 0x00, 0x00, 0x19, 0xbf, 0xa4, 0x44, 0x19, 0xbf, 0xa4, 0x44, 0x00, 0x00, 0x00, 0x80, 0x04, 0x01, 0x00, 0x01, 0x00, 0x00, 0x05, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x14, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xb4, 0x2c, 0xc2, 0x80, 0xb4, 0x2c, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x0c, 0x01, 0x00, 0x00, 0x00, 0x00, 0x11, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x39, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0x4d, 0xe9, 0xd0, 0x41, 0x00, 0x00, 0x00, 0x00, 0x9d, 0x56, 0xa2, 0x44, 0x9d, 0x56, 0xa2, 0x44, 0x00, 0x00, 0x00, 0x80, 0x05, 0x01, 0x00, 0x01, 0x00, 0x00, 0x07, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0xcb, 0x21, 0xce, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x25, 0xc2, 0x80, 0x00, 0x25, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x14, 0x01, 0x00, 0x00, 0x00, 0x00, 0x13, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0xcb, 0x21, 0xce, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0x0e, 0xc2, 0x00, 0xfe, 0x0e, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x11, 0x01, 0x00, 0x00, 0x00, 0x00, 0x10, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x14, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xcf, 0x03, 0xc2, 0x80, 0xcf, 0x03, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x12, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x38, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0x39, 0xf3, 0xc9, 0x41, 0x00, 0x00, 0x00, 0x00, 0xf9, 0xf2, 0xa6, 0x44, 0xf9, 0xf2, 0xa6, 0x44, 0x00, 0x00, 0x00, 0x80, 0x03, 0x01, 0x00, 0x01, 0x00, 0x00, 0x03, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x50, 0x2f, 0x96, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x10, 0x24, 0xc2, 0x80, 0x10, 0x24, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x09, 0x01, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0xd6, 0xb9, 0xec, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0xc9, 0xc1, 0x00, 0x3e, 0xc9, 0xc1, 0x00, 0x00, 0x00, 0x80, 0x0e, 0x01, 0x00, 0x00, 0x00, 0x00, 0x04, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x0a, 0x9a, 0xc5, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x31, 0x14, 0xc2, 0x00, 0x31, 0x14, 0xc2, 0x00, 0x00, 0x00, 0x80, 0x13, 0x01, 0x00, 0x00, 0x00, 0x00, 0x0b, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x14, 0xd8, 0xf1, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x57, 0xb8, 0xc1, 0x00, 0x57, 0xb8, 0xc1, 0x00, 0x00, 0x00, 0x80, 0x06, 0x01, 0x00, 0x00, 0x00, 0x00, 0x02, 0x04, 0x02
    >>
  end
end
