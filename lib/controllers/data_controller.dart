import 'package:firebase_authentication/services/api_service.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var isLoading = true.obs;
  var fact = ''.obs;

  final ApiService _apiService = ApiService();

  void fetchDataCat() async {
    isLoading(true);

    try {
      var response = await _apiService.fetchData();
      if (response.status.code == 200) {
        var data = response.body;
        fact(data['fact']);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      fact('');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchDataCat();
    super.onInit();
  }
}