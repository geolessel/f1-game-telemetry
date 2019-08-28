defmodule F1GameTelemetry.V2018.Status do
  # uint8       m_tractionControl;          // 0 (off) - 2 (high)
  # uint8       m_antiLockBrakes;           // 0 (off) - 1 (on)
  # uint8       m_fuelMix;                  // Fuel mix - 0 = lean, 1 = standard, 2 = rich, 3 = max
  # uint8       m_frontBrakeBias;           // Front brake bias (percentage)
  # uint8       m_pitLimiterStatus;         // Pit limiter status - 0 = off, 1 = on
  # float       m_fuelInTank;               // Current fuel mass
  # float       m_fuelCapacity;             // Fuel capacity
  # uint16      m_maxRPM;                   // Cars max RPM, point of rev limiter
  # uint16      m_idleRPM;                  // Cars idle RPM
  # uint8       m_maxGears;                 // Maximum number of gears
  # uint8       m_drsAllowed;               // 0 = not allowed, 1 = allowed, -1 = unknown
  # uint8       m_tyresWear[4];             // Tyre wear percentage
  # uint8       m_tyreCompound;             // Modern - 0 = hyper soft, 1 = ultra soft
  #                                         // 2 = super soft, 3 = soft, 4 = medium, 5 = hard
  #                                         // 6 = super hard, 7 = inter, 8 = wet
  #                                         // Classic - 0-6 = dry, 7-8 = wet
  # uint8       m_tyresDamage[4];           // Tyre damage (percentage)
  # uint8       m_frontLeftWingDamage;      // Front left wing damage (percentage)
  # uint8       m_frontRightWingDamage;     // Front right wing damage (percentage)
  # uint8       m_rearWingDamage;           // Rear wing damage (percentage)
  # uint8       m_engineDamage;             // Engine damage (percentage)
  # uint8       m_gearBoxDamage;            // Gear box damage (percentage)
  # uint8       m_exhaustDamage;            // Exhaust damage (percentage)
  # int8        m_vehicleFiaFlags;          // -1 = invalid/unknown, 0 = none, 1 = green
  #                                         // 2 = blue, 3 = yellow, 4 = red
  # float       m_ersStoreEnergy;           // ERS energy store in Joules
  # uint8       m_ersDeployMode;            // ERS deployment mode, 0 = none, 1 = low, 2 = medium
  #                                         // 3 = high, 4 = overtake, 5 = hotlap
  # float       m_ersHarvestedThisLapMGUK;  // ERS energy harvested this lap by MGU-K
  # float       m_ersHarvestedThisLapMGUH;  // ERS energy harvested this lap by MGU-H
  # float       m_ersDeployedThisLap;       // ERS energy deployed this lap

  @initial_wear %{front: %{left: 0, right: 0}, rear: %{left: 0, right: 0}}
  @initial_damage %{front: %{left: 0, right: 0}, rear: %{left: 0, right: 0}}

  defstruct [
    traction_control: 0,
    antilock_brakes: 0,
    fuel_mix: 0,
    front_brake_bias: 50,
    pit_limiter_status: 0,
    fuel_in_tank: 0.0,
    fuel_capacity: 0.0,
    max_rpm: 0,
    max_gears: 0,
    drs_allowed: -1,
    tires_wear: @initial_wear,
    tire_compound: 0,
    tires_damage: @initial_damage,
    front_left_wing_damage: 0,
    front_right_wing_damage: 0,
    rear_wing_damage: 0,
    engine_damage: 0,
    gearbox_damage: 0,
    exhaust_damage: 0,
    vehicle_fia_flags: -1,
    ers_store_energy: 0.0,
    ers_deploy_mode: 0,
    ers_harvested_this_lap_mgu_k: 0.0,
    ers_harvested_this_lap_mgu_h: 0.0,
    ers_harvested_this_lap: 0.0,
    ers_deployed_this_lap: 0.0
  ]

  def parse(
    <<
    traction_control             :: little-unsigned-integer-8,
    antilock_brakes              :: little-unsigned-integer-8,
    fuel_mix                     :: little-unsigned-integer-8,
    front_brake_bias             :: little-unsigned-integer-8,
    pit_limiter_status           :: little-unsigned-integer-8,
    fuel_in_tank                 :: little-float-32,
    fuel_capacity                :: little-float-32,
    max_rpm                      :: little-unsigned-integer-16,
    idle_rpm                     :: little-unsigned-integer-16,
    max_gears                    :: little-unsigned-integer-8,
    drs_allowed                  :: little-unsigned-integer-8,
    tire_wear_rl                 :: little-unsigned-integer-8,
    tire_wear_rr                 :: little-unsigned-integer-8,
    tire_wear_fl                 :: little-unsigned-integer-8,
    tire_wear_fr                 :: little-unsigned-integer-8,
    tire_compound                :: little-unsigned-integer-8,
    tire_damage_rl               :: little-unsigned-integer-8,
    tire_damage_rr               :: little-unsigned-integer-8,
    tire_damage_fl               :: little-unsigned-integer-8,
    tire_damage_fr               :: little-unsigned-integer-8,
    front_left_wing_damage       :: little-unsigned-integer-8,
    front_right_wing_damage      :: little-unsigned-integer-8,
    rear_wing_damage             :: little-unsigned-integer-8,
    engine_damage                :: little-unsigned-integer-8,
    gearbox_damage               :: little-unsigned-integer-8,
    exhaust_damage               :: little-unsigned-integer-8,
    vehicle_fia_flags            :: little-signed-integer-8,
    ers_store_energy             :: little-float-32,
    ers_deploy_mode              :: little-unsigned-integer-8,
    ers_harvested_this_lap_mgu_k :: little-float-32,
    ers_harvested_this_lap_mgu_h :: little-float-32,
    ers_deployed_this_lap        :: little-float-32,
    rest                         :: binary
    >>
  ) do
    [
      %__MODULE__{
        traction_control: traction_control,
        antilock_brakes: antilock_brakes,
        fuel_mix: fuel_mix,
        front_brake_bias: front_brake_bias,
        pit_limiter_status: pit_limiter_status,
        fuel_in_tank: fuel_in_tank,
        fuel_capacity: fuel_capacity,
        max_rpm: max_rpm,
        max_gears: max_gears,
        drs_allowed: drs_allowed,
        tires_wear: %{
          front: %{left: tire_wear_fl, right: tire_wear_fr},
          rear:  %{left: tire_wear_rl, right: tire_wear_rr}
        },
        tire_compound: tire_compound,
        tires_damage: %{
          front: %{left: tire_damage_fl, right: tire_damage_fr},
          rear:  %{left: tire_damage_rl, right: tire_damage_rr}
        },
        front_left_wing_damage: front_left_wing_damage,
        front_right_wing_damage: front_right_wing_damage,
        rear_wing_damage: rear_wing_damage,
        engine_damage: engine_damage,
        gearbox_damage: gearbox_damage,
        exhaust_damage: exhaust_damage,
        vehicle_fia_flags: vehicle_fia_flags,
        ers_store_energy: ers_store_energy,
        ers_deploy_mode: ers_deploy_mode,
        ers_harvested_this_lap_mgu_k: ers_harvested_this_lap_mgu_k,
        ers_harvested_this_lap_mgu_h: ers_harvested_this_lap_mgu_h,
        ers_harvested_this_lap: ers_harvested_this_lap_mgu_k + ers_harvested_this_lap_mgu_h,
        ers_deployed_this_lap: ers_deployed_this_lap
      }
      |
      parse(rest)
    ]
  end

  def parse(_), do: []
end
