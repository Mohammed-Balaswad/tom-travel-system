class FlightModel {
  final int id;
  final String airline;
  final String? flightNumber;
  final String? aircraftModel;
  final String? image;
  final String departureCity;
  final String arrivalCity;
  final String? departureAirport;
  final String? arrivalAirport;
  final String departureTime;
  final String arrivalTime;
  final String? duration;
  final String cabinClass;
  final Map<String, dynamic>? baggagePolicy;
  final List<String>? amenities;
  final double price;
  final int availableSeats;

  FlightModel({
    required this.id,
    required this.airline,
    this.flightNumber,
    this.aircraftModel,
    this.image,
    required this.departureCity,
    required this.arrivalCity,
    this.departureAirport,
    this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    this.duration,
    required this.cabinClass,
    this.baggagePolicy,
    this.amenities,
    required this.price,
    required this.availableSeats,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'],
      airline: json['airline'] ?? '',
      flightNumber: json['flight_number'],
      aircraftModel: json['aircraft_model'],
      image: json['image'],
      departureCity: json['departure_city'],
      arrivalCity: json['arrival_city'],
      departureAirport: json['departure_airport'],
      arrivalAirport: json['arrival_airport'],
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      duration: json['duration'],
      cabinClass: json['cabin_class'] ?? 'Economy',
      baggagePolicy: (json['baggage_policy'] != null && json['baggage_policy'] is Map<String, dynamic>)
    ? Map<String, dynamic>.from(json['baggage_policy'])
    : null,
     amenities: (json['amenities'] != null && json['amenities'] is List)
    ? List<String>.from(json['amenities'])
    : null,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      availableSeats: json['available_seats'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "airline": airline,
        "flight_number": flightNumber,
        "aircraft_model": aircraftModel,
        "image": image,
        "departure_city": departureCity,
        "arrival_city": arrivalCity,
        "departure_airport": departureAirport,
        "arrival_airport": arrivalAirport,
        "departure_time": departureTime,
        "arrival_time": arrivalTime,
        "duration": duration,
        "cabin_class": cabinClass,
        "baggage_policy": baggagePolicy,
        "amenities": amenities,
        "price": price,
        "available_seats": availableSeats,
      };
}
