// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/data/models/flight_booking_model.dart';
import 'package:tom_travel_app/data/models/hotel_booking_model.dart';
import 'package:tom_travel_app/data/models/my_trips_model.dart';
import 'package:tom_travel_app/logic/cubits/my_trips_cubit.dart';
import 'package:tom_travel_app/logic/states/my_trips_states.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  bool showFlights = true;

  @override
  void initState() {
    super.initState();
    context.read<MyTripsCubit>().fetchMyTrips();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: BlocBuilder<MyTripsCubit, MyTripsState>(
          builder: (context, state) {
            if (state is MyTripsLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.white,));
            }
        
            if (state is MyTripsError) {
              return Center(child: Text(state.message));
            }
        
            if (state is MyTripsLoaded) {
              return _buildMainUI(state.trips);
            }
        
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  //====================================================================
  //                         MAIN UI (OLD DESIGN)
  //====================================================================

  Widget _buildMainUI(MyTripsModel trips) {
    return AppBackground(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            
             Text(
              "My Trip",
              style: AppTextStyles.heading.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            
            const SizedBox(height: 30),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _topButton("Flights", showFlights, () {
                  setState(() => showFlights = true);
                }),
                const SizedBox(width: 16),
                _topButton("Hotels", !showFlights, () {
                  setState(() => showFlights = false);
                }),
              ],
            ),
            
            const SizedBox(height: 20),
            
            Expanded(
              child: showFlights
                  ? _buildFlightsList(trips.flightBookings)
                  : _buildHotelsList(trips.hotelBookings),
            ),
          ],
        ),
      ),
    );
  }

  //====================================================================
  //!                        TOP SWITCH BUTTONS
  //====================================================================

  Widget _topButton(String title, bool selected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Colors.white : Colors.white70,
          width: selected ? 2 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Text(
        title,
        style: AppTextStyles.heading.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: selected ? AppColors.navyBlue : Colors.white,
        ),
      ),
    ),
  );
}

  //====================================================================
  //!                        FLIGHTS (WITH API DATA)
  //====================================================================

  Widget _buildFlightsList(List<FlightBookingModel> flights) {
    if (flights.isEmpty) {
      return const Center(
        child: Text("No Flights Found", style: TextStyle(color: Colors.white)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: flights.map((f) {
          final flight = f.flight!;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _flightCard(
                  airline: flight.airline,
                  flightNumber: flight.flightNumber ?? "N/A",
                  aircraftModel: flight.aircraftModel ?? "Unknown",
                  status: f.status,
                  statusColor:
                      f.status == "confirmed" ? Colors.green : Colors.orange,
                  fromTime: _formatTime(flight.departureTime),
                  toTime: _formatTime(flight.arrivalTime),
                  fromAirport: flight.departureCity,
                  toAirport: flight.arrivalCity,
                  duration: flight.duration ?? "Unknown",
                  baggage: flight.baggagePolicy?['checked'] ?? "N/A",
                  seatClass: f.seatClass ?? "Economy",

                  price: f.totalPrice,
                  imagePath: flight.image ?? "",
                ),
          );
        }).toList(),
      ),
    );
  }

Widget _flightCard({
  required String airline,
  required String flightNumber,
  required String aircraftModel,
  required String status,
  required Color statusColor,
  required String fromTime,
  required String toTime,
  required String fromAirport,
  required String toAirport,
  required String duration,
  required String baggage,
  required String seatClass,
  required double price,
  required String imagePath,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =================== Top Row =====================
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with rounded corner shape like the design
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: imagePath.isNotEmpty
                    ? NetworkImage(imagePath)
                    : const AssetImage('assets/images/destinations/Altea.png')
                        as ImageProvider,
                width: 95,
                height: 110,
                fit: BoxFit.fill
              ),
            ),

            const SizedBox(width: 12),

            // Airline + flight number + model
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    airline,
                    style:  AppTextStyles.heading.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColors.navyBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$flightNumber • $aircraftModel",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // ================== Time Section ===================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _timeColumn(fromTime, fromAirport),

            // Center plane icon & duration
            Column(
              children: [
                const Icon(Icons.flight, size: 26, color: AppColors.navyBlue),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            _timeColumn(toTime, toAirport),
          ],
        ),

        const SizedBox(height: 22),

        // ================== Info Tags ===================
        Row(
          children: [
            _iconTag(
              icon: Icons.luggage,
              text: baggage,
            ),
            const SizedBox(width: 18),
            _iconTag(
              icon: Icons.event_seat,
              text: seatClass,
            ),
            const SizedBox(width: 18),
          ],
        ),

        const SizedBox(height: 22),

        // ================= Price ====================
       Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: "\$ ${price.toStringAsFixed(0)} USD ",
        style:  AppTextStyles.button.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color:AppColors.navyBlue,
        ),
      ),
      TextSpan(
        text: "/total",
        style:  AppTextStyles.button.copyWith(
          fontSize: 13, // أصغر
          fontWeight: FontWeight.w400,
          color: AppColors.navyBlue.withOpacity(0.6), // شفاف
        ),
      ),
    ],
  ),
)
      ],
    ),
  );
}


Widget _timeColumn(String time, String airport) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        time,
        style:  AppTextStyles.button.copyWith(
          fontSize: 22,
          color: AppColors.navyBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 6),
      SizedBox(
        width: 110,
        child: Text(
          airport,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ),
    ],
  );
}
Widget _iconTag({required IconData icon, required String text}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.09),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: AppColors.navyBlue),
        const SizedBox(width: 6),
        Text(
          text,
          style:  AppTextStyles.button.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: AppColors.navyBlue,
          ),
        ),
      ],
    ),
  );
}

  String _formatTime(String dt) {
    final d = DateTime.parse(dt);
    return "${d.hour}:${d.minute.toString().padLeft(2, '0')}";
  }

  //====================================================================
  //!                    HOTELS (WITH API DATA)
  //====================================================================

  Widget _buildHotelsList(List<HotelBookingModel> hotels) {
    if (hotels.isEmpty) {
      return const Center(
        child: Text("No Hotel Bookings", style: TextStyle(color: Colors.white)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: hotels.map((h) {
          final hotel = h.hotel!;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _hotelCard(
              imagePath: hotel.image ?? "",
              hotelName: hotel.name,
              price: "\$${h.totalPrice} USD",
              rating: "${hotel.averageRating}",
              description: hotel.description ?? "",
              location: "${hotel.destination.country}, ${hotel.destination.name}",
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _hotelCard({
    required String imagePath,
    required String hotelName,
    required String price,
    required String rating,
    required String description,
    required String location,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: Image(
              image: imagePath.isNotEmpty
                  ? NetworkImage(imagePath)
                  : const AssetImage('assets/images/destinations/Altea.png') as ImageProvider,
              fit: BoxFit.cover,
              height: 183,
            ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style:  AppTextStyles.heading.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style:  AppTextStyles.heading.copyWith(
                      fontSize: 14,
                      color: AppColors.navyBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/star_icon.svg', 
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style:  AppTextStyles.heading.copyWith(
                          fontSize: 13,
                          color: AppColors.navyBlue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/location_icon.svg',
                        color: AppColors.navyBlue,
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style:  AppTextStyles.heading.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navyBlue,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
