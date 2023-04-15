import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/image_api_model.dart';

class NasaApiImages {
  Future<List<ImageApiModel>?> getImagesApi(String busqueda) async {
    try {
      final url = Uri.parse(
          'https://images-api.nasa.gov/search?q=$busqueda&media_type=image');

      final resp = await http.get(url);
      var list = jsonDecode(resp.body)['collection']['items'] as List;
      if (resp.statusCode == 200) {
        return list.map((image) => ImageApiModel.fromJson(image)).toList();
      }
      return null;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
