import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/data/repositories/my_trips_repository.dart';
import 'package:tom_travel_app/logic/states/my_trips_states.dart';

class MyTripsCubit extends Cubit<MyTripsState> {
  final MyTripsRepository repo;

  MyTripsCubit(this.repo) : super(MyTripsInitial());

  Future<void> fetchMyTrips() async {
  emit(MyTripsLoading());
  try {
    final trips = await repo.getMyTrips();
    
    emit(MyTripsLoaded(trips));
  } catch (e) {
    emit(MyTripsError(e.toString()));
  }
}
}