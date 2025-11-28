// todo-03-detail-01: create a new provider to handle a detail api
import 'package:flutter/widgets.dart';
import 'package:resto_app/data/api/api_services.dart';
import 'package:resto_app/static/resto_detail_result_state.dart';

class RestoDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestoDetailProvider(
    this._apiServices,
  );

  RestoDetailResultState _resultState = RestoDetailNoneState();

  RestoDetailResultState get resultState => _resultState;

  Future<void> fetchRestoDetail(String id) async {
    try {
      _resultState = RestoDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestoDetail(id);

      if (result.error) {
        _resultState = RestoDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestoDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestoDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
