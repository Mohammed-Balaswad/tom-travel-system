import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/data/repositories/hotel_repository.dart';
import 'package:tom_travel_app/logic/states/hotel_states.dart';


class HotelCubit extends Cubit<HotelState> {
  final HotelRepository repo;

  HotelCubit(this.repo) : super(HotelInitial());

  Future<void> fetchHotels() async {
    emit(HotelLoading());
    try {
      final hotels = await repo.getHotels();
      emit(HotelLoaded(hotels));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }
}
