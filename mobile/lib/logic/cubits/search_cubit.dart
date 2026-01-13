import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/data/models/search_result_model.dart';
import 'package:tom_travel_app/data/repositories/search_repository.dart';

class SearchCubit extends Cubit<List<SearchResultModel>> {
  final SearchRepository _repo;
  Timer? _debounce;

  SearchCubit(this._repo) : super([]);

  void search(String q) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (q.trim().length < 2) {
        emit([]);
        return;
      }
      try {
        final results = await _repo.search(q.trim());
        // نريد فقط الحقول الخفيفة (كما طلبت): title,type,image,subtitle
        emit(results);
      } catch (e) {
        emit([]);
      }
    });
  }

  void clear() {
    _debounce?.cancel();
    emit([]);
  }
}
