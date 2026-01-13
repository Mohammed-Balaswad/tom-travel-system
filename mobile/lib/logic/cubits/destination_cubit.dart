import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/data/repositories/destination_repository.dart';
import 'package:tom_travel_app/logic/states/destination_states.dart';


class DestinationCubit extends Cubit<DestinationState> {
  final DestinationRepository repo;

  DestinationCubit(this.repo) : super(DestinationInitial());

  Future<void> fetchDestinations() async {
    emit(DestinationLoading());
    try {
      final destinations = await repo.getDestinations();
      emit(DestinationLoaded(destinations));
    } catch (e) {
      emit(DestinationError(e.toString()));
    }
  }
}
