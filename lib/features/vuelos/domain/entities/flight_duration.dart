class FlightDuration {
  final String totalFlightTime;
  final String flightTime;
  final String layoverTime;
  final List<String> layoverDurations;

  FlightDuration({
    required this.totalFlightTime,
    required this.flightTime,
    required this.layoverTime,
    required this.layoverDurations,
  });
}
