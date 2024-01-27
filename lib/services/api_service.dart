import 'package:get/get.dart';

class ApiService extends GetConnect{
  Future<Response> fetchData() async {
    try {
      var response = await get("https://catfact.ninja/fact");
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}

