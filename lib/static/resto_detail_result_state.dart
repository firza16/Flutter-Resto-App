import 'package:resto_app/data/model/resto.dart';

sealed class RestoDetailResultState {}

class RestoDetailNoneState extends RestoDetailResultState {}

class RestoDetailLoadingState extends RestoDetailResultState {}

class RestoDetailErrorState extends RestoDetailResultState {
  final String error;

  RestoDetailErrorState(this.error);
}

class RestoDetailLoadedState extends RestoDetailResultState {
  final Resto data;

  RestoDetailLoadedState(this.data);
}
