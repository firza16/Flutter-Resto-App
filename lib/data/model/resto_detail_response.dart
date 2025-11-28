import 'package:resto_app/data/model/resto.dart';

class RestoDetailResponse {
  final bool error;
  final String message;
  final Resto restaurant;

  RestoDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestoDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestoDetailResponse(
      error: json["error"],
      message: json["message"],
      restaurant: Resto.fromJson(json["restaurant"]),
    );
  }
}
