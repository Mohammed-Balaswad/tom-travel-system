import 'package:tom_travel_app/data/models/my_trips_model.dart';

abstract class MyTripsState {}

class MyTripsInitial extends MyTripsState {}

class MyTripsLoading extends MyTripsState {}

class MyTripsLoaded extends MyTripsState {
  final MyTripsModel trips;
  MyTripsLoaded(this.trips);
}

class MyTripsError extends MyTripsState {
  final String message;
  MyTripsError(this.message);
}