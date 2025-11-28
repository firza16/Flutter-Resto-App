import 'package:resto_app/data/model/resto.dart';

class RestoListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Resto> restaurants;

  RestoListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestoListResponse.fromJson(Map<String, dynamic> json) {
    return RestoListResponse(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: json["restaurants"] != null
          ? List<Resto>.from(
              json["restaurants"]!.map((x) => Resto.fromJson(x)))
          : <Resto>[],
    );
  }
}
