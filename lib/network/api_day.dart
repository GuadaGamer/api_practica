import 'dart:convert';

import 'package:api_practica/models/today_model.dart';
import 'package:http/http.dart' as http;

class ApiNasaToday {
  Uri link = Uri.parse(
      'https://api.nasa.gov/planetary/apod?api_key=YDwZ3GsTycZUr3vUvq5w5OFnpQ0lh5TWXhebNhDY');

  Future<TodayNasaModel?> getTodayNasa() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body);
    if (result.statusCode == 200) {
      return TodayNasaModel.fromMap(listJSON as Map<String, dynamic>);
    }
    return null;
  }
}
