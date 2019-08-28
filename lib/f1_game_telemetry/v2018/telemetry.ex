defmodule F1GameTelemetry.V2018.Telemetry do
  # uint16    m_speed;                      // Speed of car in kilometres per hour
  # uint8     m_throttle;                   // Amount of throttle applied (0 to 100)
  # int8      m_steer;                      // Steering (-100 (full lock left) to 100 (full lock right))
  # uint8     m_brake;                      // Amount of brake applied (0 to 100)
  # uint8     m_clutch;                     // Amount of clutch applied (0 to 100)
  # int8      m_gear;                       // Gear selected (1-8, N=0, R=-1)
  # uint16    m_engineRPM;                  // Engine RPM
  # uint8     m_drs;                        // 0 = off, 1 = on
  # uint8     m_revLightsPercent;           // Rev lights indicator (percentage)
  # uint16    m_brakesTemperature[4];       // Brakes temperature (celsius)
  # uint16    m_tyresSurfaceTemperature[4]; // Tyres surface temperature (celsius)
  # uint16    m_tyresInnerTemperature[4];   // Tyres inner temperature (celsius)
  # uint16    m_engineTemperature;          // Engine temperature (celsius)
  # float     m_tyresPressure[4];           // Tyres pressure (PSI)

  @initial_temp %{front: %{left: 0, right: 0}, rear: %{left: 0, right: 0}}
  @initial_pressure %{front: %{left: 0.0, right: 0.0}, rear: %{left: 0.0, right: 0.0}}

  defstruct [
    speed: 0,
    throttle: 0,
    steer: 0,
    brake: 0,
    clutch: 0,
    gear: 0,
    engine_rpm: 0,
    drs: 0,
    rev_lights_percent: 0,
    brakes_temp: @initial_temp,
    tires_surface_temp: @initial_temp,
    tires_inner_temp: @initial_temp,
    engine_temp: 0,
    tires_pressure: @initial_pressure
  ]

  def parse(
    <<
    speed                :: little-unsigned-integer-16,
    throttle             :: little-unsigned-integer-8,
    steer                :: little-signed-integer-8,
    brake                :: little-unsigned-integer-8,
    clutch               :: little-unsigned-integer-8,
    gear                 :: little-signed-integer-8,
    engine_rpm           :: little-unsigned-integer-16,
    drs                  :: little-unsigned-integer-8,
    rev_lights_percent   :: little-unsigned-integer-8,
    brake_rl_temp        :: little-unsigned-integer-16,
    brake_rr_temp        :: little-unsigned-integer-16,
    brake_fl_temp        :: little-unsigned-integer-16,
    brake_fr_temp        :: little-unsigned-integer-16,
    tire_rl_surface_temp :: little-unsigned-integer-16,
    tire_rr_surface_temp :: little-unsigned-integer-16,
    tire_fl_surface_temp :: little-unsigned-integer-16,
    tire_fr_surface_temp :: little-unsigned-integer-16,
    tire_rl_inner_temp   :: little-unsigned-integer-16,
    tire_rr_inner_temp   :: little-unsigned-integer-16,
    tire_fl_inner_temp   :: little-unsigned-integer-16,
    tire_fr_inner_temp   :: little-unsigned-integer-16,
    engine_temp          :: little-unsigned-integer-16,
    tire_rl_pressure     :: little-float-32,
    tire_rr_pressure     :: little-float-32,
    tire_fl_pressure     :: little-float-32,
    tire_fr_pressure     :: little-float-32,
    rest                 :: binary
    >>
  ) do
    [
      %__MODULE__{
        speed: speed,
        throttle: throttle,
        steer: steer,
        brake: brake,
        clutch: clutch,
        gear: gear,
        engine_rpm: engine_rpm,
        drs: drs,
        rev_lights_percent: rev_lights_percent,
        brakes_temp: %{
          front: %{left: brake_fl_temp, right: brake_fr_temp},
          rear:  %{left: brake_rl_temp, right: brake_rr_temp}
        },
        tires_surface_temp: %{
          front: %{left: tire_fl_surface_temp, right: tire_fr_surface_temp},
          rear:  %{left: tire_rl_surface_temp, right: tire_rr_surface_temp}
        },
        tires_inner_temp: %{
          front: %{left: tire_fl_inner_temp, right: tire_fr_inner_temp},
          rear:  %{left: tire_rl_inner_temp, right: tire_rr_inner_temp}
        },
        engine_temp: engine_temp,
        tires_pressure: %{
          front: %{left: tire_fl_pressure, right: tire_fr_pressure},
          rear:  %{left: tire_rl_pressure, right: tire_rr_pressure}
        },
      }
      |
      parse(rest)
    ]
  end

  def parse(_), do: []
end
