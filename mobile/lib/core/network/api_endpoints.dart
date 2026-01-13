class ApiEndpoints {
  static const String baseUrl = "http://192.168.0.109:8000/api";

  // Auth
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String logout = "$baseUrl/logout";
  static const String userProfile = "$baseUrl/profile";


  // Search
   static const String search = "/search";

  // Hotels
  static const String hotels = "$baseUrl/hotels";
  static String hotelById(int id) => "$baseUrl/hotels/$id";

  // Flights
  static const String flights = "$baseUrl/flights";
  static String flightById(int id) => "$baseUrl/flights/$id";

  // Bookings
  static const String hotelBookings = "$baseUrl/hotel-bookings";
  static const String flightBookings = "$baseUrl/flight-bookings";

  // My Trips
  static const String myTrips = "$baseUrl/my-trips";

  // Destinations
  static const String destinations = "$baseUrl/destinations";
  static String destinationById(int id) => "$baseUrl/destinations/$id";

  // Restaurants & Dishes
  static const String restaurants = "$baseUrl/restaurants";
  static String restaurantById(int id) => "$baseUrl/restaurants/$id";
  static const String dishes = "$baseUrl/dishes";

  // Attractions
  static const String attractions = "$baseUrl/attractions";
  static String attractionById(int id) => "$baseUrl/attractions/$id";

  // Reviews
  static const String reviews = "$baseUrl/reviews";

  // Favorites
  static const String favorites = "$baseUrl/favorites";
  static String deleteFavorite(int id) => "$baseUrl/favorites/$id";


  // Notifications
  static const String notifications = "$baseUrl/notifications";
}
