import 'dart:convert';

import 'package:resto_app/data/model/resto_detail_response.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestoListResponse> getrestoList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestoListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load resto list');
    }
  }

  Future<RestoDetailResponse> getRestoDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestoDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load resto detail');
    }
  }
}